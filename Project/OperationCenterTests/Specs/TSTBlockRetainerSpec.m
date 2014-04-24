#import <Kiwi/Kiwi.h>
#import "TSTBlockRetainer.h"

SPEC_BEGIN(TSTBlockRetainerSpec)

        describe(@"TSTBlockRetainer", ^{
            describe(@"Bad behavior", ^{
                it(@"causes a retain cycle", ^{
                    __weak TSTBlockRetainer *leakingObject = nil;
                    @autoreleasepool
                    {
                        TSTBlockRetainer *object = [[TSTBlockRetainer alloc] init];
                        [object setupBlocksWithRetainCycle:nil];
                        leakingObject = object;
                    }
                    [[leakingObject shouldNot] beNil];
                });

                it(@"deallocs the weak self during block execution", ^{
                    @autoreleasepool
                    {
                        __block int counter = 0;
                        __block BOOL performNilAction = NO;
                        __block TSTBlockRetainer *object = [[TSTBlockRetainer alloc] init];
                        [object setupBlocksWithWeakSelfOnly:^{
                            counter++;
                            if (performNilAction)
                            {
                                object = nil;
                            }
                        }];
                        BOOL (^extractedBlock)() = object.blockExecutingBlock;

                        [[theValue(extractedBlock()) should] beYes];
                        [[expectFutureValue(theValue(counter)) shouldEventually] equal:theValue(1)];

                        performNilAction = YES;
                        [[theValue(extractedBlock()) should] beNo];
                        [[expectFutureValue(theValue(counter)) shouldEventually] equal:theValue(2)];
                    }
                });
            });

            describe(@"Good behavior", ^{
                it(@"prevents a retain cycle", ^{
                    __weak TSTBlockRetainer *weakObject = nil;
                    @autoreleasepool
                    {
                        TSTBlockRetainer *object = [[TSTBlockRetainer alloc] init];
                        [object setupBlocksWithTwoStepReference:nil];
                        weakObject = object;
                    }
                    [[weakObject should] beNil];
                });

                it(@"strongly references `weakSelf` during block execution", ^{
                    __block int counter = 0;

                    @autoreleasepool
                    {
                        __block BOOL performNilAction = NO;
                        __block TSTBlockRetainer *object = [[TSTBlockRetainer alloc] init];
                        [object setupBlocksWithTwoStepReference:^{
                            counter++;
                            if (performNilAction)
                            {
                                object = nil;
                            }
                        }];
                        BOOL (^extractedBlock)() = object.blockExecutingBlock;

                        [[theValue(extractedBlock()) should] beYes];
                        [[expectFutureValue(theValue(counter)) shouldEventually] equal:theValue(1)];

                        performNilAction = YES;
                        [[theValue(extractedBlock()) should] beYes];
                        [[expectFutureValue(theValue(counter)) shouldEventually] equal:theValue(2)];
                    }
                });
            });
        });

        SPEC_END

#import <Kiwi/Kiwi.h>
#import "TSTLazyPropertiesOperation.h"

SPEC_BEGIN(EEEOperationSpec)

        describe(@"EEEOperation", ^{
            __block EEEInjector *injector;

            beforeEach(^{
                injector = [EEEInjector setCurrentInjector:[[EEEInjector alloc] init] force:YES];
            });

            describe(@"Lazily injected properties", ^{
                it(@"injects the fox, but not the dog", ^{
                    NSString *fox = @"The quick brown fox that jumps";
                    injector.mapClassWithIdentifier([NSString class], @"theQuickBrownFox").toObject(fox);

                    TSTLazyPropertiesOperation *sut = [[TSTLazyPropertiesOperation alloc] init];
                    [[sut.theQuickBrownFox should] equal:fox];
                    [[sut.theLazyDog should] beNil];
                });
            });
        });

        SPEC_END

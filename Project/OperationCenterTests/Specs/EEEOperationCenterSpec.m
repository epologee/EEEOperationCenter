#import <Kiwi/Kiwi.h>
#import "EEEOperationCenter.h"
#import "EEEOperation.h"

SPEC_BEGIN(EEEOperationCenterSpec)

        describe(@"EEEOperationCenter", ^{
            __block EEEInjector *injector;

            beforeEach(^{
                injector = [[EEEInjector alloc] init];
                [EEEInjector setCurrentInjector:injector force:YES];
            });

            describe(@"semi-singleton", ^{
                it(@"has no current operation center by default", ^{
                    [[[EEEOperationCenter currentOperationCenter] should] beNil];
                });

                it(@"initializes with an injector", ^{
                    EEEOperationCenter *sut = [[EEEOperationCenter alloc] initWithInjector:injector];
                    [[sut shouldNot] beNil];
                });

                it(@"initializes without an injector", ^{
                    EEEOperationCenter *sut = [[EEEOperationCenter alloc] init];
                    [[sut shouldNot] beNil];
                });

                it(@"accepts a current operation center", ^{
                    EEEOperationCenter *sut = [[EEEOperationCenter alloc] init];
                    [EEEOperationCenter setCurrentOperationCenter:sut];
                    [[[EEEOperationCenter currentOperationCenter] should] equal:sut];
                });
            });

            describe(@"with injector", ^{
                __block EEEOperationCenter *sut;

                beforeEach(^{
                    sut = [[EEEOperationCenter alloc] initWithInjector:injector];
                    sut.mainCommandQueue = [NSOperationQueue nullMock];
                });

                it(@"passes the injector to queued operations", ^{
                    id mockOperation = [EEEOperation mock];
                    [mockOperation stub:@selector(requiresMainThread) andReturn:theValue(YES)];

                    [[mockOperation should] receive:@selector(setInjector:) withArguments:injector];

                    [sut queueOperation:mockOperation];
                });
            });

            describe(@"without injector", ^{
                __block EEEOperationCenter *sut;

                beforeEach(^{
                    sut = [[EEEOperationCenter alloc] init];
                    sut.mainCommandQueue = [NSOperationQueue nullMock];
                });

                it(@"does not call setInjector: on operations", ^{
                    id mockOperation = [EEEOperation mock];
                    [mockOperation stub:@selector(requiresMainThread) andReturn:theValue(YES)];

                    [sut queueOperation:mockOperation];
                });
            });
        });

        SPEC_END

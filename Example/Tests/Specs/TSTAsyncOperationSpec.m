#import <EEEOperationCenter/EEEOperationCenter.h>
#import "TSTAsyncOperation.h"
#import "KWSpec+OperationCenter.h"

SPEC_BEGIN(TSTAsyncOperationSpec)
    beforeEach(^{
        EEEInjector *injector = [EEEInjector setCurrentInjector:[[EEEInjector alloc] init] force:YES];
        [EEEOperationCenter setCurrentOperationCenter:[[EEEOperationCenter alloc] initWithInjector:injector]];
    });

    describe(@"TSTAsyncOperation", ^{
        it(@"operates asynchronously by enqueuing", ^{
            TSTAsyncOperation *sut = [[TSTAsyncOperation alloc] init];

            [[theValue(sut.isReady) should] beYes];
            [[theValue(sut.isAsynchronous) should] beYes];

            [[successfullyEnqueueOperation(sut) should] beYes];

            [[theValue(sut.isExecuting) should] beNo];
            [[theValue(sut.isFinished) should] beYes];
        });

        it(@"can still operate synchronously", ^{
            TSTAsyncOperation *sut = [[TSTAsyncOperation alloc] init];

            [[theValue(sut.isReady) should] beYes];
            [[theValue(sut.isAsynchronous) should] beYes];

            [sut operate];

            [[theValue(sut.isExecuting) should] beNo];
            [[theValue(sut.isFinished) should] beYes];
        });
    });
SPEC_END

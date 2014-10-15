#import <Kiwi/Kiwi.h>
#import "EEEAsyncOperation.h"

SPEC_BEGIN(EEEAsyncOperationSpec)
    describe(@"EEEAsyncOperation", ^{
        it(@"defaults to running on a background thread", ^{
            EEEAsyncOperation *sut = [[EEEAsyncOperation alloc] init];
            [[theValue(sut.requiresMainThread) should] beNo];
        });

        it(@"still defaults to running on a background thread, using the deprecated initializer", ^{
            EEEAsyncOperation *sut = [[EEEAsyncOperation alloc] initWithFeedback:nil];
            [[theValue(sut.requiresMainThread) should] beNo];
        });
    });
SPEC_END

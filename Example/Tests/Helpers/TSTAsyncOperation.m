#import "TSTAsyncOperation.h"

@implementation TSTAsyncOperation

- (void)execute
{
    [self dispatchSuccessfulFeedbackWithOptionalContext:nil];
}

@end
#import <Foundation/Foundation.h>
#import "Kiwi.h"

#define successfullyEnqueueOperationWithTimeout(operation, timeout) ^KWValue *(EEEAsyncOperation *subject){ \
                __block BOOL success = NO; \
                __block BOOL resumed = NO; \
                [subject enqueueWithFeedback:^(BOOL s, id object, NSError *error) { \
                    success = s; \
                    resumed = YES; \
                }]; \
                [[expectFutureValue(resumed ? @"resumed" : @"timed-out") shouldEventuallyBeforeTimingOutAfter(timeout)] equal:@"resumed"]; \
                return theValue(success); \
            }(operation)

#define successfullyEnqueueOperation(operation) successfullyEnqueueOperationWithTimeout(operation, 3)

@interface KWSpec (OperationCenter)
@end
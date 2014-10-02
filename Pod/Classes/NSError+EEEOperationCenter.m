#import "NSError+EEEOperationCenter.h"

NSString *const EEEOperationCenterErrorDomain = @"EEEOperationCenterErrorDomain";

__attribute__((deprecated))
NSString *const EEE_OPERATION_CENTER_ERROR_DOMAIN = @"EEEOperationCenterErrorDomain";

@implementation NSError (EEEOperationCenter)

+ (NSError *)eee_operationCenterErrorWithCode:(EEEOperationCenterErrorCode)code description:(NSString *)description
{
    return [self errorWithDomain:EEEOperationCenterErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: description}];
}

- (BOOL)eee_errorIsOperationCancelled
{
    return self.code == EEEOperationCenterErrorCodeCancelled && [self.domain isEqualToString:EEEOperationCenterErrorDomain];
}

@end

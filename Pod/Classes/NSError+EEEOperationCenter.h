#import <Foundation/Foundation.h>


extern NSString *const EEEOperationCenterErrorDomain;

__attribute__((deprecated))
extern NSString *const EEE_OPERATION_CENTER_ERROR_DOMAIN;

typedef enum
{
    EEEOperationCenterErrorCodeUnknown = 0,
    EEEOperationCenterErrorCodeCancelled = 20,
} EEEOperationCenterErrorCode;

@interface NSError (EEEOperationCenter)

+ (NSError *)eee_operationCenterErrorWithCode:(EEEOperationCenterErrorCode)code description:(NSString *)description;

- (BOOL)eee_errorIsOperationCancelled;

@end
#import <Foundation/Foundation.h>

#define EEEPrepareBlockSelf() __weak __typeof__(self) __weakSelf = self
#define EEEUseBlockSelf() __typeof__(__weakSelf) __weak blockSelf = __weakSelf

@class EEEInjector;
@class EEEOperation;

@interface EEEOperationCenter : NSObject

@property(nonatomic, strong) NSOperationQueue *mainCommandQueue;
@property(nonatomic, strong) NSOperationQueue *backgroundCommandQueue;
@property NSInteger maxConcurrentOperationCount;

+ (EEEOperationCenter *)currentOperationCenter;

+ (EEEOperationCenter *)setCurrentOperationCenter:(EEEOperationCenter *)defaultCenter;

- (id)initWithInjector:(EEEInjector *)injector;

- (id)queueOperation:(EEEOperation *)operation;

- (id)inlineOperation:(EEEOperation *)operation withTimeout:(NSTimeInterval)seconds;

@end
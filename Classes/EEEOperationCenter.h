#import <Foundation/Foundation.h>

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
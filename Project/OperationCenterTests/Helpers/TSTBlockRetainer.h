#import <Foundation/Foundation.h>

@interface TSTBlockRetainer : NSObject

@property(nonatomic, copy, readonly) BOOL (^blockExecutingBlock)();

- (void)setupBlocksWithTwoStepReference:(void (^)())innerBlock;

- (void)setupBlocksWithRetainCycle:(void (^)())innerBlock;

- (void)setupBlocksWithWeakSelfOnly:(void (^)())innerBlock;

@end
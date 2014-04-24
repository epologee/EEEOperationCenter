#import "TSTBlockRetainer.h"
#import "EEEOperationCenter.h"

@interface TSTBlockRetainer ()

@property(nonatomic, copy, readwrite) BOOL (^blockExecutingBlock)();

@end

@implementation TSTBlockRetainer

- (void)setupBlocksWithTwoStepReference:(void (^)())innerBlock
{
    EEEPrepareBlockSelf();
    self.blockExecutingBlock = ^BOOL {
        EEEUseBlockSelf();
        if (innerBlock) innerBlock();
        return blockSelf != nil;
    };
}

- (void)setupBlocksWithRetainCycle:(void (^)())innerBlock
{
    self.blockExecutingBlock = ^BOOL {
        if (innerBlock) innerBlock(); // this causes a retain cycle
        return self != nil;
    };
}

- (void)setupBlocksWithWeakSelfOnly:(void (^)())innerBlock
{
    EEEPrepareBlockSelf();
    self.blockExecutingBlock = ^BOOL {
        if (innerBlock) innerBlock();
        return __weakSelf != nil;
    };
}

@end
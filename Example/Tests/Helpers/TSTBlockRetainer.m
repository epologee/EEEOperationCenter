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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    // This block deliberately causes a retain cycle
    self.blockExecutingBlock = ^BOOL {
        if (innerBlock) innerBlock();
        return self != nil;
    };
#pragma clang diagnostic pop
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
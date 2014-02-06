//
//  EEEOperationCenterSpec.m
//  EEEOperationCenter
//
//  Created by Eric-Paul Lecluse on 06-02-14.
//  Copyright 2014 epologee. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "EEEOperationCenter.h"


SPEC_BEGIN(EEEOperationCenterSpec)

describe(@"EEEOperationCenter", ^{
    it(@"runs tests", ^{
        [[theValue(YES) should] beNo];
    });
});

SPEC_END

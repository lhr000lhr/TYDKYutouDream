//
//  TYDKWalletDetailItem.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWalletDetailItem.h"

@implementation TYDKWalletDetailItem

- (instancetype)initWithWalletDetailModel:(TYDKWalletDetailModel *)model {
    
    if (self = [super init]) {
        self.walletDetail = model;
    }
    return self;
}
@end

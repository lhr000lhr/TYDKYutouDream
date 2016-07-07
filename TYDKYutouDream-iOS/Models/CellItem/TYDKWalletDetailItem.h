//
//  TYDKWalletDetailItem.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "TYDKWalletDetailModel.h"
@interface TYDKWalletDetailItem : RETableViewItem

@property (strong, nonatomic) TYDKWalletDetailModel *walletDetail;
- (instancetype)initWithWalletDetailModel:(TYDKWalletDetailModel *)model;

@end

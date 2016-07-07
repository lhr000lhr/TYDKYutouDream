//
//  TYDKWalletDetailModel.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseModel.h"

typedef NS_ENUM(NSInteger, TYDKWalletDetailItemType) {
    
    TYDKWalletDetailItemTypeWithDrawPayOut = -3,
    TYDKWalletDetailItemTypeFreezePayOut   = -2,
    TYDKWalletDetailItemTypeWishPayOut     = -1,
    TYDKWalletDetailItemTypeOfferIncome    = 1,
    TYDKWalletDetailItemTypeBonusIncome    = 2,
    TYDKWalletDetailItemTypeRefundIncome   = 3,
    TYDKWalletDetailItemTypeUnfreezeIncome = 4,
    TYDKWalletDetailItemTypeRechargeIncome = 5,
};

///*item_type钱包明细类型*/
//const WISH_PAYOUT = -1;//发布支出
//const FREEZE_PAYOUT = -2;//冻结支出
//const WITHDRAW_PAYOUT = -3;//提现支出
//const OFFER_INCOME = 1;//接单收入
//const BONUS_INCOME = 2;//分成收入
//const REFUND_INCOME = 3;//退款收入
//const UNFREEZE_INCOME = 4;//解冻收入
//const RECHARGE_INCOME = 5;//充值收入


@interface TYDKWalletDetailModel : TYDKBaseModel


@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *wish_id;
@property (copy, nonatomic) NSString *user_id;

@property (assign, nonatomic) CGFloat amount;
@property (assign, nonatomic) NSTimeInterval create_time;
@property (assign, nonatomic) TYDKWishStatus status;
@property (assign, nonatomic) TYDKWalletDetailItemType item_type;



//{
//    "id": "236",
//    "user_id": "100036",
//    "item_type": "3",
//    "wish_id": "SuauJDJNJwEn2XNF",
//    "amount": "1.00",
//    "create_time": "1456802133",
//    "status": "0"
//},
@end

//
//  TYDKOfferModel.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseModel.h"

#import "TYDKWishModel.h"

typedef NS_ENUM(NSInteger, TYDKOfferStatus) {
    TYDKOfferStatusInvalid   = -2,
    TYDKOfferStatusCancelled = -1,
    TYDKOfferStatusWaitValid = 0,
    TYDKOfferStatusValid     = 1,
    TYDKOfferStatusConfirm   = 2,
    TYDKOfferStatusDone      = 3,
    TYDKOfferStatusPaid      = 4,
    
    TYDKOfferStatusNoneButton = -99,
};



@interface TYDKOfferModel : TYDKBaseModel

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *offer_user_id;
@property (copy, nonatomic) NSString *nick_name;
@property (copy, nonatomic) NSString *offer_description;
@property (copy, nonatomic) NSString *headimg;

@property (assign, nonatomic) NSTimeInterval create_time;
@property (assign, nonatomic) TYDKWishStatus wish_status;


//my offer

@property (copy, nonatomic) NSString *wish_id;
@property (copy, nonatomic) NSString *wish_nick_name;
@property (assign, nonatomic) CGFloat wish_price;
@property (copy, nonatomic) NSString *wish_description;
@property (copy, nonatomic) NSString *city;
@property (assign, nonatomic) TYDKOfferStatus offer_status;

@end

//{
//    "id": "1968",
//    "wish_id": "KKmntcMTMDZcm3BM",
//    "offer_user_id": "100009",
//    "wish_nick_name": "大肾",
//    "headimg": "http://img.91douya.com/qqZE2YEy.jpg",
//    "wish_price": "40.00",
//    "description": "我是一个户外运动爱好者，喜欢徒步和登山，可是不知道该怎么去选择装备，希望可以找到一个有经验的驴友小伙伴带我去选选装备，如果能再聊聊一些徒步方面的技术问题就更好了～～",
//    "city": "成都",
//    "wish_status": "6",
//    "offer_status": "3",
//    "create_time": "1454659570"
//}

//{
//    "id": "1935",
//    "offer_user_id": "100007",
//    "nick_name": "",
//    "status": "1",
//    "description": "接单接单接单接单接单接单接单接单接单接单接单接单接单接单接单接单接单",
//    "create_time": "1453880724"
//},
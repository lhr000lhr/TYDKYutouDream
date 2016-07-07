//
//  TYDKWishModel.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TYDKOfferModel;
/* -4投诉-3申请取消对接-2审核未通过-1已取消0初始化1待付款2已付款待审核3审核通过已发布4有人接单5已对接开始实现6已完成 */

typedef NS_ENUM(NSInteger, TYDKWishStatus) {
    
    TYDKWishStatusComplaint    = -4,
    TYDKWishStatusOfferRequest = -3,
    TYDKWishStatusInvalid      = -2,
    TYDKWishStatusCanceled     = -1,
    TYDKWishStatusInit         = 0,
    TYDKWishStatusWaitPay      = 1,
    TYDKWishStatusPaid         = 2,
    TYDKWishStatusPublish      = 3,
    TYDKWishStatusOffer        = 4,
    TYDKWishStatusStart        = 5,
    TYDKWishStatusDone         = 6,

};


@interface TYDKWishModel : TYDKBaseModel

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *nick_name;
@property (copy, nonatomic) NSString *wish_description;
@property (copy, nonatomic) NSString *city;
@property (assign, nonatomic) NSTimeInterval create_time;
@property (copy, nonatomic) NSString *headimg;

@property (assign, nonatomic) BOOL canOffer;


// detail
@property (assign, nonatomic) CGFloat wish_price;
@property (assign, nonatomic) TYDKWishStatus status;
@property (assign, nonatomic) NSUInteger like_count;
@property (assign, nonatomic) NSUInteger share_count;
@property (assign, nonatomic) NSUInteger read_count;
@property (strong, nonatomic) NSString *user_id;
+ (instancetype)wishModelFromOfferModel:(TYDKOfferModel *)offerModel;
@end



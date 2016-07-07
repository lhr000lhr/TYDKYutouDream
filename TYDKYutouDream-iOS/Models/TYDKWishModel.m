//
//  TYDKWishModel.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWishModel.h"

@implementation TYDKWishModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"nick_name" : @"nick_name",
             @"wish_description" : @"description",
             @"city" : @"city",
             @"create_time" : @"create_time",
             @"headimg" : @"headimg",
             
             //detail
             @"wish_price" : @"wish_price",
             @"status" : @"status",
             @"like_count" : @"like_count",
             @"share_count" : @"share_count",
             @"read_count" : @"read_count",

             @"canOffer" : @"can_offer",
             @"user_id" : @"user_id"
             };
}

//"wish": {
//    "id": "P04axlaViYtL6f0D",
//    "user_id": "100004",
//    "nick_name": "马光迪",
//    "headimg": "",
//    "city": "成都",
//    "wish_price": "1.00",
//    "wish_description": "让我穷请你名字一鱼死网破",
//    "status": "1",
//    "like_count": "0",
//    "share_count": "0",
//    "read_count": "0",
//    "create_time": "1453449504"
//    
//},

+ (instancetype)wishModelFromOfferModel:(TYDKOfferModel *)offerModel {
    
    TYDKWishModel *model = [[TYDKWishModel alloc] init];
    model.ID = offerModel.wish_id;
    model.nick_name = offerModel.wish_nick_name;
    model.wish_description = offerModel.wish_description;
    model.wish_price = offerModel.wish_price;
    model.city = offerModel.city;
    model.create_time = offerModel.create_time;
    model.status = offerModel.wish_status;
    model.headimg = offerModel.headimg;
    
    
    return model;
}
@end

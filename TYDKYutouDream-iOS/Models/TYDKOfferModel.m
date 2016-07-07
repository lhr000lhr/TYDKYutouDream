//
//  TYDKOfferModel.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKOfferModel.h"

@implementation TYDKOfferModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"nick_name" : @"nick_name",
             @"offer_description" : @"description",
             @"create_time" : @"create_time",
             @"offer_user_id" : @"offer_user_id",
             @"headimg" : @"headimg",
             //detail
             @"wish_id" : @"wish_id",
             @"wish_nick_name" : @"wish_nick_name",
             @"wish_price" : @"wish_price",
             @"city" : @"city",
             @"offer_status" : @"offer_status",
             
             };
}
@end

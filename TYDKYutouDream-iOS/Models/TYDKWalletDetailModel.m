//
//  TYDKWalletDetailModel.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWalletDetailModel.h"

@implementation TYDKWalletDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"user_id" : @"user_id",
             @"wish_id" : @"wish_id",
             @"amount" : @"amount",
             @"create_time" : @"create_time",
             @"status" : @"status",
             @"item_type" : @"item_type"
             };
}

@end

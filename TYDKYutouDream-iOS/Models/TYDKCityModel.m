//
//  TYDKCityModel.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/25/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCityModel.h"

@implementation TYDKCityModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"code" : @"code",
             @"province" : @"province",
             @"city" : @"city",
             @"district" : @"district",
             @"parent" : @"parent",
             
             };
}


//{
//    "id": "2",
//    "code": "110000",
//    "province": "北京市",
//    "city": "北京",
//    "district": "",
//    "parent": "1"
//},
@end

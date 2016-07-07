//
//  TYDKCityModel.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/25/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseModel.h"

@interface TYDKCityModel : TYDKBaseModel

@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) NSInteger code;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *district;
@property (assign, nonatomic) NSInteger parent;
@property (copy, nonatomic) NSString *city;


@end

//{
//    "id": "2",
//    "code": "110000",
//    "province": "北京市",
//    "city": "北京",
//    "district": "",
//    "parent": "1"
//},
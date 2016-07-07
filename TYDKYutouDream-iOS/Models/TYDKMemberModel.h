//
//  TYDKMemberModel.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/28/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDKBaseModel.h"

@class TYDKDateModel;

typedef NS_ENUM(NSUInteger, TYDKSexType) {
    TYDKSexTypeFemale,
    TYDKSexTypeMale,
    
};

@interface TYDKMemberModel : TYDKBaseModel

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *mobile_no;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *nick_name;
@property (copy, nonatomic) NSString *headimg;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;

@property (assign, nonatomic) TYDKSexType sex;

//{
//    "flag": 1,
//    "msg": {
//        "id": "100036",
//        "mobile_no": "18602853855",
//        "sex": "1",
//        "age": "90",
//        "nick_name": "任添糖",
//        "headimg": "http://daidai.91douya.com/public/img/head/head5.jpg",
//        "country": "",
//        "province": "",
//        "city": ""
//    }
//}

@end

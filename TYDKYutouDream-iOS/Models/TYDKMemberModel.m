//
//  TYDKMemberModel.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/28/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKMemberModel.h"

@implementation TYDKMemberModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"mobile_no" : @"mobile_no",
             @"sex" : @"sex",
             @"age" : @"age",
             @"nick_name" : @"nick_name",
             @"headimg" : @"headimg",
             @"country" : @"country",
             @"province" : @"province",
             @"city" : @"city"

             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        
        self = [TYDKMemberModel mj_objectWithKeyValues:dict];
        
    }
    
    return self;
}

- (NSString *)age {
    
    if (!_age) {
        _age = @"90";
    }
    return _age;
}

@end

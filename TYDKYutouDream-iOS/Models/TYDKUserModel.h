//
//  TYDKUserModel.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/28/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDKBaseModel.h"

typedef NS_OPTIONS(NSUInteger, TYDKPrivateFlag) {
    TYDKPrivateFlagAgents  = 1 << 0,
    TYDKPrivateFlagChannel = 1 << 1,
    TYDKPrivateFlagSales   = 1 << 2,
    TYDKPrivateFlagAdmin   = 1 << 3,
};


@interface TYDKUserModel : TYDKBaseModel <NSCoding>

@property (nonatomic, strong) TYDKMemberModel *member;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) NSURL *feedURL;

@property (nonatomic, assign, getter = isLogin) BOOL login;

@property (nonatomic, assign, getter = selectedPrivateFlag) TYDKPrivateFlag privateFlag;

- (instancetype)initWithMember:(TYDKMemberModel *)member;
//- (TYDKPrivateFlag)maxPrivateFlag;
- (void)saveUser;
+ (void)deleteUser;
+ (instancetype)getSavedUser;

@end

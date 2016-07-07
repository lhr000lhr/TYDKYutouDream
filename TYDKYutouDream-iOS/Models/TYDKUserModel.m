//
//  TYDKUserModel.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/28/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKUserModel.h"

static NSString *const kFileName = @"user.data";

@interface TYDKUserModel () {
    
}
@end

@implementation TYDKUserModel

- (instancetype)initWithMember:(TYDKMemberModel *)member {
    
    self = [super init];
    
    if (self) {
        self.member = member;
        self.name = member.nick_name;
//        self.privateFlag = [self adaptDefaultPrivate];
    }
    
    
    return self;
}

//- (TYDKPrivateFlag)adaptDefaultPrivate {
//    
//    TYDKPrivateFlag flag = 0;
//    if ([self.member.AGENTS_PRIV_FLAG isEqualToString:@"1"]) {
//        
//        flag = flag|TYDKPrivateFlagAgents;
//        
//    }
//    else if ([self.member.CHNL_PRIV_FLAG isEqualToString:@"1"]) {
//        
//        flag = flag|TYDKPrivateFlagChannel;
//        
//    }
//    else if ([self.member.SALES_PRIV_FLAG isEqualToString:@"1"]) {
//        
//        flag = flag|TYDKPrivateFlagSales;
//        
//    }
//    else if ([self.member.SUM_PRIV_FLAG isEqualToString:@"1"]) {
//        flag = flag|TYDKPrivateFlagAdmin;
//
//    }
//    
//    return flag;
//    
//}
//
//- (TYDKPrivateFlag)maxPrivateFlag {
//    
//    TYDKPrivateFlag flag = 0;
//    if ([self.member.AGENTS_PRIV_FLAG isEqualToString:@"1"]) {
//        
//      flag = flag|TYDKPrivateFlagAgents;
//
//    }
//    if ([self.member.CHNL_PRIV_FLAG isEqualToString:@"1"]) {
//
//      flag = flag|TYDKPrivateFlagChannel;
//
//    }
//    if ([self.member.SALES_PRIV_FLAG isEqualToString:@"1"]) {
//
//      flag = flag|TYDKPrivateFlagSales;
//        
//    }
//    if ([self.member.SUM_PRIV_FLAG isEqualToString:@"1"]) {
//        flag = flag|TYDKPrivateFlagAdmin;
//        
//    }
//    
//    return flag;
//    
//
//    
//}

#pragma mark - getter 

- (BOOL)isLogin {
    
    return _login;
}

+ (NSString *)filePath {
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    return [doc stringByAppendingPathComponent:kFileName];
    
}

- (void)saveUser {
    
    [NSKeyedArchiver archiveRootObject:self toFile:[TYDKUserModel filePath]];

}

+ (void)deleteUser {
    
    [[NSFileManager defaultManager]removeItemAtPath:[TYDKUserModel filePath] error:nil];
    
}

+ (instancetype)getSavedUser {
    
    TYDKUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:[TYDKUserModel filePath]];
    
    return user;
}
@end

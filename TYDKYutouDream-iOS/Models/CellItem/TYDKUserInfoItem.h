//
//  TYDKUserInfoItem.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "RETableViewItem.h"

@interface TYDKUserInfoItem : RETableViewItem

@property (strong, nonatomic ,readonly) TYDKUserModel *user;
@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSURL *avatarUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

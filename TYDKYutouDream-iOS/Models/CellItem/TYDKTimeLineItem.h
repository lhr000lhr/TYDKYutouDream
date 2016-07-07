//
//  TYDKTimeLineItem.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/30/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "RETableViewItem.h"

@interface TYDKTimeLineItem : RETableViewItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *mainTitle;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *imageName;

@end

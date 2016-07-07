//
//  TYDKNotificationManager.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/21/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYDKNotificationManager : NSObject

+ (instancetype)manager;

@property (nonatomic, assign) NSInteger unreadCount;

@end

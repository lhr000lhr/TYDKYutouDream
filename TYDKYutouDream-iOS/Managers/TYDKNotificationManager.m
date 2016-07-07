//
//  TYDKNotificationManager.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/21/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKNotificationManager.h"

static NSString *const kNofiticationStoreFilePath = @"/notification.plist";

@implementation TYDKNotificationManager

- (instancetype)init {
    if (self = [super init]) {
        
        NSString* path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [path stringByAppendingString:kNofiticationStoreFilePath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                //                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
                
            });
            
        } else {
            //            self.topicStateDictionary = [[NSMutableDictionary alloc] init];
        }
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLeaveAppNotification) name:UIApplicationWillResignActiveNotification object:nil];
        
    }
    return self;
}

+ (instancetype)manager {
    static TYDKNotificationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TYDKNotificationManager alloc] init];
    });
    return manager;
}

@end

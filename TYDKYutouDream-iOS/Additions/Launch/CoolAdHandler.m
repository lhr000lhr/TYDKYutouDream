//
//  CoolAdHandler.m
//  WallPaperNew
//
//  Created by 李浩然 on 9/21/15.
//  Copyright (c) 2015 李浩然. All rights reserved.
//

#import "CoolAdHandler.h"
#import "GCOLaunchImageTransition.h"

#import "NSString+MD5.h"
@implementation CoolAdHandler

+ (void)showAdvertiseLaunchImage {
    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        UIImage *launcImage = [[self class] launchImage];
        if (launcImage) {
            [GCOLaunchImageTransition transitionWithDuration:2.0f style:GCOLaunchImageTransitionAnimationStyleFade image:launcImage];
        }
//    });

    [[self class] downloadAdvertiseImage];
}


+ (NSString *)launchImagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths firstObject] stringByAppendingPathComponent:@"launch.jpg"];
    return path;
}

+ (UIImage *)launchImage {
    
    NSString *path = [[self class] launchImagePath];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
    
    //    image = [UIImage imageNamed:@"guide1"];
    
    return image;
}

+ (void)downloadAdvertiseImage {
    
    
    NSArray *imageUrls = @[
                           @"http://file.bmob.cn/M02/CF/A5/oYYBAFYHepyAcLQmAAD7O_lrQ5s316.jpg",
                           @"http://file.bmob.cn/M02/F9/81/oYYBAFYWEvKAD2GgABIrfgED3q0695.png",
                           @"http://file.bmob.cn/M02/CF/A4/oYYBAFYHeoOAJKbbAADoaGQ5lFo423.jpg",
                           @"http://file.bmob.cn/M02/C1/3E/oYYBAFYDaZOAG_pJAARQjQ4MGwk480.jpg"
                           
                           ];
    
    NSUInteger index = arc4random()%imageUrls.count;
    NSString *picUrl = imageUrls[index];

    if (picUrl.length > 0) {
        
        NSString *picNewKey = [picUrl MD5Hash];
        NSString *picOldKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"launchKey"];
        if ([picNewKey isEqualToString:picOldKey]) {
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:[[self class] launchImagePath]]) {
                NSLog(@"did download!");
                return ;
            }
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
            
            UIImage *img = [UIImage imageWithData:data];
            if (img) {
                NSLog(@"下载成功!");
                
                [data writeToFile:[[self class] launchImagePath] atomically:YES];
                [[NSUserDefaults standardUserDefaults] setObject:picNewKey forKey:@"launchKey"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        });
        
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:[[self class] launchImagePath] error:nil];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"launchKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

+ (NSString *)stringFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [dateFormatter setTimeZone:timeZone];
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    
    return destDateString;
    
}

@end

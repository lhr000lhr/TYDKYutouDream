//
//  AppDelegate.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/25/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKAppDelegate.h"
#import "CoolAdHandler.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import <JSPatch/JSPatch.h>
//#import <PgySDK/PgyManager.h>
//#import <PgyUpdate/PgyUpdateManager.h>

#import "Pingpp.h"

#define kPgyAppID @"7afe104ca0ef3df28972aef84bff14eb"
#define kUMAppKey @"507fcab25270157b37000010"
#define kJSPatchAppID @"aa24124d13cda3ba"
@interface TYDKAppDelegate ()

@end

@implementation TYDKAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [self configureSocialShare];
    [self configurePgySDK];
    
    [JSPatch startWithAppKey:kJSPatchAppID];
    [JSPatch sync];
//    [JSPatch testScriptInBundle];
    [JSPatch setupLogger:^(NSString *log) {
        NSLog(@"%@",log);
    }];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occuSr for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //显示闪屏广告
    [CoolAdHandler showAdvertiseLaunchImage];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - url

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}


#pragma mark - UmengShare

- (void)configureSocialShare {
    [UMSocialData setAppKey:kUMAppKey];
    [UMSocialData openLog:YES];

    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f"
                            appSecret:@"db426a9829e4b49a0dcac7b4162da6b6"
                                  url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//     openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

- (void)configurePgySDK {
    
    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:kPgyAppID];
//    //启动更新检查SDK
//    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:kPgyAppID];
//    
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];
}

@end

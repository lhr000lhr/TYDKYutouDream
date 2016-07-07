//
//  TYDKSettingManager.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/21/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKSettingManager.h"

#define userDefaults [NSUserDefaults standardUserDefaults]

#define kLineColorBlackDarkDefault    RGB(0xdbdbdb, 1.0)
#define kLineColorBlackLightDefault   RGB(0xebebeb, 1.0)

#define kFontColorBlackDarkDefault    RGB(0x333333, 1.0)
#define kFontColorBlackDarkMiddle     RGB(0x777777, 1.0)
#define kFontColorBlackLightDefault   RGB(0x999999, 1.0)
#define kFontColorBlackBlueDefault    RGB(0x778087, 1.0)
#define kColorBlueDefault             RGB(0x3fb7fc, 1.0)

static NSString *const kSelectedSectionIndex = @"SelectedSectionIndex";
static NSString *const kCategoriesSelectedSectionIndex = @"CategoriesSelectedSectionIndex";
static NSString *const kFavoriteSelectedSectionIndex = @"FavoriteSelectedSectionIndex";

static NSString *const kTheme           = @"Theme";
static NSString *const kThemeAutoChange = @"ThemeAutoChange";

static NSString *const kCheckInNotiticationOn = @"CheckInNotitication";
static NSString *const kNewNotificationOn     = @"NewNotification";
static NSString *const kNavigationBarHidden   = @"NavigationBarHidden";

static NSString *const kTrafficeSaveOn = @"TrafficeSaveOn";
static NSString *const kPreferHttps = @"PreferHttps";
static NSString *const kPreferLocalServer = @"PreferLocalServer";
static NSString *const kAuthenticator = @"Authenticator";


@interface TYDKSettingManager () {
    
    BOOL _trafficSaveModeOn;
    
}

@end

@implementation TYDKSettingManager

- (instancetype)init {
    if (self = [super init]) {
        
    
        
        _theme = [[userDefaults objectForKey:kTheme] integerValue];
        
//        id themeAutoChange = [userDefaults objectForKey:kThemeAutoChange];
//        if (themeAutoChange) {
//            _themeAutoChange = [themeAutoChange boolValue];
//        } else {
//            _themeAutoChange = YES;
//        }
        
        id checkInNotiticationOn = [userDefaults objectForKey:kCheckInNotiticationOn];
        if (checkInNotiticationOn) {
            _checkInNotiticationOn = [checkInNotiticationOn boolValue];
        } else {
            _checkInNotiticationOn = YES;
        }
        
        id newNotificationOn = [userDefaults objectForKey:kNewNotificationOn];
        if (newNotificationOn) {
            _newNotificationOn = [newNotificationOn boolValue];
        } else {
            _newNotificationOn = YES;
        }
        
        
        id navigationBarHidden = [userDefaults objectForKey:kNavigationBarHidden];
        if (navigationBarHidden) {
            _navigationBarAutoHidden = [navigationBarHidden boolValue];
        } else {
            _navigationBarAutoHidden = YES;
        }
        
        id trafficSaveOn = [userDefaults objectForKey:kTrafficeSaveOn];
        if (trafficSaveOn) {
            _trafficSaveModeOn = [trafficSaveOn boolValue];
        } else {
            _trafficSaveModeOn = NO;
        }
        
        id preferHttps = [userDefaults objectForKey:kPreferHttps];
        if (preferHttps) {
            _preferHttps = [preferHttps boolValue];
        } else {
            _preferHttps = NO;
        }
        
        id preferLocalServer = [userDefaults objectForKey:kPreferLocalServer];
        if (preferLocalServer) {
            _preferLocalServer = [preferLocalServer boolValue];
        } else {
            _preferLocalServer = NO;
        }
        
        id authenticator = [userDefaults objectForKey:kAuthenticator];
        if (authenticator) {
            _authenticator = [authenticator boolValue];
        } else {
            _authenticator = NO;
        }
//        [self configureTheme:_theme];
        
    }
    return self;
}

+ (instancetype)manager {
    static TYDKSettingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TYDKSettingManager alloc] init];
    });
    return manager;
}

#pragma mark - Notification

- (void)setCheckInNotiticationOn:(BOOL)checkInNotiticationOn {
    _checkInNotiticationOn = checkInNotiticationOn;
    
    [userDefaults setObject:@(checkInNotiticationOn) forKey:kCheckInNotiticationOn];
    [userDefaults synchronize];
    
}

- (void)setNewNotificationOn:(BOOL)newNotificationOn {
    _newNotificationOn = newNotificationOn;
    
    [userDefaults setObject:@(newNotificationOn) forKey:kNewNotificationOn];
    [userDefaults synchronize];
    
}

#pragma mark - Navigation Bar

- (void)setNavigationBarAutoHidden:(BOOL)navigationBarAutoHidden {
    _navigationBarAutoHidden = navigationBarAutoHidden;
    
    [userDefaults setObject:@(navigationBarAutoHidden) forKey:kNavigationBarHidden];
    [userDefaults synchronize];
    
}

#pragma mark - Traffic

- (void)setTrafficSaveModeOn:(BOOL)trafficSaveModeOn {
    _trafficSaveModeOn = trafficSaveModeOn;
    
    [userDefaults setObject:@(trafficSaveModeOn) forKey:kTrafficeSaveOn];
    [userDefaults synchronize];
    
}

- (BOOL)trafficSaveModeOn {
    
    return ![AFNetworkReachabilityManager sharedManager].isReachableViaWiFi && _trafficSaveModeOn;
}

- (BOOL)trafficSaveModeOnSetting {
    return _trafficSaveModeOn;
}

- (void)setPreferHttps:(BOOL)preferHttps {
//    _preferHttps = preferHttps;
//    
//    [TYDKDataManager manager].preferHttps = preferHttps;
//    
//    [userDefaults setObject:@(preferHttps) forKey:kPreferHttps];
//    [userDefaults synchronize];
}

- (void)setPreferLocalServer:(BOOL)preferLocalServer {
    
    _preferLocalServer = preferLocalServer;
    
    [TYDKDataManager manager].preferLocalServer = preferLocalServer;
    
    [userDefaults setObject:@(preferLocalServer) forKey:kPreferLocalServer];
    [userDefaults synchronize];

}

- (void)setAuthenticator:(BOOL)authenticator {
    
    _authenticator = authenticator;
    
    [TYDKDataManager manager].authenticator = authenticator;
    
    [userDefaults setObject:@(authenticator) forKey:kAuthenticator];
    [userDefaults synchronize];
    
    
}
@end

//
//  TYDKSettingManager.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/21/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TYDKTheme) {
    TYDKThemeDefault,
    TYDKThemeNight,
};

@interface TYDKSettingManager : NSObject

+ (instancetype)manager;

#pragma mark - Theme

@property (nonatomic, assign) TYDKTheme theme;

@property (nonatomic, copy) UIColor *navigationBarColor;
@property (nonatomic, copy) UIColor *navigationBarLineColor;
@property (nonatomic, copy) UIColor *navigationBarTintColor;

@property (nonatomic, copy) UIColor *backgroundColorWhite;
@property (nonatomic, copy) UIColor *backgroundColorWhiteDark;

@property (nonatomic, copy) UIColor *lineColorBlackDark;
@property (nonatomic, copy) UIColor *lineColorBlackLight;

@property (nonatomic, copy) UIColor *fontColorBlackDark;
@property (nonatomic, copy) UIColor *fontColorBlackMid;
@property (nonatomic, copy) UIColor *fontColorBlackLight;
@property (nonatomic, copy) UIColor *fontColorBlackBlue;

@property (nonatomic, copy) UIColor *colorBlue;
@property (nonatomic, copy) UIColor *cellHighlightedColor;
@property (nonatomic, copy) UIColor *menuCellHighlightedColor;

@property (nonatomic, assign) CGFloat imageViewAlphaForCurrentTheme;

#pragma mark - Notification

@property (nonatomic, assign) BOOL checkInNotiticationOn;
@property (nonatomic, assign) BOOL newNotificationOn;

#pragma mark - NavigationBar

@property (nonatomic, assign) BOOL navigationBarAutoHidden;

#pragma mark - Traffic

@property (nonatomic, assign) BOOL trafficSaveModeOn;
@property (nonatomic, assign) BOOL trafficSaveModeOnSetting;
@property (nonatomic, assign) BOOL preferHttps;
@property (nonatomic, assign) BOOL preferLocalServer;
@property (nonatomic, assign) BOOL authenticator;



@end

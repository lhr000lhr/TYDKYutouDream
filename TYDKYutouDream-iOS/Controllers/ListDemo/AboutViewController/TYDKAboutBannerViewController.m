//
//  TYDKAboutBannerViewController.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 12/17/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKAboutBannerViewController.h"

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@implementation TYDKAboutBannerViewController


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.versionLabel.text = [NSString stringWithFormat:@"%@ 版本",XcodeAppVersion];
    
    
}

@end

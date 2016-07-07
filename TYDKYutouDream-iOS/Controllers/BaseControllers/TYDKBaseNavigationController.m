//
//  TYDKBaseNavigationController.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 10/12/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKBaseNavigationController.h"

@interface TYDKBaseNavigationController ()

@end

@implementation TYDKBaseNavigationController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    self.navigationBar.barTintColor = [UIColor colorWithRed:0.115 green:0.165 blue:0.223 alpha:1.000];//设置bar的颜色

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    [UIActivityIndicatorView appearanceWhenContainedIn:[UINavigationBar class], nil].color = [UIColor whiteColor];
//    self.navigationBar.translucent = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航子控制器按钮的加载样式
        UINavigationItem *vcBtnItem = [viewController navigationItem];
        
        vcBtnItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)back {
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}


@end

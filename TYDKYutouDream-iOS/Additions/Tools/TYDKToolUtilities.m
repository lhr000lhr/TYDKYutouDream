//
//  TYDKToolUtilities.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/26/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKToolUtilities.h"
#import "TYDKCreateWishViewController.h"
#import "TYDKLoginViewController.h"
#import "TYDKCreateOfferViewController.h"
@implementation TYDKToolUtilities

+ (YYLabel *)showMessage:(NSString *)msg inView:(UIView *)view {
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
    label.width = view.width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
    
    label.bottom = 0;
    [view addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.top = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.bottom = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    return label;
}

+ (YYLabel *)showBottomMessage:(NSString *)msg inView:(UIView *)view {
    
    CGFloat padding = 10;
//
//    YYLabel *label = [YYLabel new];
//    label.text = msg;
//    label.font = [UIFont systemFontOfSize:16];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor orangeColor];
//    label.width = view.width;
//    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
//    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
//    
//    label.top = view.height - 65;
//
//    [view addSubview:label];
//    [UIView animateWithDuration:0.3 animations:^{
//        label.bottom = view.height - 65;
//    } completion:^(BOOL finished) {
//     
//    }];
    NSMutableAttributedString *text = [NSMutableAttributedString new];

    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:msg];
        one.font = [UIFont boldSystemFontOfSize:16];
        one.color = [UIColor whiteColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        
        YYTextShadow *shadow0 = [YYTextShadow new];
        shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow0.offset = CGSizeMake(0, -1);
        shadow0.radius = 1.5;
        YYTextShadow *shadow1 = [YYTextShadow new];
        shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
        shadow1.offset = CGSizeMake(0, 1);
        shadow1.radius = 1.5;
        shadow0.subShadow = shadow1;
        
        YYTextShadow *innerShadow0 = [YYTextShadow new];
        innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow0.offset = CGSizeMake(0, 1);
        innerShadow0.radius = 1;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        [highlight setShadow:shadow0];
        [highlight setInnerShadow:innerShadow0];
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
    }
    
    
    YYLabel *label = [YYLabel new];
    label.attributedText = text;
    label.width = view.width;
    label.height = view.height - (kiOS7Later ? 64 : 44);
    label.top = (kiOS7Later ? 64 : 0);
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    
    
    
    
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor orangeColor];
    label.width = view.width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
    
    /*
     If the 'highlight.tapAction' is not nil, the label will invoke 'highlight.tapAction'
     and ignore 'label.highlightTapAction'.
     
     If the 'highlight.tapAction' is nil, you can use 'highlightTapAction' to handle
     all tap action in this label.
     */
//    label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//    };
    return label;

}

+ (void)showCreateWishViewController {
    
    
    UITabBarController *tabBarController = (UITabBarController *)[AppDelegate window].rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    if (!kUser.isLogin) {
        TYDKLoginViewController *vc = [[TYDKLoginViewController alloc] init];
        
        TYDKBaseNavigationController *nav = [[TYDKBaseNavigationController alloc] initWithRootViewController:vc];
        
        MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:nav];
        
        formSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
        
        [viewController mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
            
        }];
        
        
    } else {
        TYDKCreateWishViewController *vc = [[TYDKCreateWishViewController alloc] init];
        TYDKBaseNavigationController *nav = [[TYDKBaseNavigationController alloc] initWithRootViewController:vc];
        
        [viewController presentViewController:nav animated:YES completion:^{
            
        }];
    }
  
}

+ (void)showCreateOfferViewController {
    
    UITabBarController *tabBarController = (UITabBarController *)[AppDelegate window].rootViewController;
    TYDKBaseNavigationController *viewController = tabBarController.selectedViewController;
    
    if (!kUser.isLogin) {
        TYDKLoginViewController *vc = [[TYDKLoginViewController alloc] init];
        
        TYDKBaseNavigationController *nav = [[TYDKBaseNavigationController alloc] initWithRootViewController:vc];
        
        MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:nav];
        
        formSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
        
        [viewController mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
            
        }];
        
        
    } else {
        TYDKCreateOfferViewController *vc = [[TYDKCreateOfferViewController alloc] init];
        
        [viewController pushViewController:vc animated:YES];
    }
    
}
@end

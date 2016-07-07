//
//  YYLabel+TYDKBottomAnimation.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/3/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "YYLabel+TYDKBottomAnimation.h"

@implementation YYLabel (TYDKBottomAnimation)

- (void)showInView:(UIView *)view {
    
    
    self.top = view.height;
    [view addSubview:self];

    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bottom = view.height;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)showInViewController:(UIViewController *)viewController
                        wish:(TYDKWishModel *)wish
                  offerBlock:(void (^)())offerBlock
                 cancelBlock:(void (^)())cancelBlock {
    
    if (!wish.canOffer) {
        return;
    }
    
    UIView *view = viewController.view;
   
    if ([kUser.member.ID isEqualToString:wish.user_id]) {
        switch (wish.status) {
                
            case TYDKWishStatusPaid:
            
                break;
            case TYDKWishStatusPublish:
            case TYDKWishStatusOffer:
            {
                self.text = @"取消";
                self.backgroundColor = [UIColor colorWithRed:0.871 green:0.208 blue:0.180 alpha:1.000];
                [self bk_whenTapped:^{
                    cancelBlock();
                    
                }];
                
                [self showInView:view];
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (wish.status) {
                
            case TYDKWishStatusPaid:
                
                break;
            case TYDKWishStatusPublish:
            case TYDKWishStatusOffer:
            {
                self.text = @"报名";
                [self bk_whenTapped:^{
                    offerBlock();
                    
                }];
                
                [self showInView:view];
            }
                break;
                
            default:
                break;
        }

        
        
        
        
        
    }
    
 
   
   
    
}


@end

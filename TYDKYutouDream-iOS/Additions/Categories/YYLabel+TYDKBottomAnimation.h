//
//  YYLabel+TYDKBottomAnimation.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/3/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <YYKit/YYKit.h>
@class TYDKWishModel;
@interface YYLabel (TYDKBottomAnimation)

- (void)showInView:(UIView *)view;

- (void)showInViewController:(UIViewController *)viewController
                        wish:(TYDKWishModel *)wish
                  offerBlock:(void (^)())offerBlock
                 cancelBlock:(void (^)())cancelBlock;
@end

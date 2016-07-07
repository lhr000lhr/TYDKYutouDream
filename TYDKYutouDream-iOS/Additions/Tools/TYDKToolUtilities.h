//
//  TYDKToolUtilities.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/26/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYLabel+TYDKBottomAnimation.h"

@interface TYDKToolUtilities : NSObject

+ (YYLabel *)showMessage:(NSString *)msg inView:(UIView *)view;

+ (YYLabel *)showBottomMessage:(NSString *)msg inView:(UIView *)view;

+ (void)showCreateWishViewController;
+ (void)showCreateOfferViewController;
@end

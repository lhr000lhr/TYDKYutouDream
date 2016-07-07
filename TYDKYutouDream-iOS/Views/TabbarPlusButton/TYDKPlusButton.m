//
//  TYDKPlusButton.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/24/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKPlusButton.h"

#import "TYDKCreateWishViewController.h"
@interface TYDKPlusButton () {
    CGFloat _buttonImageHeight;
}

@end

@implementation TYDKPlusButton

#pragma mark - Life Cycle
+ (void)load {
    [super registerSubclass];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
 
}

#pragma mark - Public Methods
+ (instancetype)plusButton {
    
    TYDKPlusButton *button = [[TYDKPlusButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIImage *buttonImage = [UIImage imageNamed:@"pulish_normal"];
    buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.backgroundColor = TYDKThemeColor;
    button.tintColor = [UIColor whiteColor];
    button.layer.cornerRadius = 2.0;
    button.clipsToBounds = YES;
    
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Event Response

- (void)clickPublish {
   
    
    [TYDKToolUtilities showCreateWishViewController];
  
}

#pragma mark - CYLPlusButtonSubclassing
//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 3;
//}

//+ (CGFloat)multiplerInCenterY {
//    return  0.3;
//}

@end

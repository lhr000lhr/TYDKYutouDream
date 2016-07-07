//
//  TYDKTabBarController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKTabBarController.h"


#import "TYDKMainViewController.h"
#import "TYDKHomeViewController.h"
#import "TYDKDiscoverViewController.h"
@interface TYDKTabBarController ()
/** 发布按钮 */
@property (nonatomic, strong) UIButton<CYLPlusButtonSubclassing> *plusButton;

@property (strong, nonatomic) TYDKHomeViewController *mainVC;
@property (strong, nonatomic) TYDKDiscoverViewController *discoverVC;

@end

@implementation TYDKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configViewControllers];
    // Do any additional setup after loading the view.
}



#pragma mark - set viewcontrollers 

- (void)configViewControllers {
    
    self.mainVC = [[TYDKHomeViewController alloc] init];
    self.discoverVC = [[TYDKDiscoverViewController alloc] init];
    TYDKBaseNavigationController *firstNavigationController = [[TYDKBaseNavigationController alloc] initWithRootViewController:self.mainVC];
    TYDKBaseNavigationController *secondNavigationController = [[TYDKBaseNavigationController alloc] initWithRootViewController:self.discoverVC];

    
    [self setUpTabBarItemsAttributesForController];
    [self setViewControllers:@[firstNavigationController,
                               secondNavigationController]];
    [self customizeTabBarAppearance];
}


- (void)setUpTabBarItemsAttributesForController {
    
    NSDictionary *home = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_selected",
                            };
    NSDictionary *discover = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"discover_normal",
                            CYLTabBarItemSelectedImage : @"discover_selected",
                            };

    NSArray *tabBarItemsAttributes = @[
                                       home,
                                       discover,
                                       ];
    self.tabBarItemsAttributes = tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
- (void)customizeTabBarAppearance {
    
    //去除 TabBar 自带的顶部阴影
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.765 alpha:1.000];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
//    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:26 / 255.0 green:163 / 255.0 blue:133 / 255.0 alpha:1] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 5.0f, 49) withCornerRadius:0]];
    
    // set the bar background color
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];

    [tabBarAppearance setBackgroundImage:[[UIImage alloc] imageByTintColor:[UIColor clearColor]]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar_background_os7"]];

}

- (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return image;
}
@end

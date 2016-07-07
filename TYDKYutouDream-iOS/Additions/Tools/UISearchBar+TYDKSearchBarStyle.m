//
//  UISearchBar+TYDKSearchBarStyle.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/8/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "UISearchBar+TYDKSearchBarStyle.h"

@implementation UISearchBar (TYDKSearchBarStyle)

- (void)searchBarStyleWithPlaceholder:(NSString *)placeholder {
    
    
    // 2.设置图片
    [self setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch
             state:UIControlStateNormal];
    
    // 3.设置占位符字和闪烁条的颜色
    [self setTintColor:TYDKThemeColor];
    self.placeholder = placeholder;
    
    // 4.设置背景色
    UIView *searchBarSub = self.subviews[0];
  
    [searchBarSub.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subView setBackgroundColor:[UIColor colorWithWhite:0.984 alpha:1.000]];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:subView.bounds];
            toolbar.clipsToBounds = YES;//去掉上面黑线
            [searchBarSub insertSubview:toolbar atIndex:idx];

        }

    }];

    
    
}
@end

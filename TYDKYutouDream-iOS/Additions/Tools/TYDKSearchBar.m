//
//  TYDKSearchBar.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/8/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKSearchBar.h"

@implementation TYDKSearchBar

+ (TYDKSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder {
    // 1.初始化
    TYDKSearchBar *searchBar = [[TYDKSearchBar alloc]init];
    
    // 2.设置图片
    [searchBar setImage:[UIImage imageNamed:@"searchIcon"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    
    // 3.设置占位符字和闪烁条的颜色
    [searchBar setTintColor:[UIColor colorWithWhite:0.753 alpha:1.000]];
    searchBar.placeholder = placeholder;
    
    // 4.设置背景色
    UIView *searchBarSub = searchBar.subviews[0];
    for (UIView *subView in searchBarSub.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subView setBackgroundColor:[UIColor colorWithWhite:0.984 alpha:1.000]];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
    }
    
    return searchBar;
    
    
}
@end

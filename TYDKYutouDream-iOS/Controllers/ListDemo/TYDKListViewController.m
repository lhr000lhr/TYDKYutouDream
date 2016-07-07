//
//  TYDKListViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKListViewController.h"

@interface TYDKListViewController ()

@property (strong, nonatomic) NSArray *selections;

@end

@implementation TYDKListViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表类";

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Configure Views
- (void)configureTableView {
    
    [super configureTableView];
    
    self.selections = @[
                        @{@"普通字典类":@"TYDKCitysViewController",},
                        @{@"图文类列表":@"TYDKImageAndTextViewController",},
                        @{@"下拉刷新&分页加载":@"TYDKPullRefreshViewController",},
                        @{@"时间轴式列表":@"TYDKTimeLineViewController",},
                        @{@"图片列表":@"TYDKPictureListViewController",},
                        @{@"分项列表1":@"TYDKCategoryListOneViewController",},
                        @{@"分项列表2":@"TYDKCategoryListTwoViewController",},
                        @{@"卡片列表1":@"TYDKCardListOneViewController",},
                        @{@"卡片列表2":@"TYDKCardListTwoViewController",},
                        ];
    
    
    @weakify(self);
 
    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        [self.selections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *dic = obj;
            RETableViewItem *item = [RETableViewItem itemWithTitle:[dic.allKeys firstObject] accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
                
                @strongify(self);

                [item deselectRowAnimated:YES];
                
                Class destinationClass = NSClassFromString([dic.allValues firstObject]);
                UIViewController *vc = [[destinationClass alloc] init];
                vc.title = [dic.allKeys firstObject];
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
            [section addItem:item];
            
        }];
        
        [self.manager addSection:section];
        section;
        
    });
    
    
}




@end

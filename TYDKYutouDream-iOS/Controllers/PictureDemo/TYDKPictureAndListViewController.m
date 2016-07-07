//
//  TYDKPictureListViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/11/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKPictureAndListViewController.h"
@interface TYDKPictureAndListViewController ()

@property (strong, nonatomic) NSArray *selections;

@end

@implementation TYDKPictureAndListViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片类";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    self.selections = @[
                        @{@"大图浏览类":@"TYDKPicturePreviewViewController",},
                        @{@"分组混排1":@"TYDKGroupMixOneViewController",},
                        @{@"分组混排2":@"TYDKPullRefreshViewController",},
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

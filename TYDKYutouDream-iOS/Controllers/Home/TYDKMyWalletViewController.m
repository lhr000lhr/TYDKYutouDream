//
//  TYDKMyWalletViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyWalletViewController.h"
#import "TYDKMyWalletDetailViewController.h"

@interface TYDKMyWalletViewController ()

@end

@implementation TYDKMyWalletViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);

    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
      
        RETableViewItem *cashItem = [RETableViewItem itemWithTitle:@"提现" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            @strongify(self);
            [item deselectRowAnimated:YES];
        }];
        [cashItem setImage:[UIImage imageNamed:@"ic_card"]];
        [section addItem:cashItem];
        
        RETableViewItem *detailItem = [RETableViewItem itemWithTitle:@"明细查看" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            @strongify(self);
            [item deselectRowAnimated:YES];
            TYDKMyWalletDetailViewController *vc = [[TYDKMyWalletDetailViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [detailItem setImage:[UIImage imageNamed:@"ic_list"]];
        [section addItem:detailItem];
        [self.manager addSection:section];
        section;
    });
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

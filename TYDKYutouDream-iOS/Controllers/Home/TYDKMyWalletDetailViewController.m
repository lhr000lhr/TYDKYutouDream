//
//  TYDKMyWalletDetailViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyWalletDetailViewController.h"

#import "TYDKWalletDetailItem.h"

@interface TYDKMyWalletDetailViewController ()
//存放所有显示数据的数组
@property (strong, nonatomic) NSMutableArray *rowsArray;

@end

@implementation TYDKMyWalletDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"明细";
    [self requestWalletDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);
    self.manager[@"TYDKWalletDetailItem"] = @"TYDKMyWalletDetailTableViewCell";

    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        [self.manager addSection:section];
        
        section;
    });
    
}

#pragma marl - Request Wallet Detail

- (void)requestWalletDetail {
    self.requestTask = [[TYDKDataManager manager] getWalletDetail:^(NSArray<TYDKWalletDetailModel *> *list) {
        [self addItems:list];
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - Private Methods

- (void)addItems:(NSArray *)rowsArray {
    
    
    if (!self.rowsArray) {
        
        self.rowsArray = [NSMutableArray arrayWithArray:rowsArray];
    }
    @weakify(self);
    
    [rowsArray enumerateObjectsUsingBlock:^(TYDKWalletDetailModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKWalletDetailItem *item = [[TYDKWalletDetailItem alloc] initWithWalletDetailModel:obj];
        
        [item setSelectionHandler:^(TYDKWalletDetailItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);
            
          
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.basicControlsSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    
}
@end

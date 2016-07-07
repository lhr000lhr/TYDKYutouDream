//
//  TYDKHomeViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKHomeViewController.h"

#import "TYDKWishDetailViewController.h"
#import "TYDKProfileViewController.h"

#import "TYDKHomeWishListItem.h"
@interface TYDKHomeViewController () <RETableViewManagerDelegate> {
    
    NSUInteger _currentPage;
    NSUInteger _maxPage;
    
}


//存放所有显示数据的数组
@property (strong, nonatomic) NSMutableArray *rowsArray;

@end

@implementation TYDKHomeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self configureNavigationItem];
}

#pragma mark - Configure Views

- (void)configureNavigationItem {
    
    @weakify(self);
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"ic_user"] style:UIBarButtonItemStylePlain handler:^(id sender) {
            @strongify(self);
            
            TYDKProfileViewController *vc = [[TYDKProfileViewController alloc] init];
            vc.title = @"我的";
            [self.navigationController pushViewController:vc animated:YES];
        }];
        item;
    });
    
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);

    self.manager[@"TYDKHomeWishListItem"] = @"TYDKHomeTableViewCell";

    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        
        [self.manager addSection:section];
        section;
        
    });
    
    [self setupRefresh];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark UITableView + 下拉刷新 隐藏时间

- (void)setupRefresh {
    
    @weakify(self);
    
    //为tableview添加下拉刷新 上拉加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        @strongify(self);
        [self requestWishList];
        
    }];
    
    

    
}

#pragma mark - request Wish List 

- (void)requestWishList {
    self.requestTask = [[TYDKDataManager manager] getAllWishesSuccess:^(NSArray<TYDKWishModel *> *list) {
        
        [self addItems:list];
        [self.tableView.mj_header endRefreshing];

        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
}

#pragma mark - Private Methods

- (void)addItems:(NSArray *)rowsArray {

    
    if (!self.rowsArray) {
        
        self.rowsArray = [NSMutableArray arrayWithArray:rowsArray];
    }
    @weakify(self);
    
    [self.basicControlsSection removeAllItems];
    
    [rowsArray enumerateObjectsUsingBlock:^(TYDKWishModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKHomeWishListItem *item = [[TYDKHomeWishListItem alloc] initWithWishModel:obj chooseHandler:^(TYDKHomeWishListItem *item) {
            @strongify(self);
            
        }];
        
        [item setSelectionHandler:^(TYDKHomeWishListItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);

            TYDKWishDetailViewController *vc = [[TYDKWishDetailViewController alloc] init];
            vc.wish = item.wish;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.tableView reloadData];

}
@end

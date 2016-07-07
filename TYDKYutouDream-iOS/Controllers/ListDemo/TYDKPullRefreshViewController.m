//
//  TYDKPullRefreshViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/30/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKPullRefreshViewController.h"
#import "TYDKWebViewController.h"

#import "TYDKImageAndTextItem.h"

@interface TYDKPullRefreshViewController () {
    NSUInteger _currentPage;
    NSUInteger _maxPage;

}

@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;

@end

@implementation TYDKPullRefreshViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"刷新分页";

    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    
    [self setupRefresh];

    [super configureTableView];

    [self.tableView.mj_header beginRefreshing];
    
    
}

#pragma mark UITableView + 下拉刷新 隐藏时间
- (void)setupRefresh
{
    
    @weakify(self);
    
    //为tableview添加下拉刷新 上拉加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    
    
    self.tableView.mj_footer = ({
        MJRefreshAutoNormalFooter *tableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            @strongify(self);
            self->_currentPage ++;

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self addItems:[self.dataSource km_safeArrayForKey:@"stories"]];
                [self.tableView.mj_footer endRefreshing];
            });

            
        }];
        [tableViewFooter setTitle:@"- ( ゜- ゜)つロ 已经没有了~" forState:MJRefreshStateNoMoreData];
        tableViewFooter;
    });
    
    //设置页面数
    
    NSDictionary *page    = @{
                              @"countPage":@(2),
                              @"currentPage":@(1),
                              };
    NSInteger countPage   = [page km_safeNumberForKey:@"countPage"].integerValue;
    NSInteger currentPage = [page[@"currentPage"] integerValue];
    _currentPage          = 1;
    _maxPage              = [page[@"countPage"] integerValue];
    
    
    if (currentPage >= countPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    } else {
        [self.tableView.mj_footer resetNoMoreData];
    }
    
}


- (void)addItems:(NSArray * __nonnull)rowsArray {

    
    [super addItems:rowsArray];
    [self endRequest];

}

- (void)endRequest {
    
    
    self.isRequesting = NO;
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_footer endRefreshing];

    if (_currentPage >= _maxPage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];

        });
        
    }
    
}
@end

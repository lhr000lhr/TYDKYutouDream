//
//  TYDKDiscoverViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//
#import "RETableViewOptionsController.h"

#import "TYDKDiscoverViewController.h"
#import "TYDKWishDetailViewController.h"
#import "TYDKProfileViewController.h"

#import "TYDKHomeWishListItem.h"

#import "NYSegmentedControl.h"
#import "UISearchBar+TYDKSearchBarStyle.h"

@interface TYDKDiscoverViewController () <UISearchControllerDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) NSArray<TYDKCityModel *> *cityModels;
@property (strong, nonatomic) NSArray<NSString *> *cities;
@property (strong, nonatomic) RERadioItem *wishCityItem;
@property (strong, nonatomic) NYSegmentedControl *segementedControl;
//存放所有显示数据的数组
@property (strong, nonatomic) NSMutableArray *rowsArray;

@property (nonatomic, strong) UISearchController *searchController;


@end

@implementation TYDKDiscoverViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    [self configureNavigationItem];
    [self requestCitysWithItem:self.wishCityItem];
    [self configureSearch];
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
    
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] bk_initWithTitle:@"" style:UIBarButtonItemStylePlain handler:^(id sender) {
            @strongify(self);
            
            [self requestCitysWithItem:self.wishCityItem];
        }];
        item;
    });
    
    self.navigationItem.titleView = ({
    
        NYSegmentedControl *segmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@"进行中", @"已完成"]];
        segmentedControl.titleTextColor = [UIColor groupTableViewBackgroundColor];
        segmentedControl.selectedTitleTextColor = [UIColor whiteColor];
        //    _instagramSegmentedControl.selectedTitleFont = [UIFont systemFontOfSize:13.0f];
        segmentedControl.segmentIndicatorBackgroundColor = TYDKThemeColor;
        segmentedControl.backgroundColor = [UIColor colorWithRed:0.183 green:0.264 blue:0.355 alpha:1.000];
        segmentedControl.borderWidth = 0.0f;
        segmentedControl.segmentIndicatorBorderWidth = 0.0f;
        segmentedControl.segmentIndicatorInset = 2.0f;
        segmentedControl.segmentIndicatorBorderColor = self.view.backgroundColor;
        [segmentedControl sizeToFit];
        segmentedControl.cornerRadius = CGRectGetHeight(segmentedControl.frame) / 2.0f;
        [segmentedControl bk_addEventHandler:^(NYSegmentedControl *sender) {
            @strongify(self);
            [self requestWishList];
            NSLog(@"%lu",(unsigned long)sender.selectedSegmentIndex);
        } forControlEvents:UIControlEventValueChanged];
        self.segementedControl = segmentedControl;
        segmentedControl;
    
    });
    
    
}

#pragma mark - Configure Search

- (void)configureSearch {
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;

    [self.searchController.searchBar searchBarStyleWithPlaceholder:@"搜索"];
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;

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
    
    self.wishCityItem = ({
        RERadioItem *item = [RERadioItem itemWithTitle:@"选择城市" value:@"" selectionHandler:^(RERadioItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);
            [self requestCitysWithItem:item];
            
        }];
        item;
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
    TYDKDiscoverType discoverType = self.segementedControl.selectedSegmentIndex ? TYDKDiscoverTypeWishDone : TYDKDiscoverTypeWishProcessing;
    self.requestTask = [[TYDKDataManager manager] discoverWishesWithCityCode:[self getCityModel:self.wishCityItem.value].code keywords:self.keywords type:discoverType page:1 success:^(NSArray<TYDKWishModel *> *list) {
        [self addItems:list];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
}

#pragma mark - request Cities

- (void)requestCitysWithItem:(RERadioItem *)item {
    @weakify(self);

    if (!self.cityModels) {
        [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionLeft];
        [[TYDKDataManager manager] getAllCitiesSuccess:^(NSArray<TYDKCityModel *> *list) {
            self.cityModels = list;
            self.cities = [self getCities:list];
            self.wishCityItem.value = @"成都";
            [self.navigationItem.leftBarButtonItem setTitle:item.value];

            [self.navigationItem stopAnimating];
        } failure:^(NSError *error) {
            [self.navigationItem stopAnimating];

        }];
        return;
    }
    
    RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:self.cities multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
        @strongify(self);

        [self.navigationController popViewControllerAnimated:YES];
        
        [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        [self.navigationItem.leftBarButtonItem setTitle:item.value];
        [self requestWishList];
    }];
    optionsController.style = item.section.style;
    [self.navigationController pushViewController:optionsController animated:YES];
    
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
    
    [self.basicControlsSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - Private Methods

- (NSArray *)getCities:(NSArray *)cityModels {
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (TYDKCityModel *model in cityModels) {
        
        [array addObject:model.city];
        
    }
    
    return array;
    
}

- (TYDKCityModel *)getCityModel:(NSString *)city {
    
    __block TYDKCityModel *cityModel;
    [self.cityModels enumerateObjectsUsingBlock:^(TYDKCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.city isEqualToString:city]) {
            cityModel = obj;
            *stop = YES;
        }
        
    }];
    return cityModel;
    
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    
    
    NSInteger selectedScopeButtonIndex = [self.searchController.searchBar selectedScopeButtonIndex];
    if (selectedScopeButtonIndex > 0) {
//        scope = [[Product deviceTypeNames] objectAtIndex:(selectedScopeButtonIndex - 1)];
    }
 
    self.keywords = searchString;
    [self requestWishList];
    
}
@end

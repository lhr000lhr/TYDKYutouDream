//
//  TYDKCardListTwoViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/5/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCardListTwoViewController.h"
#import "TYDKWebViewController.h"
#import "TYDKCardListTwoItem.h"
@interface TYDKCardListTwoViewController ()
@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;
@end

@implementation TYDKCardListTwoViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views
- (void)configureTableView {
    [super configureTableView];
    self.manager[@"TYDKCardListTwoItem"] = @"TYDKCardListTwoTableViewCell";
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"zhihuDailyData"
                                                      ofType:@"json"];
    NSData *data    = [NSData dataWithContentsOfFile:path];
    self.dataSource = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil];
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        
        [self.manager addSection:section];
        section;
        
    });
    
    [self addItems:[self.dataSource km_safeArrayForKey:@"stories"]];
    
}

- (void)addItems:(NSArray * __nonnull)rowsArray {
    
    
    if (!self.stories) {
        self.stories = [NSMutableArray arrayWithArray:rowsArray];
    }
    /**
     *  将新得到的数据加入总数据中
     */
    [self.stories arrayByAddingObjectsFromArray:rowsArray];
    @weakify(self);
    
    [rowsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKCardListTwoItem *item = [[TYDKCardListTwoItem alloc] initWithDictionary:obj];
        
        @strongify(self);
        [item setSelectionHandler:^(TYDKCardListTwoItem *item) {
            [item deselectRowAnimated:YES];
            TYDKWebViewController *vc = [[TYDKWebViewController alloc] init];
            vc.url = [NSURL URLWithString:item.mainURL];
            vc.title = item.mainTitle;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.tableView reloadData];
    
}

@end

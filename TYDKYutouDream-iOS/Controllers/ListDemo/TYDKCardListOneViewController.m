//
//  TYDKCardListOneViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCardListOneViewController.h"
#import "TYDKCardListOneItem.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface TYDKCardListOneViewController ()
@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;
@end

@implementation TYDKCardListOneViewController

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
    
    self.manager[@"TYDKCardListOneItem"] = @"TYDKCardListOneTableViewCell";
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"weiboTimeLineData"
                                                      ofType:@"json"];
    NSData *data    = [NSData dataWithContentsOfFile:path];
    self.dataSource = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil];
    
#ifdef DEBUG
    self.tableView.fd_debugLogEnabled = YES;
#endif
    
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
        
        TYDKCardListOneItem *item = [[TYDKCardListOneItem alloc] initWithDictionary:obj];
        
        @strongify(self);
        [item setSelectionHandler:^(TYDKCardListOneItem *item) {
            [item deselectRowAnimated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.tableView reloadData];
    
}

@end

//
//  TYDKTimeLineViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/30/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKTimeLineViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

#import "TYDKTimeLineItem.h"
@interface TYDKTimeLineViewController ()

@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;

@end

@implementation TYDKTimeLineViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间轴式列表";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    
    [super configureTableView];
    self.manager[@"TYDKTimeLineItem"] = @"TYDKTimeLineTableViewCell";
    
#ifdef DEBUG
    self.tableView.fd_debugLogEnabled = YES;
#endif
    
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"weiboTimeLineData"
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
        
        TYDKTimeLineItem *item = [[TYDKTimeLineItem alloc] initWithDictionary:obj];
        
        @strongify(self);
        [item setSelectionHandler:^(TYDKTimeLineItem *item) {
            [item deselectRowAnimated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.tableView reloadData];
    
}
@end

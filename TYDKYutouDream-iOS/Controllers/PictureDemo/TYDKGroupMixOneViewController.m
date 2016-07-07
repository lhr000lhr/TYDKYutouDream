//
//  TYDKGroupMixOneViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/14/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKGroupMixOneViewController.h"
#import "TYDKPackageItem.h"

@interface TYDKGroupMixOneViewController ()

@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;

@end

@implementation TYDKGroupMixOneViewController

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
    
    self.manager[@"TYDKPackageItem"] = @"TYDKGroupMixOneGroupedTableViewCell";
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"zhihuDailyData"
                                                      ofType:@"json"];
    NSData *data    = [NSData dataWithContentsOfFile:path];
    self.dataSource = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil];
    
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection sectionWithHeaderView:[UIView new]];
        
        [self.manager addSection:section];
        section;
        
    });
    [self addPackageItem:[self.dataSource km_safeArrayForKey:@"stories"]];

}

- (void)addPackageItem:(NSArray * __nonnull)rowsArray {
    if (!self.stories) {
        self.stories = [NSMutableArray arrayWithArray:rowsArray];
    }
    /**
     *  将新得到的数据加入总数据中
     */
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];

    [rowsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:obj];
        if ((idx + 1)%6 == 0) {
            TYDKPackageItem *item = [[TYDKPackageItem alloc] initWithPackages:array];
            [self.basicControlsSection addItem:item];
            *stop = YES;

        }
    }];
    
    

    [self.tableView reloadData];

}

@end

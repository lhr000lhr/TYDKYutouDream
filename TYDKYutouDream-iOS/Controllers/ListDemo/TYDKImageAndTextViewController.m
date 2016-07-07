//
//  TYDKImageAndTextViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKImageAndTextViewController.h"
#import "TYDKWebViewController.h"

#import "TYDKImageAndTextItem.h"
@interface TYDKImageAndTextViewController ()

@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;

@end

@implementation TYDKImageAndTextViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图文类";
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    
    [super configureTableView];
  
    self.manager[@"TYDKImageAndTextItem"] = @"TYDKImageAndTextTableViewCell";

    NSString *path  = [[NSBundle mainBundle] pathForResource:@"zhihuDailyData"
                                                      ofType:@"json"];
    NSData *data    = [NSData dataWithContentsOfFile:path];
    self.dataSource = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil];
//    self.stories = [self.dataSource km_safeArrayForKey:@"stories"];
    
    
    
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
        
        TYDKImageAndTextItem *item = [[TYDKImageAndTextItem alloc] initWithDictionary:obj];
        
        [item setSelectionHandler:^(TYDKImageAndTextItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);
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

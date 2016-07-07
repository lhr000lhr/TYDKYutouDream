//
//  TYDKCategoryListTwoViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCategoryListTwoViewController.h"
#import "TYDKAboutViewController.h"

#import "TYDKUserInfoItem.h"

@interface TYDKCategoryListTwoViewController ()

@property (strong, nonatomic) RETableViewSection *secondControlsSection;
@property (strong, nonatomic) RETableViewSection *thirdControlsSection;

@end

@implementation TYDKCategoryListTwoViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分项列表2";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Configure Views
- (void)configureTableView {
    [super configureTableView];
    
    self.manager[@"TYDKUserInfoItem"] = @"TYDKUserInfoTableViewCell";

    @weakify(self);
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        
        
        TYDKUserInfoItem *item = [[TYDKUserInfoItem alloc] initWithDictionary:nil];
        [item setSelectionHandler:^(TYDKUserInfoItem *item) {
            @strongify(self);

            [item deselectRowAnimated:YES];
            
        }];
        [section addItem:item];
        
        [self.manager addSection:section];
        
        section;
    
    
    });
    
    
    
    
    self.secondControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        RETableViewItem *myConcernItem = [RETableViewItem itemWithTitle:@"我的关注" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            
            @strongify(self);
            [item deselectRowAnimated:YES];

            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        myConcernItem.image = [UIImage imageNamed:@"Heart"];
        myConcernItem.highlightedImage = [UIImage imageNamed:@"Heart_Highlighted"];
        
        [section addItem:myConcernItem];
        
        RETableViewItem *myCollectionItem = [RETableViewItem itemWithTitle:@"我的收藏" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            
            @strongify(self);
            [item deselectRowAnimated:YES];

            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        myCollectionItem.image = [UIImage imageNamed:@"20000118Icon"];
        
        [section addItem:myCollectionItem];
        
        [self.manager addSection:section];
        
        section;
        
    });

    
    
    self.thirdControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        RETableViewItem *aboutItem = [RETableViewItem itemWithTitle:@"关于" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            [item deselectRowAnimated:YES];

            @strongify(self);
            
            TYDKAboutViewController *vc = [[TYDKAboutViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        aboutItem.image = [UIImage imageNamed:@"20000032Icon"];

        [section addItem:aboutItem];
        
        [self.manager addSection:section];
        
        section;
        
    });

}

@end

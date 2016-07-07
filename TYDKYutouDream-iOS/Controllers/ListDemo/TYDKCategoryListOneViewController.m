//
//  TYDKCategoryListOneViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCategoryListOneViewController.h"
#import "TYDKAboutViewController.h"
#import "CoolAdHandler.h"
@interface TYDKCategoryListOneViewController ()

@property (strong, nonatomic) RETableViewSection *secondControlsSection;
@property (strong, nonatomic) RETableViewSection *thirdControlsSection;
@property (strong, nonatomic) RETableViewSection *fourthControlsSection;


@end

@implementation TYDKCategoryListOneViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分项列表1";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views
- (void)configureTableView {
    [super configureTableView];
    
     
    @weakify(self);
    
    
    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        RETableViewItem *messageSettingItem = [RETableViewItem itemWithTitle:@"消息设置" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            @strongify(self);
            
            [item deselectRowAnimated:YES];
            
            NSLog(@"---点击了 消息设置---");
            
            TYDKBaseViewController *vc = [[TYDKBaseViewController alloc] init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        [section addItem:messageSettingItem];
        
        [self.manager addSection:section];
        section;
        
    });
    
    self.secondControlsSection = ({
    
        RETableViewSection *section = [RETableViewSection section];
        
        REBoolItem *playerSettingItem = [REBoolItem itemWithTitle:@"允许非Wi-Fi网络下播放视频" value:NO switchValueChangeHandler:^(REBoolItem *item) {
            
            NSLog(@"---Value: %@---", item.value ? @"YES" : @"NO");
        }];
        
        
        [section addItem:playerSettingItem];
        
        REBoolItem *articleSettingItem = [REBoolItem itemWithTitle:@"文章夜间模式" value:NO switchValueChangeHandler:^(REBoolItem *item) {
            
            @strongify(self);

            self.tableView.backgroundColor = item.value ? [UIColor darkGrayColor] : [UIColor groupTableViewBackgroundColor];
            
        }];
        
        
        [section addItem:articleSettingItem];
        
        RETableViewItem *clearCacheItem = [RETableViewItem itemWithTitle:@"清理缓存" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
            
            [item deselectRowAnimated:YES];
            [[YYWebImageManager sharedManager].cache.diskCache removeAllObjects];
            
            NSUInteger totalCost = [YYWebImageManager sharedManager].cache.diskCache.totalCost / 1024;
            
            NSLog(@"---缓存--- %@",@(totalCost));
            item.detailLabelText = [NSString stringWithFormat:@"%@KB",@(totalCost)];

            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        clearCacheItem.style = UITableViewCellStyleValue1;

        clearCacheItem.detailLabelText = [NSString stringWithFormat:@"%@KB",@([YYWebImageManager sharedManager].cache.diskCache.totalCost / 1024)];
        [section addItem:clearCacheItem];

       
        [self.manager addSection:section];
       
        section;

    });
    
    
    self.thirdControlsSection = ({
    
        RETableViewSection *section = [RETableViewSection section];

        RETableViewItem *aboutItem = [RETableViewItem itemWithTitle:@"关于" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
                                                        
       
            @strongify(self);
            [item deselectRowAnimated:YES];

            TYDKAboutViewController *vc = [[TYDKAboutViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];

        }];
        
     
        [section addItem:aboutItem];

        RETableViewItem *welcomePageItem = [RETableViewItem itemWithTitle:@"欢迎页" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            
            @strongify(self);
            [item deselectRowAnimated:YES];
            [CoolAdHandler showAdvertiseLaunchImage];
            NSTimer *timer = [NSTimer bk_timerWithTimeInterval:1 block:^(NSTimer *timer) {
                @strongify(self);

                static NSInteger counter = 3;
                counter--;
                if (counter < 0) {
                    [timer invalidate];
                    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
                    exit(0);
                }
                [TYDKToolUtilities showMessage:[NSString stringWithFormat:@"倒计时退出 %@",@(counter+1)]
                                        inView:self.view];

            } repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

        }];
        
        
        [section addItem:welcomePageItem];
        
        
        
        
        
        [self.manager addSection:section];
        
        section;
    
    });
    
    self.fourthControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];

        RETableViewItem *exitItem = [RETableViewItem itemWithTitle:@"退出" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
            
            [item deselectRowAnimated:YES];
            @strongify(self);
            
            
        }];
        exitItem.textAlignment = NSTextAlignmentCenter;
        [section addItem:exitItem];
        
        
        [self.manager addSection:section];
        
        section;
    });
}

@end

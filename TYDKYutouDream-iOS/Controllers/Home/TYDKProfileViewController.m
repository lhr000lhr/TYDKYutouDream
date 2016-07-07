//
//  TYDKProfileViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKProfileViewController.h"

#import "TYDKAboutViewController.h"
#import "TYDKLoginViewController.h"
#import "TYDKProfileEditViewController.h"
#import "TYDKMyWishViewController.h"
#import "TYDKMyOfferViewController.h"
#import "TYDKMyWalletViewController.h"

#import "TYDKUserInfoItem.h"
@interface TYDKProfileViewController () <RETableViewManagerDelegate, MZFormSheetBackgroundWindowDelegate>

@property (strong, nonatomic) RETableViewSection *secondControlsSection;
@property (strong, nonatomic) RETableViewSection *thirdControlsSection;
@property (strong, nonatomic) RETableViewSection *logoutControlsSection;

@property (strong, nonatomic) TYDKUserInfoItem *userInfoItem;
@end

@implementation TYDKProfileViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.detailsPageView.backgroundViewColor = [UIColor groupTableViewBackgroundColor];
    [self configureNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);
    self.manager[@"TYDKUserInfoItem"] = @"TYDKUserInfoTableViewCell";
    self.manager.delegate = self;
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        
        self.userInfoItem = ({
            TYDKUserInfoItem *item = [[TYDKUserInfoItem alloc] initWithDictionary:nil];
            [item setSelectionHandler:^(TYDKUserInfoItem *item) {
                @strongify(self);
                
                if (!kUser.isLogin) {
                    TYDKLoginViewController *vc = [[TYDKLoginViewController alloc] init];
                    
                    TYDKBaseNavigationController *nav = [[TYDKBaseNavigationController alloc] initWithRootViewController:vc];
                    
                    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:nav];
                    
                    formSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
                    
                    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
                        
                    }];
                    

                } else {
                    TYDKProfileEditViewController *vc = [[TYDKProfileEditViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
                [item deselectRowAnimated:YES];
            }];
            [section addItem:item];
            item;

        });
        [self.manager addSection:section];
        section;
    });
    
    
    
    self.secondControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        RETableViewItem *myWish = [RETableViewItem itemWithTitle:@"我发起的" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            @strongify(self);
            TYDKMyWishViewController *vc = [[TYDKMyWishViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [item deselectRowAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        myWish.image = [UIImage imageNamed:@"ic_game"];
        
        [section addItem:myWish];
        
        RETableViewItem *myOfferItem = [RETableViewItem itemWithTitle:@"我的参与" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            @strongify(self);
            [item deselectRowAnimated:YES];
            TYDKMyOfferViewController *vc = [[TYDKMyOfferViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        myOfferItem.image = [UIImage imageNamed:@"ic_order"];
        
        [section addItem:myOfferItem];
        
        RETableViewItem *myWalletItem = [RETableViewItem itemWithTitle:@"我的钱包" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            
            @strongify(self);
            [item deselectRowAnimated:YES];
            TYDKMyWalletViewController *vc = [[TYDKMyWalletViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        myWalletItem.image = [UIImage imageNamed:@"ic_wallet"];
        
        [section addItem:myWalletItem];
        
        RETableViewItem *myFeedbackItem = [RETableViewItem itemWithTitle:@"我要吐槽" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            
            @strongify(self);
            [item deselectRowAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        myFeedbackItem.image = [UIImage imageNamed:@"ic_fb"];
        
        [section addItem:myFeedbackItem];
        
        [self.manager addSection:section];
        
        section;
        
    });
    
    
    
    self.thirdControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        RETableViewItem *aboutItem = [RETableViewItem itemWithTitle:@"关于我们" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            [item deselectRowAnimated:YES];
            
            @strongify(self);
            
            TYDKAboutViewController *vc = [[TYDKAboutViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        aboutItem.image = [UIImage imageNamed:@"ic_about"];
        
        [section addItem:aboutItem];
        
        [self.manager addSection:section];
        
        section;
        
    });

    self.logoutControlsSection = ({
    
        RETableViewSection *section = [RETableViewSection section];
        RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"注销" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
                                                        
            
            @strongify(self);
            [item deselectRowAnimated:YES];
            [[TYDKDataManager manager] userLogout];
            
        }];
        
       
        buttonItem.textAlignment = NSTextAlignmentCenter;
        [section addItem:buttonItem];
        if (kUser.isLogin) {
            [self.manager addSection:section];
        }
        
        section;

    
    });
}

- (void)configureStyle {
    [super configureStyle];
    self.manager.style = [self.manager.style TYDKCellStyleDefault];
    self.logoutControlsSection.style = [self.logoutControlsSection.style TYDKCellStylebutton];
}

#pragma mark - Configure Notifications

- (void)configureNotifications {
    
    @weakify(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:kLoginSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        @strongify(self);
        [self.manager removeSection:self.logoutControlsSection];
        [self.manager addSection:self.logoutControlsSection];
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kLogoutSuccessNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        @strongify(self);
        [self.manager removeSection:self.logoutControlsSection];
        [self.tableView reloadData];
    }];
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];

    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]])
            ((UILabel *)view).font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    }

    if ([cell isKindOfClass:[RETableViewCreditCardCell class]]) {
        RETableViewCreditCardCell *ccCell = (RETableViewCreditCardCell *)cell;
        ccCell.creditCardField.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
        ccCell.expirationDateField.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
        ccCell.cvvField.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    }
}

@end

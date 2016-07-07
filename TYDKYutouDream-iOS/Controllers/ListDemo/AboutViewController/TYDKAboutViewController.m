//
//  TYDKAboutViewController.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 12/17/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKAboutViewController.h"

@implementation TYDKAboutViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"关于";
}

#pragma mark - Configure tableView


- (void)configureTableView {
  
    [super configureTableView];

    self.basicControlsSection = ({
    
        RETableViewSection *section = [RETableViewSection section];
        
        RETableViewItem *updateItem = [[RETableViewItem alloc]initWithTitle:@"检查更新" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            [item deselectRowAnimated:YES];

            
        }];
        
//        [section addItem:updateItem];
        
        RETableViewItem *feedbackItiem = [[RETableViewItem alloc]initWithTitle:@"用户反馈" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            
            [item deselectRowAnimated:YES];
            
 
        }];
        
        [section addItem:feedbackItiem];
        
        [self.manager addSection:section];

        section.footerTitle = @"Copyright © 2015 Tydic-lhr. All rights reserved.";
        section;
    

    });
    

    
}


- (void)configureStyle {
    [super configureStyle];
    self.manager.style = [self.manager.style TYDKCellStyleDefault];
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

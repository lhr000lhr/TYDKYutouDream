//
//  TYDKBaseTableViewController.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 10/15/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYDKBaseTableViewController : UITableViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;

@property (assign, nonatomic) BOOL isRequesting;
@property (strong, nonatomic) NSURLSessionDataTask *requestTask;

- (void)configureTableView;
- (void)configureStyle;
@end

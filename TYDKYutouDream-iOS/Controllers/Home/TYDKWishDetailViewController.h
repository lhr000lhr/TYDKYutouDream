//
//  TYDKWishDetailTableViewController.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseTableViewController.h"

@interface TYDKWishDetailViewController : TYDKBaseViewController <RETableViewManagerDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) TYDKWishModel *wish;
@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;

@end

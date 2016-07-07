//
//  TYDKProfileViewController.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseTableViewController.h"

#import "TYDKDetailsPageView.h"
#import "KMGillSansLabel.h"

@interface TYDKProfileViewController : TYDKBaseTableViewController 

@property (weak, nonatomic) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic) IBOutlet TYDKDetailsPageView *detailsPageView;
@property (weak, nonatomic) IBOutlet KMGillSansLightLabel *navBarTitleLabel;

@end

//
//  TYDKGroupMixOneGroupedTableViewCell.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/19/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKPackageItem.h"

@interface TYDKGroupMixOneGroupedTableViewCell : RETableViewCell
@property (strong, nonatomic) TYDKPackageItem *item;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *cellImageViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *cellPackageNameLabels;

@end

//
//  TYDKCardListOneTableViewCell.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/5/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKCardListOneItem.h"
@interface TYDKCardListOneTableViewCell : RETableViewCell

@property (strong, nonatomic) TYDKCardListOneItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *cellAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;

@end

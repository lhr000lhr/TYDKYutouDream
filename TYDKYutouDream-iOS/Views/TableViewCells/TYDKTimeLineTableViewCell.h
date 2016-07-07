//
//  TYDKTimeLineTableViewCell.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/30/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKTimeLineItem.h"

@interface TYDKTimeLineTableViewCell : RETableViewCell

@property (strong, nonatomic) TYDKTimeLineItem *item;
@property (nonatomic, weak) IBOutlet UILabel     *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel     *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel     *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel     *usernameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;

@end

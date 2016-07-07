//
//  TYDKUserInfoTableViewCell.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKUserInfoItem.h"

@interface TYDKUserInfoTableViewCell : RETableViewCell

@property (strong, nonatomic) TYDKUserInfoItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *cellUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellUserNameLabel;

@end

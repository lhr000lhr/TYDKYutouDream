//
//  TYDKImageAndTextTableViewCell.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKImageAndTextItem.h"

@interface TYDKImageAndTextTableViewCell : RETableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@property (strong, nonatomic) TYDKImageAndTextItem *item;

@end

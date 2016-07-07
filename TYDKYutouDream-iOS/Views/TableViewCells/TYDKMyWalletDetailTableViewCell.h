//
//  TYDKMyWalletDetailTableViewCell.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKWalletDetailItem.h"

@interface TYDKMyWalletDetailTableViewCell : RETableViewCell

@property (strong, nonatomic) TYDKWalletDetailItem *item;

@property (weak, nonatomic) IBOutlet UILabel *cellWeekdaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailDescriptonLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSumLabel;

@end

//
//  TYDKMyOffersTableViewCell.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/24/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKMyOfferItem.h"
@interface TYDKMyOffersTableViewCell : RETableViewCell
@property (strong, nonatomic) TYDKMyOfferItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *cellAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellCityButton;


@end

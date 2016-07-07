//
//  TYDKWishDetailOffersTableViewCell.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKWishDetailOfferItem.h"

@interface TYDKWishDetailOffersTableViewCell : RETableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseButtonHeightLayoutConstraint;

@property (strong, nonatomic) TYDKWishDetailOfferItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *cellAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *cellCreateTimeLabel;
@end

//
//  TYDKWishDetalTableViewCell.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKHomeWishListItem.h"

@interface TYDKWishDetalTableViewCell : RETableViewCell
@property (strong, nonatomic) TYDKHomeWishListItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *cellAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellWishPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellCityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellFinishImageView;

@end

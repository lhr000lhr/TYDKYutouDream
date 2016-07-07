//
//  TYDKMyOfferItem.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/24/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

#import "TYDKOfferModel.h"
@interface TYDKMyOfferItem : RETableViewItem

@property (strong, nonatomic) TYDKOfferModel *offer;

- (instancetype)initWithWishModel:(TYDKOfferModel *)model;

@end

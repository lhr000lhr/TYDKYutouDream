//
//  TYDKWishDetailOfferItem.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "RETableViewItem.h"
#import "TYDKOfferModel.h"
@interface TYDKWishDetailOfferItem : RETableViewItem

@property (strong, nonatomic) TYDKOfferModel *offer;
@property (strong, nonatomic) TYDKWishModel *wish;
@property (copy, nonatomic) void (^chooseHandler)(TYDKWishDetailOfferItem *item);

- (instancetype)initWithWishModel:(TYDKWishModel *)wish offer:(TYDKOfferModel *)offer                                        chooseHandler:(void (^)(TYDKWishDetailOfferItem *item))chooseHandler;

@end

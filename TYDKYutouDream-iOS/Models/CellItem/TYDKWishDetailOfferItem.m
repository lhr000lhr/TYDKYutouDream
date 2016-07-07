//
//  TYDKWishDetailOfferItem.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWishDetailOfferItem.h"

@implementation TYDKWishDetailOfferItem

- (instancetype)initWithWishModel:(TYDKWishModel *)wish offer:(TYDKOfferModel *)offer                                        chooseHandler:(void (^)(TYDKWishDetailOfferItem *item))chooseHandler {

    if (self = [super init]) {
        self.offer = offer;
        self.wish = wish;
        self.chooseHandler = chooseHandler;
    }
    
    return self;
}


@end

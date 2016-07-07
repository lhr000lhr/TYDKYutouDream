//
//  TYDKMyOfferItem.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/24/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyOfferItem.h"

@implementation TYDKMyOfferItem

- (instancetype)initWithWishModel:(TYDKOfferModel *)offer {
    
    if (self = [super init]) {
        self.offer = offer;
    }
    
    return self;
}


@end

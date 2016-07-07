//
//  TYDKHomeWishListItem.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKHomeWishListItem.h"

@implementation TYDKHomeWishListItem

- (instancetype)initWithWishModel:(TYDKWishModel *)wish chooseHandler:(void (^)(TYDKHomeWishListItem *item))chooseHandler {
    
    if (self = [super init]) {
        self.wish = wish;
        self.chooseHandler = chooseHandler;
    }
    
    return self;
}
@end

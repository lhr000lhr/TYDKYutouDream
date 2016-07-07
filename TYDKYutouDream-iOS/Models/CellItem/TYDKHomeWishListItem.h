//
//  TYDKHomeWishListItem.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "RETableViewItem.h"
#import "TYDKWishModel.h"
@interface TYDKHomeWishListItem : RETableViewItem

@property (strong, nonatomic) TYDKWishModel *wish;
@property (copy, nonatomic) void (^chooseHandler)(TYDKHomeWishListItem *item);

- (instancetype)initWithWishModel:(TYDKWishModel *)wish chooseHandler:(void (^)(TYDKHomeWishListItem *item))chooseHandler;

@end

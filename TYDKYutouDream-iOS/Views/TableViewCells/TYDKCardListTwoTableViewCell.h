//
//  FirstViewCardTableViewCell.h
//  WallPaperNew
//
//  Created by 李浩然 on 15/3/30.
//  Copyright (c) 2015年 李浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKCardListTwoItem.h"

@interface TYDKCardListTwoTableViewCell : RETableViewCell

@property (strong, nonatomic) TYDKCardListTwoItem *item;

@property (weak, nonatomic) IBOutlet UIView *boarderView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellPageView;
@property (weak, nonatomic) IBOutlet UILabel *cellPraise;
@property (weak, nonatomic) IBOutlet UILabel *cellComment;
@property (weak, nonatomic) IBOutlet UIImageView *cellAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *cellShowImage;


@end

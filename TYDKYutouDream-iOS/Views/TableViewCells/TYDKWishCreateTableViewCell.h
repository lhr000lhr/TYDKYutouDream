//
//  TYDKWishCreateTableViewCell.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/25/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDKWishCreateItem.h"

@interface TYDKWishCreateTableViewCell : RETableViewCell

@property (strong, nonatomic) TYDKWishCreateItem *item;

@property (weak, nonatomic) IBOutlet UITextView *cellTextView;
@property (weak, nonatomic) IBOutlet UILabel *cellCountingLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellNotificationFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellNotificationSecondLabel;

@end

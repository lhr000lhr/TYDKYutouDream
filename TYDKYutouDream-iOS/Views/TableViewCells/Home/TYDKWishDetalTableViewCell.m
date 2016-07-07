//
//  TYDKWishDetalTableViewCell.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWishDetalTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation TYDKWishDetalTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
//        return 90;
    TYDKHomeWishListItem *cellItem = (TYDKHomeWishListItem *)item;
    return [tableViewManager.tableView fd_heightForCellWithIdentifier:NSStringFromClass([cellItem class]) cacheByIndexPath:cellItem.indexPath configuration:^(TYDKWishDetalTableViewCell *cell) {
        [cell configureCell:cellItem];
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
}

- (void)cellWillAppear {
    
    [super cellWillAppear];
    self.accessoryType  = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:self.item];
    if (self.rowIndex % 2) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.984 alpha:1.000];
        
    }else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
}

- (void)configureCell:(TYDKHomeWishListItem *)item {
    
    self.cellNameLabel.text = item.wish.nick_name;
    self.cellDetailLabel.text = item.wish.wish_description;
    [self.cellAvatarImageView setImageURL:[NSURL URLWithString:item.wish.headimg]];
    
    self.cellCityLabel.text = item.wish.city;

    self.cellWishPriceLabel.text = [NSString stringWithFormat:@"¥:%.2f",item.wish.wish_price];
    
    self.cellCreateTimeLabel.text = ({
        
        NSDate *creatDate              = [NSDate dateWithTimeIntervalSince1970:item.wish.create_time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"MMM dd";
        dateFormatter.locale           = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
        [NSString stringWithFormat:@"On %@",[dateFormatter stringFromDate:creatDate]];
        
    });
    
    
    self.cellFinishImageView.hidden = (item.wish.status != TYDKWishStatusDone);
    
}


@end

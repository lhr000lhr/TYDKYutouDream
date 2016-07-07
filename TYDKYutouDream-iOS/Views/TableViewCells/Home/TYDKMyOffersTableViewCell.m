//
//  TYDKMyOffersTableViewCell.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/24/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyOffersTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation TYDKMyOffersTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    //    return 90;
    TYDKMyOfferItem *cellItem = (TYDKMyOfferItem *)item;
    return [tableViewManager.tableView fd_heightForCellWithIdentifier:NSStringFromClass([cellItem class]) cacheByIndexPath:cellItem.indexPath configuration:^(TYDKMyOffersTableViewCell *cell) {
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

#pragma mark -
#pragma mark Cell life cycle

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

- (void)configureCell:(TYDKMyOfferItem *)item {
    
    self.cellNameLabel.text = item.offer.wish_nick_name;
    self.cellDetailLabel.text = item.offer.offer_description;
    
    [self.cellAvatarImageView setImageWithURL:[NSURL URLWithString:item.offer.headimg]
                                  placeholder:[UIImage imageNamed:@"avatar_defult_ios"]];
    
    [self.cellCityButton setTitle:[self translateWishStatus:item]
                         forState:UIControlStateNormal];
    
    
    [self.cellCityButton setTitleColor:[UIColor darkGrayColor]
                              forState:UIControlStateNormal];
    
    self.cellCreateTimeLabel.text = ({
        
        NSDate *creatDate              = [NSDate dateWithTimeIntervalSince1970:item.offer.create_time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"MMM dd";
        dateFormatter.locale           = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
        [NSString stringWithFormat:@"On %@",[dateFormatter stringFromDate:creatDate]];
        
    });
}

#pragma mark - private method

- (NSString *)translateWishStatus:(TYDKMyOfferItem *)item {
    
    switch (item.offer.offer_status) {
        case TYDKOfferStatusInvalid:
            return @"审核未通过";
            break;
        case TYDKOfferStatusCancelled:
            return @"已取消";
            break;
        case TYDKOfferStatusWaitValid:
            return @"待审核";
            break;
        case TYDKOfferStatusValid:
            return @"审核通过";
            break;
        case TYDKOfferStatusConfirm:
            return @"被选择";
            break;
        case TYDKOfferStatusDone:
            return @"已完成";
            break;
        case TYDKOfferStatusPaid:
            return @"确认收入";
            break;
            
        default:
            break;
    }
    
    return @"";
}


@end

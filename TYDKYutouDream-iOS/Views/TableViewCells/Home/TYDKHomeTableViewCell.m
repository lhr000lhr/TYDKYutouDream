//
//  TYDKHomeTableViewCell.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/16/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKHomeTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation TYDKHomeTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    TYDKHomeWishListItem *cellItem = (TYDKHomeWishListItem *)item;
    return [tableViewManager.tableView fd_heightForCellWithIdentifier:NSStringFromClass([cellItem class]) cacheByIndexPath:cellItem.indexPath configuration:^(TYDKHomeTableViewCell *cell) {
        [cell configureCell:cellItem];
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Middle_Selected"]];

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
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    [self.cellAvatarImageView setImageWithURL:[NSURL URLWithString:item.wish.headimg]
                                  placeholder:[UIImage imageNamed:@"avatar_defult_ios"]];
    
    
    [self.cellCityButton setTitle:[self translateWishStatus:item]
                             forState:UIControlStateNormal];
       
    
    [self.cellCityButton setTitleColor:[UIColor darkGrayColor]
                              forState:UIControlStateNormal];
    @weakify(item);
    
    if (![self.cellCityButton bk_hasEventHandlersForControlEvents:UIControlEventAllEvents]) {
        [self.cellCityButton bk_addEventHandler:^(id sender) {
            @strongify(item);
            
            item.chooseHandler(item);
        } forControlEvents:UIControlEventTouchUpInside];
        

    }
    
    self.cellCreateTimeLabel.text = ({
        
        NSDate *creatDate              = [NSDate dateWithTimeIntervalSince1970:item.wish.create_time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"MMM dd";
        dateFormatter.locale           = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
        [NSString stringWithFormat:@"On %@",[dateFormatter stringFromDate:creatDate]];
        
    });
}

#pragma mark - private method

- (NSString *)translateWishStatus:(TYDKHomeWishListItem *)item {
    
    switch (item.wish.status) {
        case TYDKWishStatusComplaint:
            return @"投诉";
            break;
        case TYDKWishStatusOfferRequest:
            return @"取消对接";
            break;
        case TYDKWishStatusInvalid:
            return @"审核未通过";
            break;
        case TYDKWishStatusCanceled:
            return @"已取消";
            break;
        case TYDKWishStatusInit:
            return item.wish.city;
            break;
        case TYDKWishStatusWaitPay:
            return @"待付款";
            break;
        case TYDKWishStatusPaid:
            return @"已付款";
            break;
        case TYDKWishStatusPublish:
            return @"进行中";
            break;
        case TYDKWishStatusOffer:
            return @"有人接单";
            break;
        case TYDKWishStatusStart:
            return @"确认实现";
            break;
        case TYDKWishStatusDone:
            return @"已完成";
            break;
            
        default:
            break;
    }
    
    return @"";
}

@end

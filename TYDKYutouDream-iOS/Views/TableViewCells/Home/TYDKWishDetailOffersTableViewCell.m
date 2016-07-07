//
//  TYDKWishDetailOffersTableViewCell.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWishDetailOffersTableViewCell.h"

@implementation TYDKWishDetailOffersTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    //        return 90;
    TYDKWishDetailOfferItem *cellItem = (TYDKWishDetailOfferItem *)item;
    return [tableViewManager.tableView fd_heightForCellWithIdentifier:NSStringFromClass([cellItem class]) cacheByIndexPath:cellItem.indexPath configuration:^(TYDKWishDetailOffersTableViewCell *cell) {
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

- (void)cellDidLoad {
    [super cellDidLoad];
    
}

- (void)cellWillAppear {
    
    [super cellWillAppear];
    self.accessoryType  = UITableViewCellAccessoryNone;
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.rowIndex % 2) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.984 alpha:1.000];
        
    }else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    [self configureCell:self.item];

}

- (void)configureCell:(TYDKWishDetailOfferItem *)item {
    
    self.cellNameLabel.text       = item.offer.nick_name;
    self.cellDetailLabel.text     = item.offer.offer_description;

    self.cellCreateTimeLabel.text = ({
    
        NSDate *creatDate              = [NSDate dateWithTimeIntervalSince1970:item.offer.create_time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"MMM dd";
        dateFormatter.locale           = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
        [NSString stringWithFormat:@"On %@",[dateFormatter stringFromDate:creatDate]];
    
    });
    
    [self.cellAvatarImageView setImageWithURL:[NSURL URLWithString:item.offer.headimg]
                                  placeholder:[UIImage imageNamed:@"avatar_defult_ios"]];
    
    if ((item.wish.status == TYDKWishStatusOffer) && (item.offer.offer_status != TYDKOfferStatusNoneButton) && kUser.isLogin && item.wish.user_id == kUser.member.ID) {
        [self.cellChooseButton setTitle:@"选择Ta"
                               forState:UIControlStateNormal];
        
        [self.cellChooseButton setTitleColor:[UIColor darkGrayColor]
                                    forState:UIControlStateNormal];
        self.chooseButtonHeightLayoutConstraint.constant = 24;
    } else {
        self.chooseButtonHeightLayoutConstraint.constant = 0;
    }
    @weakify(item);

    [self.cellChooseButton bk_addEventHandler:^(id sender) {
        @strongify(item);

        item.chooseHandler(item);
    } forControlEvents:UIControlEventTouchUpInside];
}
@end

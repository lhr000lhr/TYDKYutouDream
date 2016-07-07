//
//  TYDKCardListOneTableViewCell.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/5/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCardListOneTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation TYDKCardListOneTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    
    TYDKCardListOneItem *cellItem = (TYDKCardListOneItem *)item;
    return [tableViewManager.tableView fd_heightForCellWithIdentifier:NSStringFromClass([cellItem class]) cacheByIndexPath:cellItem.indexPath configuration:^(TYDKCardListOneTableViewCell *cell) {
        [cell configureCell:cellItem];
    }];

}

- (void)awakeFromNib {
    // Initialization code
    self.cellAvatarImageView.layer.masksToBounds = YES;
    self.cellAvatarImageView.layer.cornerRadius  = 50;
    self.cellAvatarImageView.layer.cornerRadius  = CGRectGetHeight(self.cellAvatarImageView.frame)/2;
    self.cellAvatarImageView.layer.masksToBounds = YES;
    self.cellAvatarImageView.layer.shadowColor   = [UIColor whiteColor].CGColor;
    self.cellAvatarImageView.layer.shadowOffset  = CGSizeMake(4.0, 4.0);
    self.cellAvatarImageView.layer.shadowOpacity = 0.5;
    self.cellAvatarImageView.layer.shadowRadius  = 2.0;
    self.cellAvatarImageView.layer.borderColor   = [UIColor whiteColor].CGColor;
    self.cellAvatarImageView.layer.borderWidth   = 2.0f;
    
    [self.cellAvatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.cellAvatarImageView setClipsToBounds:YES];
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
}

- (void)configureCell:(TYDKCardListOneItem *)item {

    self.cellDetailLabel.text      = item.username;
    self.cellNameLabel.text        = item.content;
    self.cellAvatarImageView.image = item.imageName.length > 0 ? [UIImage imageNamed:item.imageName] : [UIImage imageNamed:@"avatar_defult_ios"];
    
}


@end

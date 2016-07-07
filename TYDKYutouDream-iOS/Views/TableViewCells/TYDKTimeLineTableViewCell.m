//
//  TYDKTimeLineTableViewCell.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/30/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKTimeLineTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface TYDKTimeLineTableViewCell ()

@end

@implementation TYDKTimeLineTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {


    TYDKTimeLineItem *cellItem =(TYDKTimeLineItem *)item;
    return [tableViewManager.tableView fd_heightForCellWithIdentifier:NSStringFromClass([cellItem class]) cacheByIndexPath:cellItem.indexPath configuration:^(TYDKTimeLineTableViewCell *cell) {
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
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    
    [self configureCell:self.item];
}

- (void)configureCell:(TYDKTimeLineItem *)item {
    
    self.timeLabel.text         = item.time;
    self.titleLabel.text        = item.mainTitle;
    self.contentLabel.text      = item.content;
    self.usernameLabel.text     = item.username;
    self.contentImageView.image = item.imageName.length > 0 ? [UIImage imageNamed:item.imageName] : nil;

}

@end

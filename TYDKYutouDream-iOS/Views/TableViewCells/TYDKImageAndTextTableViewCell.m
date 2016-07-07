//
//  TYDKImageAndTextTableViewCell.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKImageAndTextTableViewCell.h"

@implementation TYDKImageAndTextTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 90;
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

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;

    [self.mainImageView setImageURL:[NSURL URLWithString:self.item.mainImages]];
    self.mainTitleLabel.text = self.item.mainTitle;
    
}


@end

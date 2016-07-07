//
//  TYDKUserInfoTableViewCell.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/4/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKUserInfoTableViewCell.h"

@implementation TYDKUserInfoTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    return 78;
}

- (void)awakeFromNib {
    // Initialization code
    self.cellUserImageView.layer.masksToBounds = YES;
    self.cellUserImageView.layer.cornerRadius  = 50;
    self.cellUserImageView.layer.cornerRadius  = CGRectGetHeight(self.cellUserImageView.frame)/2;
    self.cellUserImageView.layer.masksToBounds = YES;
    self.cellUserImageView.layer.shadowColor   = [UIColor whiteColor].CGColor;
    self.cellUserImageView.layer.shadowOffset  = CGSizeMake(4.0, 4.0);
    self.cellUserImageView.layer.shadowOpacity = 0.5;
    self.cellUserImageView.layer.shadowRadius  = 2.0;
    self.cellUserImageView.layer.borderColor   = [UIColor whiteColor].CGColor;
    self.cellUserImageView.layer.borderWidth   = 2.0f;
    
    [self.cellUserImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.cellUserImageView setClipsToBounds:YES];
    
    
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
    self.cellUserNameLabel.highlightedTextColor = [UIColor whiteColor];
    [self configureCell:self.item];
}

- (void)configureCell:(TYDKUserInfoItem *)item {

    TYDKUserModel *user = item.user;
    if (user) {
        [self.cellUserImageView setImageURL:[NSURL URLWithString:user.member.headimg]];
        self.cellUserNameLabel.text = user.member.nick_name;
    } else {
        self.cellUserImageView.image = [UIImage imageNamed:@"avatar_defult_ios"];
        self.cellUserNameLabel.text = @"登录";

    }
   
}

@end

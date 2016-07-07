//
//  TYDKUserProfileEditingAvatarView.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/22/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKUserProfileEditingAvatarView.h"


@implementation TYDKUserProfileEditingAvatarView

+ (instancetype)headerViewWithEditingHandler:(TYDKEditingHandler)handler {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TYDKUserProfileEditingAvatarView" owner:self options:nil];
    
    TYDKUserProfileEditingAvatarView *headerView;
    if (nib.count > 0) {
        headerView = [nib objectAtIndex:0];
        [headerView configureView];
        [headerView setAvatarUrl:[NSURL URLWithString:kUser.member.headimg]];
        headerView.handler = handler;
    }
    return headerView;
}

- (IBAction)headerAvatarEditButtonPressed:(UIButton *)sender {
    
    self.handler();
}

#pragma mark - Configure Views

- (void)configureView {
    
  
    self.headerAvatarEditButton.layer.masksToBounds = YES;
    self.headerAvatarEditButton.layer.cornerRadius  = 50;
    self.headerAvatarEditButton.layer.cornerRadius  = CGRectGetHeight(self.headerAvatarEditButton.frame)/2;
    self.headerAvatarEditButton.layer.masksToBounds = YES;
    self.headerAvatarEditButton.layer.shadowColor   = [UIColor whiteColor].CGColor;
    self.headerAvatarEditButton.layer.shadowOffset  = CGSizeMake(4.0, 4.0);
    self.headerAvatarEditButton.layer.shadowOpacity = 0.5;
    self.headerAvatarEditButton.layer.shadowRadius  = 2.0;
    self.headerAvatarEditButton.layer.borderColor   = [UIColor whiteColor].CGColor;
    self.headerAvatarEditButton.layer.borderWidth   = 2.0f;
    
    [self.headerAvatarEditButton setContentMode:UIViewContentModeScaleAspectFill];
    [self.headerAvatarEditButton setClipsToBounds:YES];
}

#pragma mark - setter
- (void)setAvatarUrl:(NSURL *)avatarUrl {
    if (avatarUrl) {
        _avatarUrl = avatarUrl;
        [self.headerAvatarEditButton setBackgroundImageWithURL:avatarUrl
                                                            forState:UIControlStateNormal
                                                         placeholder:[UIImage imageNamed:@"avatar_defult_ios"]];
    }
    
    
}

@end

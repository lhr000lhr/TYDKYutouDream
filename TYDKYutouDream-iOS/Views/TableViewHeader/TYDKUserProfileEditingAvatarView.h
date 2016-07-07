//
//  TYDKUserProfileEditingAvatarView.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/22/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TYDKEditingHandler)(void);


@interface TYDKUserProfileEditingAvatarView : UIView
@property (weak, nonatomic) IBOutlet UIButton *headerAvatarEditButton;
@property (copy, nonatomic) TYDKEditingHandler handler;
@property (copy, nonatomic) NSURL *avatarUrl;
+ (instancetype)headerViewWithEditingHandler:(TYDKEditingHandler)handler;

- (IBAction)headerAvatarEditButtonPressed:(UIButton *)sender;
@end

//
//  TYDKBaseViewController.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 10/12/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYDKBaseViewController : UIViewController <UINavigationControllerDelegate>

@property (assign, nonatomic) BOOL isRequesting;
@property (strong, nonatomic) NSURLSessionDataTask *requestTask;

- (void)configureViews;

@end

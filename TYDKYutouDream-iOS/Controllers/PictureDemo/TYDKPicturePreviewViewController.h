//
//  TYDKPicturePreviewViewController.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/11/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseTableViewController.h"

@interface TYDKPicturePreviewViewController : TYDKBaseTableViewController
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

- (IBAction)handleTapGestureRecognizer:(UITapGestureRecognizer *)recognizer;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

@end

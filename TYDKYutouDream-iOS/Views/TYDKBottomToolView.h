//
//  TYDKBottomToolView.h
//  
//
//  Created by 李浩然 on 3/3/16.
//
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(UIButton *button);


@interface TYDKBottomToolView : UIView

@property (strong, nonatomic) IBOutlet UIButton *toolViewButton;
@property (copy, nonatomic) buttonClick cancelButtonBlock;

+ (instancetype)getBottomToolView;

- (void)showInView:(UIView *)view;

- (void)remove;
@end

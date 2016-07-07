//
//  TYDKBottomToolView.m
//  
//
//  Created by 李浩然 on 3/3/16.
//
//

#import "TYDKBottomToolView.h"
@interface TYDKBottomToolView ()

@property (assign, nonatomic) BOOL isShowing;

@end

@implementation TYDKBottomToolView

+ (instancetype)getBottomToolView {
    
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TYDKBottomToolView" owner:self options:nil];
    
    
    TYDKBottomToolView *toolView = [nib objectAtIndex:0];
    
    toolView.height = 40;
    return toolView;
    
}



- (void)showInView:(UIView *)view {
    
    
    self.isShowing = YES;
    
    [self removeFromSuperview];
    self.alpha = 0;
    CGRect beforFrame = view.bounds;
    
    self.frame = CGRectMake(0, CGRectGetHeight(beforFrame), CGRectGetWidth(beforFrame), CGRectGetHeight(self.frame));
    
    
    [view addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect afterFrame = view.frame;

        self.alpha = 1;
        self.frame = CGRectMake(0, CGRectGetHeight(afterFrame) - 2 * CGRectGetHeight(self.frame), CGRectGetWidth(afterFrame), CGRectGetHeight(self.frame));
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
    
}
- (void)remove {
    self.isShowing = NO;
    
    UIView *view = self.superview;
    self.alpha = 1;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect afterFrame = view.frame;

        self.alpha = 0;
        self.frame = CGRectMake(0, CGRectGetHeight(afterFrame) + CGRectGetHeight(self.frame), CGRectGetWidth(afterFrame), CGRectGetHeight(self.frame));
        
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.cancelButtonBlock = nil;
    }];
    
}

#pragma mark - private method

- (IBAction)buttonPressed:(UIButton *)sender {
  
    __weak UIButton *button = sender;
    self.cancelButtonBlock(button);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.toolViewButton.frame = self.frame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

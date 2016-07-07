//
//  UILabel+HECountingLabel.m
//  kanthealth
//
//  Created by qsheal on 15/2/2.
//  Copyright (c) 2015年 kanthealth. All rights reserved.
//

#import "UILabel+HECountingLabel.h"

@implementation UILabel (HECountingLabel)



- (void)setTextWithCountingEffect:(CGFloat)CountingNumber decimalNum:(NSInteger)digits {
  

    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 1.0;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSLog(@"Animation type is %@",kCAMediaTimingFunctionEaseIn);
    
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        };
        // write value
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            NSString* format = [NSString stringWithFormat:@"%%.%ldf",(long)digits];
            
            NSString* resultStr = [NSString stringWithFormat:format,values[0]];
            
            [obj setText:[NSString stringWithFormat:@"%@",resultStr]];
        };
        // dynamics threshold
        prop.threshold = 0.01;
    }];
    
    anim.property = prop;
    anim.fromValue = @(CountingNumber*0.8);
  
    anim.toValue = @(CountingNumber);
    
    [self pop_addAnimation:anim forKey:@"countinglabel"];
    /////使用facebook pop填充分数

    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animation.toValue = @(1.0);
    animation.fromValue = @(0.0);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    [self pop_addAnimation:animation forKey:@"labelAlpha"];

    
}
@end

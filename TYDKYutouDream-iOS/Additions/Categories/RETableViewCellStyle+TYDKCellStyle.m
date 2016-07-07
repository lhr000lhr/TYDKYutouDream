//
//  RETableViewCellStyle+TYDKCellStyle.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 12/16/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "RETableViewCellStyle+TYDKCellStyle.h"

@implementation RETableViewCellStyle (TYDKCellStyle)

- (RETableViewCellStyle *)TYDKCellStyleDefault {
    
    RETableViewCellStyle *style = self.copy;
    
    [style setBackgroundImage:[[UIImage imageNamed:@"First"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                 forCellType:RETableViewCellTypeFirst];
    [style setBackgroundImage:[[UIImage imageNamed:@"Middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                 forCellType:RETableViewCellTypeMiddle];
    [style setBackgroundImage:[[UIImage imageNamed:@"Last"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                 forCellType:RETableViewCellTypeLast];
    [style setBackgroundImage:[[UIImage imageNamed:@"Single"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                 forCellType:RETableViewCellTypeSingle];
    // Set selected cell background image
    //
    
    [style setSelectedBackgroundImage:[[UIImage imageNamed:@"First_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                         forCellType:RETableViewCellTypeFirst];
    [style setSelectedBackgroundImage:[[UIImage imageNamed:@"Middle_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                         forCellType:RETableViewCellTypeMiddle];
    [style setSelectedBackgroundImage:[[UIImage imageNamed:@"Last_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                         forCellType:RETableViewCellTypeLast];
    [style setSelectedBackgroundImage:[[UIImage imageNamed:@"Single_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                         forCellType:RETableViewCellTypeSingle];
    
    return style;

}


- (RETableViewCellStyle *)TYDKCellStylebutton {
    
    RETableViewCellStyle *style = self.copy;

    style.backgroundImageMargin = 10.0;
    
    style = [style TYDKCellStyleDefault];
    
    return style;
}
@end

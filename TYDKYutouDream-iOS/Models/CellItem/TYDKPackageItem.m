//
//  TYDKPackageItem.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/19/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKPackageItem.h"

@implementation TYDKPackageItem

- (instancetype)initWithPackages:(NSArray *)packages {
    
    if (self = [super init]) {
        
        _packages = packages;
        
    }
    
    return self;
}
@end

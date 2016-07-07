//
//  TYDKPackageItem.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/19/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "RETableViewItem.h"

@interface TYDKPackageItem : RETableViewItem

- (instancetype)initWithPackages:(NSArray *)packages;
@property (nonatomic, copy, readonly) NSArray *packages;

@end

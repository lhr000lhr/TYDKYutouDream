//
//  TYDKTimeLineItem.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/30/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKTimeLineItem.h"

@implementation TYDKTimeLineItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
 
        _identifier = [self uniqueIdentifier];
        _mainTitle  = [dictionary km_safeStringForKey:@"title"];
        _content    = [dictionary km_safeStringForKey:@"content"];
        _username   = [dictionary km_safeStringForKey:@"username"];
        _time       = [dictionary km_safeStringForKey:@"time"];
        _imageName  = [dictionary km_safeStringForKey:@"imageName"];
        
    }
    
    return self;
}

- (NSString *)uniqueIdentifier {
    
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end

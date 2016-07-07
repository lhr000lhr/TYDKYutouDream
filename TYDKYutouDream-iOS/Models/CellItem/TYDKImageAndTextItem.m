//
//  TYDKImageAndTextItem.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKImageAndTextItem.h"

@implementation TYDKImageAndTextItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {

        self.mainImages = [dictionary km_safeArrayForKey:@"images"].firstObject;
        self.mainTitle  = [dictionary km_safeStringForKey:@"title"];
        self.mainURL    = [NSString stringWithFormat:@"http://daily.zhihu.com/story/%@",[dictionary km_safeNumberForKey:@"id"]];

    }
    
    return self;
}
@end

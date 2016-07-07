//
//  TYDKImageAndTextItem.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "RETableViewItem.h"

@interface TYDKImageAndTextItem : RETableViewItem

@property (copy, nonatomic) NSString *mainImages;
@property (copy, nonatomic) NSString *mainTitle;
@property (copy, nonatomic) NSString *mainURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

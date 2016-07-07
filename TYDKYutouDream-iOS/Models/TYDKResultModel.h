//
//  TYDKResultModel.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 10/9/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKBaseModel.h"

typedef NS_ENUM(NSUInteger, TYDKResultCode) {
    TYDKResultCodeFail = 0,
    TYDKResultCodeSuccess = 1,
    
};

@interface TYDKResultModel : TYDKBaseModel

@property (nonatomic, assign) TYDKResultCode flag;
@property (nonatomic, copy) id msg;

@end

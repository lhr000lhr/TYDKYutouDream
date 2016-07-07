//
//  TYDKPaymentModel.h
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/28/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKBaseModel.h"

@interface TYDKPaymentModel : TYDKBaseModel

@property (assign, nonatomic) NSInteger pay;
@property (copy, nonatomic) NSString *wish_id;
//msg =     {
//    pay = 12312312;
//    "wish_id" = iJhKbyIyQZa2lEIm;
//};
@end

//
//  TDKGoodsCollectionViewCell.h
//  TYDK-iOSAPPTutorial
//
//  Created by 云冯 on 15/12/31.
//  Copyright © 2015年 tydic-lhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYDKGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPriceLabel;

@end

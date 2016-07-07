//
//  FirstViewCardTableViewCell.m
//  WallPaperNew
//
//  Created by 李浩然 on 15/3/30.
//  Copyright (c) 2015年 李浩然. All rights reserved.
//

#import "TYDKCardListTwoTableViewCell.h"

@implementation TYDKCardListTwoTableViewCell


+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    
    return 282;

}

- (void)awakeFromNib {
    // Initialization code
    
    self.boarderView.layer.cornerRadius = 4;
    
    self.boarderView.layer.masksToBounds = YES;
    self.cellAvatar.layer.masksToBounds =YES;
    self.cellAvatar.layer.cornerRadius =50;
    self.cellAvatar.layer.cornerRadius = self.cellAvatar.frame.size.height/2;
    self.cellAvatar.layer.masksToBounds = YES;
    [self.cellAvatar setContentMode:UIViewContentModeScaleAspectFill];
    [self.cellAvatar setClipsToBounds:YES];
    self.cellAvatar.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.cellAvatar.layer.shadowOffset = CGSizeMake(4.0, 4.0);
    self.cellAvatar.layer.shadowOpacity = 0.5;
    self.cellAvatar.layer.shadowRadius = 2.0;
    self.cellAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cellAvatar.layer.borderWidth = 2.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Cell life cycle

- (void)cellDidLoad {
    [super cellDidLoad];
    
}

- (void)cellWillAppear {
    [super cellWillAppear];

    self.accessoryType  = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:self.item];
}

- (void)configureCell:(TYDKCardListTwoItem *)item {
    
  
    self.cellTitle.text = item.mainTitle;
    YYWebImageOptions option = YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation;
    [self.cellShowImage setImageWithURL:[NSURL URLWithString:item.mainImages] options:option];
    
    
}

//-(void)setContentWithData:(BmobObject *)object
//{
// 
//    if (object) {
//        
//        self.cellTitle.text =  [object objectForKey:@"Title"];
//        BmobFile *fileName =  [object objectForKey:@"ImageData"];
//        UIColor *textColor;
//        
//        if ([(NSArray *)[object objectForKey:@"primaryTextColor"] count] == 3) {
//            textColor = [UIColor colorArray:[object objectForKey:@"primaryTextColor"]];
//            self.cellTitle.textColor = textColor;
//            self.cellPageView.textColor = textColor;
//            self.cellPraise.textColor = textColor;
//            self.cellShowImage.backgroundColor = [UIColor colorWithFlatVersionOf:textColor];
//        }
//        
//        
//        
//        [self.cellShowImage sd_setImageWithURL:[NSURL URLWithString:fileName.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//            if ([(NSArray *)[object objectForKey:@"primaryTextColor"] count]!= 3) {
//                
//            
//            LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
//            LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:image];
////            self.cellTitle.superview.backgroundColor = colorScheme.backgroundColor;
//            self.cellTitle.textColor = colorScheme.primaryTextColor;
//            self.cellPageView.textColor = colorScheme.primaryTextColor;
//            self.cellPraise.textColor =colorScheme.primaryTextColor;
//                
//                NSArray *colorArray = [UIColor changeUIColorToRGB:colorScheme.primaryTextColor];
//                [object setObject:colorArray forKey:@"primaryTextColor"];
//                //异步更新数据
//                [object updateInBackground];
//            //将计算出来的颜色返回给服务器，供下次使用。
//                
//                
//                
//            }
//        }];
//        
//        self.cellPageView.text = [NSString stringWithFormat:@"%ld",(long)[NSString stringWithFormat:@"%@",[object objectForKey:@"PageView"]].integerValue];
//        self.cellPraise.text = [NSString stringWithFormat:@"%ld",(long)[NSString stringWithFormat:@"%@",[object objectForKey:@"Praise"]].integerValue] ;
//        
//        
//        
//    }
//
//    
//    
//}

@end

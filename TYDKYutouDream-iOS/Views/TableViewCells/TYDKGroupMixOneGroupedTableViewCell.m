//
//  TYDKGroupMixOneGroupedTableViewCell.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/19/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKGroupMixOneGroupedTableViewCell.h"

@implementation TYDKGroupMixOneGroupedTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    return 228;
}


- (void)awakeFromNib {
    // Initialization code
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType  = UITableViewCellAccessoryNone;
    [self configureCell:self.item];
}

- (void)configureCell:(TYDKPackageItem *)item {
    
    NSArray *data = item.packages;
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *rowData = obj;
        UILabel *packageName = self.cellPackageNameLabels[idx];
        packageName.text = [rowData km_safeStringForKey:@"title"];
        UIImageView *packageImage = self.cellImageViews[idx];
        YYWebImageOptions option = YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation;
        NSString *imageString = [[rowData km_safeArrayForKey:@"images"] km_safeStringAtIndex:0];
        
        [packageImage setImageWithURL:[NSURL URLWithString:imageString] options:option];
    
    
    }];
}

@end

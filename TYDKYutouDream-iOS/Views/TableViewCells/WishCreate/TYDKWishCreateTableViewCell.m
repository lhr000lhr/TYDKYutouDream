//
//  TYDKWishCreateTableViewCell.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/25/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWishCreateTableViewCell.h"

static NSUInteger const kMaxNumber = 100;

@implementation TYDKWishCreateTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    return 220;
    
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
  
    @weakify(self);
    RACSignal *showNotificationLabelSignal = [self.cellTextView.rac_textSignal map:^id(NSString *inputText) {
         @strongify(self)
         self.cellCountingLabel.text = [NSString stringWithFormat:@"还能输入%@个字",@(kMaxNumber-inputText.length)];
         self.item.inputText = inputText;
         return @(inputText.length > 0);
     }];
    RAC(self.cellNotificationSecondLabel,hidden) = showNotificationLabelSignal;
    RAC(self.cellNotificationFirstLabel,hidden)  = showNotificationLabelSignal;

}

- (void)cellWillAppear {
    [super cellWillAppear];

}

@end

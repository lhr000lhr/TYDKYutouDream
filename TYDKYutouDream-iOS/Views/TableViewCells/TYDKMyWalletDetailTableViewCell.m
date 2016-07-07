//
//  TYDKMyWalletDetailTableViewCell.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyWalletDetailTableViewCell.h"
@interface TYDKMyWalletDetailTableViewCell ()

@property (strong, nonatomic) NSDictionary *descriptions;
@end

@implementation TYDKMyWalletDetailTableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager {
    
    return 70;
    
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
    
    @weakify(self);
    self.accessoryType  = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:self.item];
    if (self.rowIndex % 2) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.984 alpha:1.000];
        
    }else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
}

- (void)configureCell:(TYDKWalletDetailItem *)item {
    TYDKWalletDetailModel *model = item.walletDetail;
    
    self.cellDateLabel.text = ({
    
        NSDate *creatDate = [[NSDate alloc] initWithTimeIntervalSince1970:model.create_time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"MM-dd";
        [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:creatDate]];

    });
    
    self.cellWeekdaysLabel.text = ({
    
        NSDate *creatDate = [[NSDate alloc] initWithTimeIntervalSince1970:model.create_time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"EEE";
        [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:creatDate]];

    });
  
    self.cellSumLabel.text = [NSString stringWithFormat:@"%.2lf",model.amount];
    self.cellDetailDescriptonLabel.text = ({
        
        [NSString stringWithFormat:@"Desc:%@",[self.descriptions km_safeStringForKey:@(model.item_type)]];
    });
    
    
    self.cellDetailImageView.image = ({
        UIImage *image;
        
        switch (model.item_type) {
            case TYDKWalletDetailItemTypeWithDrawPayOut:
            case TYDKWalletDetailItemTypeFreezePayOut:
            case TYDKWalletDetailItemTypeWishPayOut:
                image = [UIImage imageNamed:@"ic_out"];
                break;
                
            case TYDKWalletDetailItemTypeOfferIncome:
            case TYDKWalletDetailItemTypeBonusIncome:
            case TYDKWalletDetailItemTypeRefundIncome:
            case TYDKWalletDetailItemTypeUnfreezeIncome:
            case TYDKWalletDetailItemTypeRechargeIncome:
                image = [UIImage imageNamed:@"ic_in"];
                break;

            default:
                break;
        }
        
        
        image;
        
    });
}

#pragma mark - getter

- (NSDictionary *)descriptions {
    
    if (!_descriptions) {
        _descriptions = @{
                          @(TYDKWalletDetailItemTypeWithDrawPayOut) : @"发布支出",
                          @(TYDKWalletDetailItemTypeFreezePayOut) : @"冻结支出",
                          @(TYDKWalletDetailItemTypeWishPayOut) : @"提现支出",
                          @(TYDKWalletDetailItemTypeOfferIncome) : @"接单收入",
                          @(TYDKWalletDetailItemTypeBonusIncome) : @"分成收入",
                          @(TYDKWalletDetailItemTypeRefundIncome) : @"退款收入",
                          @(TYDKWalletDetailItemTypeUnfreezeIncome) : @"解冻收入",
                          @(TYDKWalletDetailItemTypeRechargeIncome) : @"充值收入",
                          
                          };
    }
    return _descriptions;
}


@end

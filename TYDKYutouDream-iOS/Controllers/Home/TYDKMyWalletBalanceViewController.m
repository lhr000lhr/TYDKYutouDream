//
//  TYDKMyWalletBalanceViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/1/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyWalletBalanceViewController.h"
#import "UILabel+HECountingLabel.h"

@interface TYDKMyWalletBalanceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation TYDKMyWalletBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestBalance];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - request balance

- (void)requestBalance {
    
    self.requestTask = [[TYDKDataManager manager] getBalance:^(CGFloat balance) {
        [self.balanceLabel setTextWithCountingEffect:balance decimalNum:2];
    } failure:^(NSError *error) {
        
    }];
}

@end

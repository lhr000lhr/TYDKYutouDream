//
//  TYDKCreateOfferViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 3/3/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCreateOfferViewController.h"

@interface TYDKCreateOfferViewController ()

@property (strong, nonatomic) RELongTextItem *offerDescriptionItem;

@property (strong, nonatomic) UIBarButtonItem *confirmButton;

@end

@implementation TYDKCreateOfferViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名";
    [self configureNavigationItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureNavigationItem {
    
    @weakify(self);
    self.confirmButton = ({
        
        UIBarButtonItem *button = [[UIBarButtonItem alloc] bk_initWithTitle:@"报名" style:UIBarButtonItemStylePlain handler:^(UIBarButtonItem *button) {
            
            @strongify(self)
            
            self.requestTask = [[TYDKDataManager manager] createChargeWithWishID:self.wish.ID offerDescription:self.offerDescriptionItem.value success:^(TYDKResultModel *result) {
                
                
                [UIAlertView bk_showAlertViewWithTitle:@"接单成功" message:@"等待审核" cancelButtonTitle:@"好" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    @strongify(self)

                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                
                
                
            } failure:^(NSError *error) {
                
                
                
                
                
            }];
        }];
        button.enabled = NO;
        self.navigationItem.rightBarButtonItem = button;
        
        [[RACSignal combineLatest:@[RACObserve(self, self.offerDescriptionItem.value)]
                           reduce:^id(NSString *confirmCode){
                               
                               return @(confirmCode.length >= 4);
                           }]
         subscribeNext:^(NSNumber *x) {
             @strongify(self)
             NSLog(@"X Class: %@",x);
             self.confirmButton.enabled = [x boolValue];
         }];
        
        
        button;
    });

}

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);

    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        [self.manager addSection:section];
        self.offerDescriptionItem = ({
            RELongTextItem *item = [RELongTextItem itemWithValue:nil placeholder:@"为啥子想报名\n肯定要说清楚嘛\n认真填哈"];
            item.cellHeight = 220;
            item.charactersLimit = 100;
            
            [section addItem:item];
            item;
        });
        section;
    });
    
}




@end

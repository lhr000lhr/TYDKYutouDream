//
//  TYDKCreateWishViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/25/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKCreateWishViewController.h"
#import "RETableViewOptionsController.h"

#import "TYDKWishCreateItem.h"

#import "Pingpp.h"

static NSString *kServerChargeURL = @"http://daidai.91douya.com/index.php/pay/requestCharge";

@interface TYDKCreateWishViewController ()

@property (strong, nonatomic) NSArray<TYDKCityModel *> *cityModels;
@property (strong, nonatomic) NSArray<NSString *> *cities;

@property (strong, nonatomic) RETableViewSection *wishPriceSection;
@property (strong, nonatomic) RETableViewSection *wishCitySection;

@property (strong, nonatomic) TYDKWishCreateItem *wishContentItem;
@property (strong, nonatomic) RETextItem *wishPriceItem;
@property (strong, nonatomic) RERadioItem *wishCityItem;

@end

@implementation TYDKCreateWishViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"悬赏";
    [Pingpp setDebugMode:YES];
    [Pingpp enableBtn:PingppBtnAlipay|PingppBtnWx];

    [self configureNavigationItem];
    [self requestCitysWithItem:self.wishCityItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureNavigationItem {
    
    @weakify(self);

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain handler:^(UIBarButtonItem *button) {
        @strongify(self)

        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    self.navigationItem.rightBarButtonItem = ({
        
        UIBarButtonItem *button = [[UIBarButtonItem alloc] bk_initWithTitle:@"发布" style:UIBarButtonItemStylePlain handler:^(UIBarButtonItem *button) {
            @strongify(self)

            [self publishWish];
        }];
        button.enabled = NO;
        button;
    
    
    });
    
    [[RACSignal combineLatest:@[RACObserve(self, self.wishPriceItem.value),
                                RACObserve(self, self.wishContentItem.inputText),
                                RACObserve(self, self.wishCityItem.value)]
                       reduce:^id(NSString *price, NSString *content, NSString *city){
                           return @(price.length > 0 && content.length > 0 && city.length > 0);
                           
                       }]
     subscribeNext:^(NSNumber *x) {
         @strongify(self)
         self.navigationItem.rightBarButtonItem.enabled = [x boolValue];
         
     }];

    
    
}

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);
    self.manager[@"TYDKWishCreateItem"] = @"TYDKWishCreateTableViewCell";

    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        self.wishContentItem = ({
            TYDKWishCreateItem *item = [TYDKWishCreateItem item];
            [section addItem:item];
            item;
        });
        
       
        [self.manager addSection:section];
        section;
    });
    
    self.wishPriceSection = ({
        RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"行行好三"];
        
        self.wishPriceItem = ({
            
            RETextItem *item = [RETextItem itemWithTitle:@"金额" value:nil placeholder:@"填写金额"];
            item.keyboardType = UIKeyboardTypeDecimalPad;
            [section addItem:item];

            item;
        });
        [self.manager addSection:section];
        section;
    });
    
    self.wishCitySection = ({
        RETableViewSection *section = [RETableViewSection section];
        section.footerTitle = @"发布成功后,请耐心等待他人报名\n当有人报名时,各人进切选一哈";
        self.wishCityItem = ({
            RERadioItem *item = [RERadioItem itemWithTitle:@"选择城市" value:@"" selectionHandler:^(RERadioItem *item) {
                [item deselectRowAnimated:YES];
                @strongify(self);
                [self requestCitysWithItem:item];
                
            }];
            [section addItem:item];
            item;
        });
    
        [self.manager addSection:section];
        section;
    });
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    if ([cell isKindOfClass:[RETableViewTextCell class]]) {
        RETableViewTextCell *ccCell = (RETableViewTextCell *)cell;
        //        ccCell.textField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        ccCell.textField.textAlignment = NSTextAlignmentRight;
    }
}


#pragma mark - request Cities

- (void)requestCitysWithItem:(RERadioItem *)item {
    
    @weakify(self);

    if (!self.cityModels) {
        [[TYDKDataManager manager] getAllCitiesSuccess:^(NSArray<TYDKCityModel *> *list) {
            self.cityModels = list;
            self.cities = [self getCities:list];
            self.wishCityItem.value = @"成都";
            [self.wishCityItem reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(NSError *error) {
            
        }];
        return;
    }

    RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:self.cities multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
        @strongify(self);

        [self.navigationController popViewControllerAnimated:YES];
        
        [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    optionsController.style = item.section.style;
    [self.navigationController pushViewController:optionsController animated:YES];

}

- (void)publishWish {
    
    @weakify(self);

    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionRight];
    TYDKCityModel *cityModel = [self getCityModel:self.wishCityItem.value];
    self.requestTask = [[TYDKDataManager manager] createWishWithWishDescription:self.wishContentItem.inputText wishPrice:self.wishPriceItem.value cityCode:cityModel.code success:^(TYDKPaymentModel *payment) {
        
        if (payment.pay == 0) {
            [self.navigationItem stopAnimating];

            [UIAlertView bk_showAlertViewWithTitle:@"发布成功" message:nil cancelButtonTitle:@"好" otherButtonTitles:@[@"查看我的梦想"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                NSLog(@"点击了%@",@(buttonIndex));
                @strongify(self);

                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            return ;
        }
        NSString *wishID = payment.wish_id;
        
        
        
        NSArray *extra = @[
                               @[
                                   kUser.name, @[self.wishContentItem.inputText]
                               
                                   ],
                               ];
            

        [Pingpp payWithOrderNo:wishID
                        amount:[self.wishPriceItem.value doubleValue] * 100
                       display:extra
                     serverURL:kServerChargeURL
                  customParams:nil
                  appURLScheme:@"yutouwuwuapp" // Info.plist 中的 CFBundleURLSchemes 对应
                viewController:self
             completionHandler:^(NSString *result, PingppError *error) {
                     NSLog(@">>>>>>> %@", result);
                        [self.navigationItem stopAnimating];
                        [UIAlertView bk_showAlertViewWithTitle:@"支付情况" message:result cancelButtonTitle:@"好" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                            
                        }];
                 }];
        
     
        
        
    } failure:^(NSError *error) {
        [self.navigationItem stopAnimating];

    }];
    
    
}

#pragma mark - pay


#pragma mark - Private Methods

- (NSArray *)getCities:(NSArray *)cityModels {
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (TYDKCityModel *model in cityModels) {
        
        [array addObject:model.city];
        
    }
    
    return array;
    
}

- (TYDKCityModel *)getCityModel:(NSString *)city {
    
    __block TYDKCityModel *cityModel;
    [self.cityModels enumerateObjectsUsingBlock:^(TYDKCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.city isEqualToString:city]) {
            cityModel = obj;
            *stop = YES;
        }
        
    }];
    return cityModel;

}
@end

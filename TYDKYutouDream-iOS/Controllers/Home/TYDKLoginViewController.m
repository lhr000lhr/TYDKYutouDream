//
//  TYDKLoginViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/18/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKLoginViewController.h"

static NSUInteger waitTime = 60;

@interface TYDKLoginViewController ()
@property (strong, readwrite, nonatomic) RETextItem *phoneNumberItem;
@property (strong, readwrite, nonatomic) RETextItem *confirmCodeItem;

@property (strong, nonatomic) UIBarButtonItem *confirmButton;
@end

@implementation TYDKLoginViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"授权登录";
    [self configureNavigationItem];
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
        
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
    }];

}

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);
  
    
    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"" footerTitle:@"通过手机号快速注册/登录 - ( ゜- ゜)つロ"];
        
        self.phoneNumberItem = ({
        
            RETextItem *item = [RETextItem itemWithTitle:@"手机号码" value:@"" placeholder:@"请输入手机号码"];
            item.keyboardType = UIKeyboardTypePhonePad;
            [section addItem:item];
            item;
        
        });
        self.confirmCodeItem = ({
        
            RETextItem *item = [RETextItem itemWithTitle:@"验证码" value:@"" placeholder:@"请输入验证码"];
            item.accessoryView = ({
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 50, 40)];
                [button setTitleColor:TYDKThemeColor forState:UIControlStateNormal];
                [button setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateDisabled];
                [button setTitle:@"获取" forState:UIControlStateNormal];
                [button bk_addEventHandler:^(id sender) {
                    
                    [button setEnabled:NO];
                    [button setTitle:[NSString stringWithFormat:@"%@秒",@(waitTime)] forState:UIControlStateDisabled];
                    @strongify(self)

                    [[TYDKDataManager manager] sendSMSWithPhoneNumber:self.phoneNumberItem.value
                                                              success:^(TYDKResultModel *result) {
                       [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
                            
                            if (waitTime != 0) {
                                [button setTitle:[NSString stringWithFormat:@"%@秒",@(waitTime)] forState:UIControlStateDisabled];
                                waitTime--;
                            } else {
                                waitTime = 60;
                                [button setEnabled:YES];
                                [timer invalidate];
                            }
                        } repeats:YES];
                    } failure:^(NSError *error) {
                        
                        waitTime = 60;
                        [button setEnabled:YES];
                    }];
                    
                    
                } forControlEvents:UIControlEventTouchUpInside];
                button;
            });
            item.keyboardType = UIKeyboardTypePhonePad;
            [section addItem:item];
            item;
        
        });
        
        [self.manager addSection:section];
        section;
    
    });
    
//    self.confirmButtonSection = ({
//    
//        RETableViewSection *section = [RETableViewSection section];
//        
//        RETableViewItem *item = [RETableViewItem itemWithTitle:@"确认授权"];
//        item.textAlignment = NSTextAlignmentCenter;
//        [item setSelectionHandler:^(RETableViewItem *item) {
//            @strongify(self);
//
//        }];
//        [section addItem:item];
//        
//        [self.manager addSection:section];
//        
//        section;
//    
//    
//    
//    
//    
//    
//    
//    });
    
    self.confirmButton = ({
    
        UIBarButtonItem *button = [[UIBarButtonItem alloc] bk_initWithTitle:@"授权" style:UIBarButtonItemStylePlain handler:^(UIBarButtonItem *button) {
            
            @strongify(self)

            self.requestTask = [[TYDKDataManager manager] loginWithPhoneNumber:self.phoneNumberItem.value code:self.confirmCodeItem.value success:^(TYDKMemberModel *member) {
                @strongify(self)

                TYDKUserModel *user = [[TYDKUserModel alloc] initWithMember:member];
                [self finishLoginConfiguration:user];
            } failure:^(NSError *error) {
                
            }];

        }];
        button.enabled = NO;
        self.navigationItem.rightBarButtonItem = button;
        
        [[RACSignal combineLatest:@[RACObserve(self, self.confirmCodeItem.value)]
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

#pragma mark - Private Methods

- (void)finishLoginConfiguration:(TYDKUserModel *)user {
    
    [TYDKDataManager manager].user = user;
    [user saveUser];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:user];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController * _Nonnull formSheetController) {
        
    }];
}



@end

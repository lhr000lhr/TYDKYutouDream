//
//  TYDKBaseViewController.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 10/12/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKBaseViewController.h"

@interface TYDKBaseViewController ()



@end

@implementation TYDKBaseViewController

- (instancetype)init {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    @try {
  
        self = [storyboard instantiateViewControllerWithIdentifier:[[self class] description]];

    }
    @catch (NSException *exception) {
    
       
        self = [super init];
        NSLog(@"没有在storyboard中找到该viewcontroller \n %@",exception.description);
        
    }
    @finally {
        
    }
 
    
    return self;
    
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:5]} forState:UIControlStateNormal];
    
    [self configureViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.requestTask cancel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"%@被释放掉了",NSStringFromClass([self class]));
    
}

#pragma mark - Configure Views

- (void)configureViews {
    
    
}

@end

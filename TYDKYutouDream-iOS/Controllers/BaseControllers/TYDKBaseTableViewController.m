//
//  TYDKBaseTableViewController.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 10/15/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKBaseTableViewController.h"

@interface TYDKBaseTableViewController () <RETableViewManagerDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@end

@implementation TYDKBaseTableViewController

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
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    [self configureTableView];
    
    [self configureStyle];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Configure tableView

- (void)configureTableView {
    
    
}

- (void)configureStyle {

    
}

#pragma mark - tableview delegate
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
//    
//    for (UIView *view in cell.contentView.subviews) {
//        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]])
//            ((UILabel *)view).font = [UIFont fontWithName:@"Avenir-Medium" size:16];
//    }
//    
//    if ([cell isKindOfClass:[RETableViewCreditCardCell class]]) {
//        RETableViewCreditCardCell *ccCell = (RETableViewCreditCardCell *)cell;
//        ccCell.creditCardField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
//        ccCell.expirationDateField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
//        ccCell.cvvField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
//    }
//}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}



@end

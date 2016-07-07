//
//  TYDKMyOfferViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/24/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyOfferViewController.h"
#import "TYDKWishDetailViewController.h"

#import "TYDKMyOfferItem.h"
@interface TYDKMyOfferViewController ()
@property (assign, nonatomic) NSUInteger currentPage;
@property (assign, nonatomic) NSUInteger maxPage;

//存放所有显示数据的数组
@property (strong, nonatomic) NSMutableArray *rowsArray;
@end

@implementation TYDKMyOfferViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的参与";
    [self requestWishList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    self.manager[@"TYDKMyOfferItem"] = @"TYDKMyOffersTableViewCell";
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        
        [self.manager addSection:section];
        section;
        
    });
    
}

#pragma mark - request Wish List
- (void)requestWishList {
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionCenter];
    
    self.requestTask = [[TYDKDataManager manager] getAllMyOffersWithPage:1 Success:^(NSArray<TYDKWishModel *> *list) {
        [self addItems:list];
        [self.navigationItem stopAnimating];
    } failure:^(NSError *error) {
        [self.navigationItem stopAnimating];
        
    }];


}

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"你还没有参与过";
    font = [UIFont boldSystemFontOfSize:18.0];
    textColor = [UIColor colorWithRed:0.373 green:0.412 blue:0.471 alpha:1.000];
    
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    text = @"点啥子点\n肯定是空的三";
    font = [UIFont systemFontOfSize:14.0];
    textColor = [UIColor colorWithRed:0.373 green:0.412 blue:0.471 alpha:1.000];
    
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    
    return attributedString;
    
    
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    text = @"qio一哈";
    font = [UIFont boldSystemFontOfSize:14.0];
    textColor = [UIColor whiteColor];
    
    if (!text) {
        return nil;
    }
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *imageName = [NSString stringWithFormat:@"button_background_kickstarter"];
    
    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsMake(-19.0, -61.0, -19.0, -61.0);
    
    return [[[UIImage imageNamed:imageName] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
    
    
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    

    UITabBarController *tabBarController = (UITabBarController *)[AppDelegate window].rootViewController;
    [tabBarController setSelectedIndex:1];
    
}


#pragma mark - Private Methods
- (void)addItems:(NSArray *)rowsArray {
    
    
    if (!self.rowsArray) {
        
        self.rowsArray = [NSMutableArray arrayWithArray:rowsArray];
    }
    
    @weakify(self);
    
    [rowsArray enumerateObjectsUsingBlock:^(TYDKOfferModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKMyOfferItem *item = [[TYDKMyOfferItem alloc] initWithWishModel:obj];
        
        [item setSelectionHandler:^(TYDKMyOfferItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);
            
            TYDKWishDetailViewController *vc = [[TYDKWishDetailViewController alloc] init];
            vc.wish = [TYDKWishModel wishModelFromOfferModel:item.offer];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.basicControlsSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadEmptyDataSet];

}


@end

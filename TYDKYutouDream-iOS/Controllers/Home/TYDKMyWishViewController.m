//
//  TYDKMyWishViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/22/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKMyWishViewController.h"
#import "TYDKWishDetailViewController.h"
#import "TYDKCreateWishViewController.h"
#import "TYDKHomeWishListItem.h"

@interface TYDKMyWishViewController ()

@property (assign, nonatomic) NSUInteger currentPage;
@property (assign, nonatomic) NSUInteger maxPage;

//存放所有显示数据的数组
@property (strong, nonatomic) NSMutableArray *rowsArray;

@end

@implementation TYDKMyWishViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我发起的";
    [self requestWishList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    self.manager[@"TYDKHomeWishListItem"] = @"TYDKHomeTableViewCell";
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        
        [self.manager addSection:section];
        section;
        
    });

}


#pragma mark - request Wish List

- (void)requestWishList {
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionCenter];

    self.requestTask = [[TYDKDataManager manager] getAllMyWishesWithPage:1
                                                                 Success:^(NSArray<TYDKWishModel *> *list) {
        [self addItems:list];
        [self.navigationItem stopAnimating];
    } failure:^(NSError *error) {
        [self.navigationItem stopAnimating];

    }];
}

- (void)requestDoneWish:(TYDKWishModel *)wish {
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionCenter];

    self.requestTask = [[TYDKDataManager manager] doneWishWithWishID:wish.ID success:^(TYDKResultModel *result) {
        
        [self.navigationItem stopAnimating];
        [self requestWishList];
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
    
    text = @"给你说了";
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
    
    text = @"人如果没得感兴趣的事和咸鱼莫得啥子区别\n那还不赶紧发一个！";
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
    
    text = @"发一个";
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
  
  
    [TYDKToolUtilities showCreateWishViewController];

}


#pragma mark - Private Methods

- (void)addItems:(NSArray *)rowsArray {
    
    
    if (!self.rowsArray) {
        
        self.rowsArray = [NSMutableArray arrayWithArray:rowsArray];
    }
    @weakify(self);
    [self.basicControlsSection removeAllItems];

    [rowsArray enumerateObjectsUsingBlock:^(TYDKWishModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKHomeWishListItem *item = [[TYDKHomeWishListItem alloc] initWithWishModel:obj chooseHandler:^(TYDKHomeWishListItem *item) {
            @strongify(self);
            if (item.wish.status == TYDKWishStatusStart) {
                [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"确定Ta已经帮你完成了愿望了么？点击确定后愿望基金会立即转到他的帐户" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        @strongify(self);

                        [self requestDoneWish:item.wish];
                    }
                    
                }];
            
            }
            
        }];
        
        [item setSelectionHandler:^(TYDKHomeWishListItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);
            
            TYDKWishDetailViewController *vc = [[TYDKWishDetailViewController alloc] init];
            vc.wish = item.wish;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        
    }];
    
    [self.basicControlsSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadEmptyDataSet];
}
@end

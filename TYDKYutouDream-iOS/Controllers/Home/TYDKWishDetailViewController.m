//
//  TYDKWishDetailTableViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/17/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKWishDetailViewController.h"
#import "TYDKCreateOfferViewController.h"

#import "TYDKBottomToolView.h"

#import "TYDKHomeWishListItem.h"
#import "TYDKWishDetailOfferItem.h"

#import "UMSocial.h"

@interface TYDKWishDetailViewController () <UMSocialUIDelegate>
//存放所有显示数据的数组
@property (strong, nonatomic) NSMutableArray *rowsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) RETableViewSection *offersSection;
@property (strong, nonatomic) TYDKHomeWishListItem *wishItem;

@property (strong, nonatomic) YYLabel *toolView;
@end

@implementation TYDKWishDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    [self configureTableView];
    
    [self requestWishList];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Configure Views
- (void)configureTableView {
    
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] bk_initWithTitle:@"帮Ta找人" style:UIBarButtonItemStylePlain handler:^(id sender) {
            @strongify(self);
            
            [self socialShare];
        }];
        item;
    });
    
    self.manager[@"TYDKHomeWishListItem"] = @"TYDKWishDetalTableViewCell";
    self.manager[@"TYDKWishDetailOfferItem"] = @"TYDKWishDetailOffersTableViewCell";

    self.basicControlsSection = ({
        
        RETableViewSection *section = [RETableViewSection section];
        
        self.wishItem = ({
            
            TYDKHomeWishListItem *item = [[TYDKHomeWishListItem alloc] initWithWishModel:self.wish chooseHandler:^(TYDKHomeWishListItem *item) {
                @strongify(self);

            }];
            [section addItem:item];
            item;
        });
        [self.manager addSection:section];
        section;
        
    });

    self.offersSection = ({
    
        RETableViewSection *section = [RETableViewSection section];
        [self.manager addSection:section];

        
        section;
    
    
    });
    
    
    self.toolView = ({
        YYLabel *label = [TYDKToolUtilities showBottomMessage:@"报名" inView:self.view];
        label.displaysAsynchronously = YES;

        label;
    });

}

#pragma mark - request detail

- (void)requestWishList {
    
    @weakify(self);
    
    self.requestTask = [[TYDKDataManager manager] getWishDetailWithWishID:self.wish.ID userID:nil Success:^(TYDKWishModel *wish, NSArray<TYDKOfferModel *> *offers) {
        self.wish = wish;
        [self.wishItem setWish:wish];
        [self.wishItem reloadRowWithAnimation:UITableViewRowAnimationNone];
        [self addOffers:offers];
        [self.tableView.mj_header endRefreshing];
        [self setBottomView:wish];

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];

    
    
    
   
}

- (void)cancelWish {
    
    self.requestTask = [[TYDKDataManager manager] cancelWishWithWishID:self.wish.ID success:^(TYDKResultModel *result) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)confirmOffer:(TYDKOfferModel *)offer {
    
    self.requestTask = [[TYDKDataManager manager] confirmOfferWithOfferID:offer.ID success:^(TYDKResultModel *result) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Private Methods

- (void)addOffers:(NSArray *)rowsArray {
    
    
    if (!self.rowsArray) {
        
        self.rowsArray = [NSMutableArray arrayWithArray:rowsArray];
    }
    @weakify(self);
    
    [rowsArray enumerateObjectsUsingBlock:^(TYDKOfferModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKWishDetailOfferItem *item = [[TYDKWishDetailOfferItem alloc] initWithWishModel:self.wish offer:obj chooseHandler:^(TYDKWishDetailOfferItem *item) {
            @strongify(self);
            
            [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                           message:@"确定选择Ta么？\n(づ￣ 3￣)づ"
                                 cancelButtonTitle:@"算啦！"
                                 otherButtonTitles:@[@"对哒！"]
                                           handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                @strongify(self);
                NSLog(@"第%@个",@(buttonIndex));
                if (buttonIndex == 1) {
                    //取消方法
                    [self confirmOffer:item.offer];
                }
            }];
        }];
        
        [item setSelectionHandler:^(TYDKHomeWishListItem *item) {
            [item deselectRowAnimated:YES];
            @strongify(self);

        }];
        [self.offersSection addItem:item];
        
    }];
    
    if (self.rowsArray.count == 0) {
        self.offersSection.footerView = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
            label.textColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.text = [NSString stringWithFormat:@"\n感兴趣就报名三\n紧到纠结啥子喃\n处女座嗦？"];
            [label sizeToFit];
            label;
        });
        [self.offersSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
    
    [self.offersSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)setBottomView:(TYDKWishModel *)wish {
    
    if (!wish.canOffer) {
        return;
    }
 
    @weakify(self);

    [self.toolView showInViewController:self wish:wish offerBlock:^{
     
        [TYDKToolUtilities showCreateOfferViewController];
    } cancelBlock:^{
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                       message:@"确定要取消订单嗦？\n_(:з」∠)_"
                             cancelButtonTitle:@"否"
                             otherButtonTitles:@[@"是"]
                                       handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            @strongify(self);
            NSLog(@"第%@个",@(buttonIndex));
            if (buttonIndex == 1) {
                //取消方法
                [self cancelWish];
            }
        }];
        
    }];
    
    
}

- (void)socialShare {

    
    NSString *shareUrl = [NSString stringWithFormat:@"http://daidai.91douya.com/index.php/Home/wish/index?id=%@",self.wish.ID];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;

    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";

    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:shareUrl
                                     shareImage:[UIImage imageNamed:@"about_logo"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
    
}
@end

//
//  TYDKPicturePreviewViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/11/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKPicturePreviewViewController.h"
#import "TYDKPicturePreviewShareToolView.h"
#import "TYDKWebViewController.h"
#import "TYDKCardListTwoItem.h"

#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface TYDKPicturePreviewViewController () <MWPhotoBrowserDelegate>
@property (strong, nonatomic) NSDictionary *dataSource;
@property (strong, nonatomic) NSMutableArray *stories;
@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, weak) UIImageView *tappedImageView;

@end

@implementation TYDKPicturePreviewViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    [TYDKToolUtilities showMessage:@"点击图片浏览大图" inView:self.view];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    self.manager[@"TYDKCardListTwoItem"] = @"TYDKCardListTwoTableViewCell";
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"zhihuDailyData"
                                                      ofType:@"json"];
    NSData *data    = [NSData dataWithContentsOfFile:path];
    self.dataSource = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil];
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        [self.manager addSection:section];
        section;
        
    });
    
    [self addItems:[self.dataSource km_safeArrayForKey:@"stories"]];
    
}

- (void)addItems:(NSArray * __nonnull)rowsArray {
    
    
    if (!self.stories) {
        self.stories = [NSMutableArray arrayWithArray:rowsArray];
    }
    if (!self.photos) {
        self.photos = [NSMutableArray new];
    }
    /**
     *  将新得到的数据加入总数据中
     */
    [self.stories arrayByAddingObjectsFromArray:rowsArray];
    @weakify(self);
    
    [rowsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TYDKCardListTwoItem *item = [[TYDKCardListTwoItem alloc] initWithDictionary:obj];
        
        @strongify(self);
        [item setSelectionHandler:^(TYDKCardListTwoItem *item) {
            [item deselectRowAnimated:YES];
            TYDKWebViewController *vc = [[TYDKWebViewController alloc] init];
            vc.url = [NSURL URLWithString:item.mainURL];
            vc.title = item.mainTitle;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self.basicControlsSection addItem:item];
        
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:item.mainImages]];
        photo.caption = item.mainTitle;
        [self.photos addObject:photo];
        
        
        
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark - gesture handler 
- (IBAction)handleTapGestureRecognizer:(UITapGestureRecognizer *)recognizer {
   
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    CGPoint point = [recognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    [browser setCurrentPhotoIndex:indexPath.row];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (([touch view].tag == 999) && [touch.view isKindOfClass:[UIImageView class]]) {
        self.tappedImageView = (UIImageView *)touch.view;
        return YES;
    }
    return NO;
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
    MWPhoto *photo = [self.photos objectAtIndex:index];
    TYDKPicturePreviewShareToolView *captionView = [[TYDKPicturePreviewShareToolView alloc] initWithPhoto:photo];
    return captionView;
}



@end

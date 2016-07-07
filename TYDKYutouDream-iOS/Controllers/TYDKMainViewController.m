//
//  TYDKMainViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/25/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKMainViewController.h"
#import "TYDKListViewController.h"
#import "TYDKPictureAndListViewController.h"

#import "TYDKMainCollectionViewCell.h"
#import "SDCycleScrollView.h"

static CGFloat const kHomeBannerHeight = 180;
static NSUInteger const kHomeGridViewPerRowItemCount = 4;
static NSString * const kHeaderViewIdentifier = @"headerview";
static NSString * const kMainCollectionViewCellIdentifier = @"TYDKMainCollectionViewCell";

@interface TYDKMainViewController () <UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) SDCycleScrollView *headerImage;

@end

@implementation TYDKMainViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"首页";
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure Views

- (void)configureViews {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing  = 1;//设置每一行的间距
    layout.minimumInteritemSpacing = 0;
    CGFloat itemSizeWidth = (CGRectGetWidth(self.view.bounds)-(kHomeGridViewPerRowItemCount +1)*10)/kHomeGridViewPerRowItemCount;
    layout.itemSize            = CGSizeMake(itemSizeWidth, 100);//设置每个单元格的大小
    layout.sectionInset        = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), kHomeBannerHeight);//设置collectionView头视图的大小
    self.collectionView.collectionViewLayout = layout;
    //注册cell单元格
    [self.collectionView registerNib:[UINib nibWithNibName:@"TYDKMainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kMainCollectionViewCellIdentifier];
    //注册头视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate   = self;
    self.collectionView.dataSource = self;

}


#pragma mark  返回多少行

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 13;
    
}



- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TYDKMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCollectionViewCellIdentifier forIndexPath:indexPath];
    
    
    NSString *imageName = [NSString stringWithFormat:@"anon_group%@",@(indexPath.row%4)];
    
    cell.iconImageView.image = [UIImage imageNamed:imageName];
    
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"列表类";
            break;
            
        case 1:
            cell.titleLabel.text = @"图片类";
            break;

        case 2:
            cell.titleLabel.text = @"筛选类";
            break;

        default:
        {
            NSString *imageName = [NSString stringWithFormat:@"anon_group4"];
            cell.iconImageView.image = [UIImage imageNamed:imageName];
        }
            break;
    }

    return cell;
    
}


//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderViewIdentifier forIndexPath:indexPath];
        //头视图添加view
        [header addSubview:self.headerImage];
        return header;
    }
 
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            TYDKListViewController *vc = [[TYDKListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:
        {
            TYDKPictureAndListViewController *vc = [[TYDKPictureAndListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        default:
            break;
    }
    
}

#pragma mark - getters 

- (SDCycleScrollView *)headerImage {
    
    if (!_headerImage) {
        
        _headerImage = ({
            SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kHomeBannerHeight) imageURLStringsGroup:@[@"http://www.5059.com/upload/image/20151221/20151221192306_73777.jpg",@"http://img4.duitang.com/uploads/blog/201403/26/20140326140151_PXfPn.jpeg"]];
            
            cycleView.autoScrollTimeInterval = 5.0;
            cycleView.delegate = self;
            cycleView;
            
        });
    }
    
    return _headerImage;
}

#pragma mark - SDCycleScrollView delegate 

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"点击了%@",@(index));
    
}


@end

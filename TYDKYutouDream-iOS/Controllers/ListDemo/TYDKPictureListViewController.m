//
//  TYDYPictureListViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 云冯 on 15/12/31.
//  Copyright © 2015年 tydic-lhr. All rights reserved.
//
#import "TYDKPictureListViewController.h"
#import "TYDKGoodsCollectionViewCell.h"

static NSString * const kPictureCellIdentifier = @"TYDKGoodsCollectionViewCell";
static NSUInteger const kHomeGridViewPerRowItemCount = 2;
static NSUInteger const kHomeGridViewEdge = 8;

@interface TYDKPictureListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView * _collectionView;
}
@end

@implementation TYDKPictureListViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片列表";
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
    
    CGFloat itemSizeWidth = (CGRectGetWidth(self.view.bounds)-(kHomeGridViewPerRowItemCount + 1) * kHomeGridViewEdge)/kHomeGridViewPerRowItemCount;
    layout.itemSize = CGSizeMake(itemSizeWidth, itemSizeWidth + 34 + 17 + kHomeGridViewEdge);//设置每个单元格的大小
    layout.sectionInset  = UIEdgeInsetsMake(8, 8, 8, 8);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];

    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"TYDKGoodsCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:kPictureCellIdentifier];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.929 alpha:1.000];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 13;
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TYDKGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPictureCellIdentifier forIndexPath:indexPath];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

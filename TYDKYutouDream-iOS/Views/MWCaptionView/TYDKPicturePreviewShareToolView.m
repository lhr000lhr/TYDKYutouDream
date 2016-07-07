//
//  TYDKPicturePreviewShareToolView.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/11/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKPicturePreviewShareToolView.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "MWPhoto.h"

static NSString *const kAlbumName = @"共性课题场景demo";

@interface TYDKPicturePreviewShareToolView () {

}

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (strong, nonatomic) MWPhoto *photo;

@end

@implementation TYDKPicturePreviewShareToolView

- (id)initWithPhoto:(MWPhoto *)photo {

    self = [super initWithPhoto:photo];
    if (self) {
        self.userInteractionEnabled = YES;
        self.favorited = NO;
        _photo = photo;
    }
    return self;
}
- (void)setupCaption {

    NSMutableArray *btnArray = [[NSMutableArray alloc] init];

  
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:
                                      [UIImage imageNamed:@"icn_tweet_action_inline_favorite_off"]];
    [button setTitle:@"赞" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

    imageView.frame       = CGRectMake(-16, 0, 32, 32);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.centerY     = button.height / 2;
    _favoriteImageView    = imageView;
    [button addSubview:imageView];
    
    
    @weakify(self);

    [button bk_addEventHandler:^(UIButton *sender) {
        LxDBAnyVar(sender);
        @strongify(self);
        self.favorited = !self.favorited;
        [self updateFavouriteWithAnimation];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [btnArray addObject:item];
    
    //加入空白item，控制间距
    UIBarButtonItem *itemButtonEmpty = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                     target:nil
                                                                                     action:nil];

    [btnArray addObject:itemButtonEmpty];

    UIBarButtonItem *saveImageButton = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存图片"
                                                                           style:UIBarButtonItemStylePlain
                                                                         handler:^(UIBarButtonItem *sender)
    {
        @strongify(self);
        UIImage *image = [self.photo underlyingImage];
        [self saveImage:image];
    }];
    saveImageButton.tintColor = [UIColor whiteColor];
    [btnArray addObject:saveImageButton];

    [self setItems:btnArray];
}

- (CGSize)sizeThatFits:(CGSize)size {

    return CGSizeMake(size.width, 44);
}



- (void)updateFavouriteWithAnimation {
    
    
    if (self.isFavorited) {

        _favoriteImageView.image = [self spriteSheetImage];

    } else {
        _favoriteImageView.image = [UIImage imageNamed:@"icn_tweet_action_inline_favorite_off"];
        
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
            _favoriteImageView.layer.transformScale = 1.5;
                             
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
                _favoriteImageView.layer.transformScale = 1;
                                 
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    
    
}

#pragma mark - Custom Getter

- (ALAssetsLibrary *)assetsLibrary
{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (YYSpriteSheetImage *)spriteSheetImage {
    
    UIImage *img = [UIImage imageNamed:@"fav02l-sheet"];
    NSMutableArray *contentRects = [NSMutableArray new];
    NSMutableArray *durations    = [NSMutableArray new];
    
    //加入动图
    for (int j = 0; j < 12; j++) {
        for (int i = 0; i < 8; i++) {
            CGRect rect;
            rect.size     = CGSizeMake(img.size.width / 8, img.size.height / 12);
            rect.origin.x = img.size.width / 8 * i;
            rect.origin.y = img.size.height / 12 * j;
            [contentRects addObject:[NSValue valueWithCGRect:rect]];
            [durations addObject:@(1 / 60.0)];
        }
    }
    
    return [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:img
                                                   contentRects:contentRects
                                                 frameDurations:durations
                                                      loopCount:1];
}

#pragma mark - private method

- (void)saveImage:(UIImage *)image {
    // Manage tasks in background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *finalImageToSave = image;
        
        // The completion block to be executed after image taking action process done
        void (^completion)(NSURL *, NSError *) = ^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"%s: Write the image data to the assets library (camera roll): %@",
                      __PRETTY_FUNCTION__, [error localizedDescription]);
                UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:[error localizedDescription]];
                [alertView show];
            }
            
            NSLog(@"%s: Save image with asset url %@ (absolute path: %@), type: %@", __PRETTY_FUNCTION__,
                  assetURL, [assetURL absoluteString], [assetURL class]);

            dispatch_async(dispatch_get_main_queue(), ^{
               [UIAlertView bk_showAlertViewWithTitle:@"保存成功"
                                              message:nil
                                    cancelButtonTitle:@"好"
                                    otherButtonTitles:nil
                                              handler:nil];
                
            });
        };
        
        void (^failure)(NSError *) = ^(NSError *error) {
            if (error) NSLog(@"%s: Failed to add the asset to the custom photo album: %@",
                             __PRETTY_FUNCTION__, [error localizedDescription]);
        };
        
     
        // Save image to custom photo album
        // The lifetimes of objects you get back from a library instance are tied to
        //   the lifetime of the library instance.
        [self.assetsLibrary saveImage:finalImageToSave
                              toAlbum:kAlbumName
                           completion:completion
                              failure:failure];
    });

    
}

@end

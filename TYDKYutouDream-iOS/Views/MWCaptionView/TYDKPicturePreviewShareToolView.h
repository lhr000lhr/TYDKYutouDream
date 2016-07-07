//
//  TYDKPicturePreviewShareToolView.h
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 1/11/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "MWCaptionView.h"

@interface TYDKPicturePreviewShareToolView : MWCaptionView

@property (assign, nonatomic, getter=isFavorited) BOOL favorited;
@property (nonatomic, strong) YYAnimatedImageView *favoriteImageView;

@end

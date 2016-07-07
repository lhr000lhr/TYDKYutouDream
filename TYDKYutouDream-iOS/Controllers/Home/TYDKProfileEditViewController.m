//
//  TYDKProfileEditViewController.m
//  TYDKYutouDream-iOS
//
//  Created by 李浩然 on 2/22/16.
//  Copyright © 2016 tydic-lhr. All rights reserved.
//

#import "TYDKProfileEditViewController.h"

#import "CorePhotoPickerVCManager.h"
#import "TYDKUserProfileEditingAvatarView.h"
@interface TYDKProfileEditViewController ()

@property (strong, nonatomic) NSDictionary *ageSelections;
@property (strong, nonatomic) NSDictionary *sexSelections;

@property (strong, nonatomic) RETextItem   *nicknameItem;
@property (strong, nonatomic) REPickerItem *sexItem;
@property (strong, nonatomic) RETextItem   *phoneNumberItem;
@property (strong, nonatomic) REPickerItem *generationItem;

@property (strong, nonatomic) TYDKUserProfileEditingAvatarView *headerAvatarView;
@property (strong, nonatomic) UIImage *selectedAvatar;

@property (strong, nonatomic) NSURLSessionDataTask *requestUploadTokenTask;

@end

@implementation TYDKProfileEditViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    self.ageSelections = @{
                           @"00后" : @"00",
                           @"90后" : @"90",
                           @"80后" : @"80",
                           @"70后" : @"70",
                           @"60后" : @"60",
                           @"50后" : @"50"
                           };
    self.sexSelections = @{
                           @"男" : @(TYDKSexTypeMale),
                           @"女" : @(TYDKSexTypeFemale),
                           };

    [super viewDidLoad];
    self.title = @"编辑资料";
    // Do any additional setup after loading the view.
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.requestUploadTokenTask cancel];
    [self.requestTask cancel];
    
}

#pragma mark - Configure Views

- (void)configureTableView {
    [super configureTableView];
    
    @weakify(self);

    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] bk_initWithTitle:@"确定" style:UIBarButtonItemStylePlain handler:^(id sender) {
            @strongify(self);
            [self updateUserProfile];
        }];
        item;
    });
    
    
    self.basicControlsSection = ({
        RETableViewSection *section = [RETableViewSection section];
        section.headerView = ({
        
            TYDKUserProfileEditingAvatarView *headerView = [TYDKUserProfileEditingAvatarView headerViewWithEditingHandler:^{
                @strongify(self);
 
                [self chooseAvatar];
                
                
            }];
            self.headerAvatarView = headerView;
            headerView;
        
        });
        section.headerHeight = 90;
        self.nicknameItem = ({
            RETextItem *item = [RETextItem itemWithTitle:@"昵称" value:kUser.name placeholder:@"请输入昵称"];
            [section addItem:item];
            item;
        });
        
        [self.manager addSection:section];

        section;
    });
    
    RETableViewSection *sexSection = [RETableViewSection section];
    [self.manager addSection:sexSection];
    self.sexItem = ({
        REPickerItem *item = [REPickerItem itemWithTitle:@"性别"
                                                   value:@[kUser.member.sex ? @"男":@"女"]
                                             placeholder:@""
                                                 options:@[self.sexSelections.allKeysSorted]];
        [sexSection addItem:item];
        item;
        
    });
    
    RETableViewSection *phoneNumberItem = [RETableViewSection section];
    [self.manager addSection:phoneNumberItem];
    self.phoneNumberItem = ({
        RETextItem *item = [RETextItem itemWithTitle:@"手机号码"
                                               value:kUser.member.mobile_no
                                         placeholder:@"请输入手机号"];
        item.keyboardType = UIKeyboardTypePhonePad;
        [phoneNumberItem addItem:item];
        item;
    });
    
    RETableViewSection *generationSection = [RETableViewSection section];
    [self.manager addSection:generationSection];
    self.generationItem = ({
        REPickerItem *item = [REPickerItem itemWithTitle:@"出生年代"
                                                   value:@[[NSString stringWithFormat:@"%@后",kUser.member.age]]
                                             placeholder:@""
                                                 options:@[self.ageSelections.allKeysSorted]];
        [generationSection addItem:item];
        item;
    
    });
}

- (void)configureStyle {
    [super configureStyle];
    self.manager.style = [self.manager.style TYDKCellStyleDefault];

}

#pragma mark - request

- (void)updateUserProfile {
    
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionRight];
    self.requestTask = [[TYDKDataManager manager] updateUserProfileWithID:kUser.member.ID
                                                                nick_name:self.nicknameItem.value
                                                                      sex:[[self.sexSelections km_safeNumberForKey:self.sexItem.value.firstObject] unsignedIntegerValue]
                                                                      age:[self.ageSelections km_safeStringForKey:self.generationItem.value.firstObject]
                                                                mobile_no:self.phoneNumberItem.value
                                                                  headimg:[self.headerAvatarView.avatarUrl absoluteString]
                                                                  country:@""
                                                                 province:@""
                                                                     city:@""
                                                                  success:^(TYDKMemberModel *member) {
        
        
        TYDKUserModel *user = [[TYDKUserModel alloc] initWithMember:member];
        [self finishLoginConfiguration:user];
        [self.navigationItem stopAnimating];

    } failure:^(NSError *error) {

        
        [self.navigationItem stopAnimating];

    }];
    
}

- (void)requestUploadToken {
    
    @weakify(self);
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionRight];

    self.requestUploadTokenTask = [[TYDKDataManager manager] getUploadToken:^(NSString *uptoken) {
        QNUploadManager *upManager = [TYDKDataManager manager].upManager;
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [self randomStringWithLength:8]];
        [upManager putData:UIImageJPEGRepresentation(self.selectedAvatar, 1.0)
                       key:fileName
                     token:uptoken
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      @strongify(self);

                      [self.headerAvatarView setAvatarUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrlHttp,key]]];
                      NSLog(@" --->> Info: %@  ", info);
                      NSLog(@" ---------------------");
                      NSLog(@" --->> Response: %@,  ", resp);
                      [self.navigationItem stopAnimating];

                  }
                    option:nil];
        
    } failure:^(NSError *error) {
        [self.navigationItem stopAnimating];

    }];
    
    
    
}

#pragma mark - Private Methods

- (void)finishLoginConfiguration:(TYDKUserModel *)user {
    
    [TYDKDataManager manager].user = user;
    [user saveUser];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:user];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseAvatar {
    
    UIActionSheet *sheet;
    @weakify(self);

    void(^cameraHandler)(void) = ^(void) {
        CorePhotoPickerVCManager *manager = [CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
        @strongify(self);

        //设置类型
        manager.pickerVCManagerType = CorePhotoPickerVCMangerTypeCamera;
        manager.finishPickingMedia = ^(NSArray *medias){
            CorePhoto *photo = [medias firstObject];
            @strongify(self);
            
            self.selectedAvatar = photo.editedImage;
            
            [self requestUploadToken];
        };
        [self presentViewController:manager.imagePickerController animated:YES completion:nil];

    };
    
    void(^albumHandler)(void) = ^(void) {
        CorePhotoPickerVCManager *manager = [CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
        //设置类型
        @strongify(self);

        manager.pickerVCManagerType = CorePhotoPickerVCMangerTypeSinglePhoto;
        manager.finishPickingMedia = ^(NSArray *medias){
            CorePhoto *photo = [medias firstObject];
            @strongify(self);
            
            self.selectedAvatar = photo.editedImage;
            
            [self requestUploadToken];
            
        };
        [self presentViewController:manager.imagePickerController animated:YES completion:nil];
        
    };
    
    //    [self.textField resignFirstResponder];
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        [sheet bk_addButtonWithTitle:@"相机" handler:cameraHandler];
        [sheet bk_addButtonWithTitle:@"从相册选择" handler:albumHandler];
     
   
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:nil cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:nil];
        [sheet bk_addButtonWithTitle:@"从相册选择" handler:albumHandler];

    }
    
    [sheet showInView:self.view];

    
    
}

#pragma mark - Helpers

- (NSString *)getDateTimeString {
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}


- (NSString *)randomStringWithLength:(int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];

    if ([cell isKindOfClass:[RETableViewTextCell class]]) {
        RETableViewTextCell *ccCell = (RETableViewTextCell *)cell;
//        ccCell.textField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        ccCell.textField.textAlignment = NSTextAlignmentRight;
    }
}

@end

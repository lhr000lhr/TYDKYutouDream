//
//  TYDKDataManager.h
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/21/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "QiniuSDK.h"


#import "TYDKMemberModel.h"
#import "TYDKUserModel.h"
#import "TYDKResultModel.h"
#import "TYDKWishModel.h"
#import "TYDKOfferModel.h"
#import "TYDKCityModel.h"
#import "TYDKPaymentModel.h"
#import "TYDKWalletDetailModel.h"

typedef NS_ENUM(NSInteger, TYDKErrorType) {
    
    TYDKErrorTypeNoOnceAndNext          = 700,
    TYDKErrorTypeLoginFailure           = 701,
    TYDKErrorTypeRequestFailure         = 702,
    TYDKErrorTypeGetFeedURLFailure      = 703,
    TYDKErrorTypeGetTopicListFailure    = 704,
    TYDKErrorTypeGetNotificationFailure = 705,
    TYDKErrorTypeGetFavUrlFailure       = 706,
    TYDKErrorTypeGetMemberReplyFailure  = 707,
    TYDKErrorTypeGetTopicTokenFailure   = 708,
    TYDKErrorTypeGetCheckInURLFailure   = 709,
    
};

typedef NS_ENUM(NSUInteger, TYDKRequestDateType) {
    TYDKRequestDateTypeDay,
    TYDKRequestDateTypeMonth,
};


typedef NS_ENUM(NSUInteger, TYDKReportsDetailType) {
    TYDKReportsDetailTypeCommission,
    TYDKReportsDetailTypeDevelopment,
    TYDKReportsDetailTypeCredit,
    
};

typedef NS_ENUM(NSUInteger, TYDKRequestLevelType) {
    TYDKRequestLevelTypeCommissionSummary  = 1,
    TYDKRequestLevelTypeClassifyedSummary  = 2,
    TYDKRequestLevelTypeCommissionDetail   = 3,
    TYDKRequestLevelTypeCommissionExDetail = 4,
    
};

typedef NS_ENUM(NSUInteger, TYDKDiscoverType) {
    TYDKDiscoverTypeWishProcessing = 0,
    TYDKDiscoverTypeWishDone = 6,

};
static NSString *const kBaseLocalUrlHttp = @"http://daidai.91douya.com";

static NSString *const kBaseUrlHttp = @"http://daidai.91douya.com";

static NSString *const kBaseImageUrlHttp = @"http://img.91douya.com/";

@interface TYDKDataManager : NSObject

+ (instancetype)manager;

@property (nonatomic, strong) TYDKUserModel *user;
@property (nonatomic, strong) QNUploadManager *upManager;

@property (nonatomic, assign) BOOL preferLocalServer;
@property (nonatomic, assign) BOOL authenticator;







#pragma mark - GET

- (NSURLSessionDataTask *)getAllCitiesSuccess:(void (^)(NSArray <TYDKCityModel *> *list))success
                                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getAllWishesSuccess:(void (^)(NSArray <TYDKWishModel *> *list))success
                                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getAllMyWishesWithPage:(NSUInteger)page
                                         Success:(void (^)(NSArray <TYDKWishModel *> *list))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getAllMyOffersWithPage:(NSUInteger)page
                                         Success:(void (^)(NSArray <TYDKOfferModel *> *list))success
                                         failure:(void (^)(NSError *error))failure;
//用的是post
- (NSURLSessionDataTask *)getWishDetailWithWishID:(NSString *)wishID
                                           userID:(NSString *)userID
                                          Success:(void (^)(TYDKWishModel *wish, NSArray <TYDKOfferModel *> *offers))success
                                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getUploadToken:(void (^)(NSString *uptoken))success
                                 failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getBalance:(void (^)(CGFloat balance))success
                             failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getWalletDetail:(void (^)(NSArray <TYDKWalletDetailModel *> *list))success
                                  failure:(void (^)(NSError *error))failure;

//发现
- (NSURLSessionDataTask *)discoverWishesWithCityCode:(NSInteger)cityCode
                                            keywords:(NSString *)keywords
                                                type:(TYDKDiscoverType)type
                                                page:(NSUInteger)page
                                             success:(void (^)(NSArray <TYDKWishModel *> *list))success
                                             failure:(void (^)(NSError *error))failure;

#pragma mark - Create

- (NSURLSessionDataTask *)createWishWithWishDescription:(NSString *)wishDescription
                                              wishPrice:(NSString *)wishPrice
                                               cityCode:(NSInteger)cityCode
                                                success:(void (^)(TYDKPaymentModel *payment))success
                                                failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *)createOfferWithWishID:(NSString *)wishID
                                         success:(void (^)(NSDictionary *chargeInfo))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)createChargeWithWishID:(NSString *)wishID
                                offerDescription:(NSString *)offerDescription
                                         success:(void (^)(TYDKResultModel *result))success
                                         failure:(void (^)(NSError *error))failure;

#pragma mark - Cancel

- (NSURLSessionDataTask *)cancelWishWithWishID:(NSString *)wishID
                                       success:(void (^)(TYDKResultModel *result))success
                                       failure:(void (^)(NSError *error))failure;

#pragma mark - Choose

- (NSURLSessionDataTask *)confirmOfferWithOfferID:(NSString *)offerID
                                          success:(void (^)(TYDKResultModel *result))success
                                          failure:(void (^)(NSError *error))failure;

#pragma mark - Done

- (NSURLSessionDataTask *)doneWishWithWishID:(NSString *)wishID
                                          success:(void (^)(TYDKResultModel *result))success
                                          failure:(void (^)(NSError *error))failure;

#pragma mark - Login & Profile


- (NSURLSessionDataTask *)sendSMSWithPhoneNumber:(NSString *)phoneNumber
                                         success:(void (^)(TYDKResultModel *result))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)loginWithPhoneNumber:(NSString *)phoneNumber
                                          code:(NSString *)code
                                       success:(void (^)(TYDKMemberModel *member))success
                                       failure:(void (^)(NSError *error))failure;

- (void)userLogout;

- (NSURLSessionDataTask *)registerByPhoneNumber:(NSString *)phoneNumber
                                           code:(NSString *)code
                                       nickname:(NSString *)nickname
                                       password:(NSString *)password
                                      headimage:(UIImage *)headimage
                                        success:(void (^)(TYDKResultModel *result))success
                                        failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *)updateUserProfileWithID:(NSString *)ID
                                        nick_name:(NSString *)nick_name
                                              sex:(TYDKSexType)sex
                                              age:(NSString *)age
                                        mobile_no:(NSString *)mobile_no
                                          headimg:(NSString *)headimg
                                          country:(NSString *)country
                                         province:(NSString *)province
                                             city:(NSString *)city
                                          success:(void (^)(TYDKMemberModel *member))success
                                          failure:(void (^)(NSError *error))failure;




//#pragma mark - Public Request Methods - Login & Profile & info
//
//
//
//- (NSURLSessionDataTask *)changePassword:(NSString *)password
//                             newPassword:(NSString *)newPassword
//                                 success:(void (^)(TYDKResultModel *resultModel))success
//                                 failure:(void (^)(NSError *error))failure;
//
//- (NSURLSessionDataTask *)getAnnouncementWithPage:(NSUInteger)page
//                                          Success:(void (^)(TYDKResultModel *resultModel))success
//                                          failure:(void (^)(NSError *error))failure;
@end

//
//  TYDKDataManager.m
//  TYDKCommissionHelper-iOS
//
//  Created by 李浩然 on 9/21/15.
//  Copyright (c) 2015 tydic-lhr. All rights reserved.
//

#import "TYDKDataManager.h"

#import "AFNetworking.h"


static NSString *const kOnceString =  @"once";
static NSString *const kNextString =  @"next";

static NSString *const kUsername = @"username";
static NSString *const kUserpassword = @"userpassword";
static NSString *const kUserid = @"userid";
static NSString *const kAvatarURL = @"avatarURL";
//static NSString *const kUserIsLogin = @"userIsLogin";
static NSString *const kUserIsLogin = @"userIsLoginWithAchive";

typedef NS_ENUM(NSInteger, TYDKRequestMethod) {
    TYDKRequestMethodJSONGET    = 1,
    TYDKRequestMethodHTTPPOST   = 2,
    TYDKRequestMethodHTTPGET    = 3,
    TYDKRequestMethodHTTPGETPC  = 4,
    TYDKRequestMethodJSONPOST   = 5
    
};


@interface TYDKDataManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, copy) NSString *userAgentMobile;
@property (nonatomic, copy) NSString *userAgentPC;

@end

@implementation TYDKDataManager


- (instancetype)init {
    if (self = [super init]) {
        
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        self.userAgentMobile = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        self.userAgentPC = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14";
        
        self.preferLocalServer = kSetting.preferLocalServer;
        
        BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:kUserIsLogin] boolValue];
        if (isLogin) {
            TYDKUserModel *user = [TYDKUserModel getSavedUser];
            user.login = YES;
         
//            user.member.STAFF_CODE = [[NSUserDefaults standardUserDefaults] objectForKey:kUsername];
//            user.member.STAFF_ID   = [[NSUserDefaults standardUserDefaults] objectForKey:kUserid];
            user.password = [[NSUserDefaults standardUserDefaults] objectForKey:kUserpassword];
            //            user.member.memberAvatarLarge = [[NSUserDefaults standardUserDefaults] objectForKey:kAvatarURL];
            _user = user;
        }
        
    }
    return self;
}


- (void)setPreferLocalServer:(BOOL)preferLocalServer {
    _preferLocalServer = preferLocalServer;
    
    NSURL *baseUrl;
    
    if (_preferLocalServer) {
        baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",kBaseLocalUrlHttp]];
        
        
    } else {
        baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",kBaseUrlHttp]];
    }
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    self.manager.requestSerializer = serializer;
    
}


- (void)setUser:(TYDKUserModel *)user {
    _user = user;
    
    if (user) {
        self.user.login = YES;
        
//        [[NSUserDefaults standardUserDefaults] setObject:user.member.STAFF_CODE forKey:kUsername];
        [[NSUserDefaults standardUserDefaults] setObject:user.password forKey:kUserpassword];
//        [[NSUserDefaults standardUserDefaults] setObject:user.member.STAFF_ID forKey:kUserid];
        //        [[NSUserDefaults standardUserDefaults] setObject:user.member.memberAvatarLarge forKey:kAvatarURL];
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kUserIsLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsername];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserpassword];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserid];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAvatarURL];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserIsLogin];
        [TYDKUserModel deleteUser];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:user];

    }
    
}

- (void)userLogout {
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    self.user = nil;
//    [[TYDKDataManager manager] removeStatus];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:nil];
    
}

+ (instancetype)manager {
    static TYDKDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TYDKDataManager alloc] init];
    });
    return manager;
}

- (QNUploadManager *)upManager {
    
    if (!_upManager) {
        _upManager = [[QNUploadManager alloc] init];
    }
    return _upManager;
}

- (NSURLSessionDataTask *)requestWithMethod:(TYDKRequestMethod)method
                                  URLString:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSError *error))failure  {
    // stateBar
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Handle Common Mission, Cache, Data Reading & etc.
    void (^responseHandleBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Any common handler for Response
        
        //        NSLog(@"URL:\n%@", [task.currentRequest URL].absoluteString);
        
        
        success(task, responseObject);
        
    };
    
    // Create HTTPSession
    NSURLSessionDataTask *task = nil;
    
    [self.manager.requestSerializer setValue:self.userAgentMobile forHTTPHeaderField:@"User-Agent"];
    
    if (method == TYDKRequestMethodJSONGET) {
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *contentTypes = [NSMutableSet setWithSet:responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        responseSerializer.acceptableContentTypes = contentTypes;
        self.manager.responseSerializer = responseSerializer;
        task = [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: \n%@", [error description]);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    if (method == TYDKRequestMethodJSONPOST) {
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *contentTypes = [NSMutableSet setWithSet:responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        responseSerializer.acceptableContentTypes = contentTypes;
        self.manager.responseSerializer = responseSerializer;

        task = [self.manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: \n%@", [error description]);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    if (method == TYDKRequestMethodHTTPGET) {
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        task = [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    if (method == TYDKRequestMethodHTTPPOST) {
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        task = [self.manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    if (method == TYDKRequestMethodHTTPGETPC) {
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        [self.manager.requestSerializer setValue:self.userAgentPC forHTTPHeaderField:@"User-Agent"];
        task = [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    
    return task;
}

#pragma mark - Public Request Methods - GET
- (NSURLSessionDataTask *)getAllCitiesSuccess:(void (^)(NSArray <TYDKCityModel *> *list))success
                                      failure:(void (^)(NSError *error))failure {
    
    return [self requestWithMethod:TYDKRequestMethodJSONGET URLString:@"/index.php/index/initcity" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        NSArray *wishArray = [TYDKCityModel mj_objectArrayWithKeyValuesArray:[responseObject km_safeArrayForKey:@"msg"]];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(wishArray);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
}

- (NSURLSessionDataTask *)getAllWishesSuccess:(void (^)(NSArray <TYDKWishModel *> *list))success
                                      failure:(void (^)(NSError *error))failure {
    
    
        
    return [self requestWithMethod:TYDKRequestMethodJSONGET URLString:@"/index.php/api/index" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
  
        NSArray *wishArray = [TYDKWishModel mj_objectArrayWithKeyValuesArray:[result.msg km_safeArrayForKey:@"wish"]];

        if (result.flag == TYDKResultCodeSuccess) {
            success(wishArray);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
}

- (NSURLSessionDataTask *)getAllMyWishesWithPage:(NSUInteger)page
                                         Success:(void (^)(NSArray <TYDKWishModel *> *list))success
                                         failure:(void (^)(NSError *error))failure {
    
    
    
    NSMutableDictionary *parameters = [@{
                                         @"page" : @(page),
                                         } mutableCopy];
    TYDKUserModel *user = [TYDKDataManager manager].user;
    if (user.isLogin) {
        [parameters setValue:user.member.ID forKey:@"user_id"];
    }
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"index.php/api/user/wish" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        NSArray *wishArray = [TYDKWishModel mj_objectArrayWithKeyValuesArray:[responseObject km_safeArrayForKey:@"msg"]];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(wishArray);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
}

- (NSURLSessionDataTask *)getAllMyOffersWithPage:(NSUInteger)page
                                         Success:(void (^)(NSArray <TYDKOfferModel *> *list))success
                                         failure:(void (^)(NSError *error))failure {
    
    
    NSMutableDictionary *parameters = [@{
                                         @"page" : @(page),
                                         } mutableCopy];
    TYDKUserModel *user = [TYDKDataManager manager].user;
    if (user.isLogin) {
        [parameters setValue:user.member.ID forKey:@"user_id"];
    }
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"index.php/api/user/offer" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        NSArray *wishArray = [TYDKOfferModel mj_objectArrayWithKeyValuesArray:[responseObject km_safeArrayForKey:@"msg"]];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(wishArray);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
}

- (NSURLSessionDataTask *)getWishDetailWithWishID:(NSString *)wishID
                                           userID:(NSString *)userID
                                          Success:(void (^)(TYDKWishModel *wish, NSArray <TYDKOfferModel *> *offers))success
                                          failure:(void (^)(NSError *error))failure {
    
    
    NSMutableDictionary *parameters = [@{
                                         @"wish_id" : wishID,
                                         } mutableCopy];
    TYDKUserModel *user = [TYDKDataManager manager].user;

    if (user.isLogin) {
        [parameters setValue:user.member.ID forKey:@"user_id"];
    } else {
        [parameters setValue:userID forKey:@"user_id"];
    }
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/api/wish/detail" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        TYDKWishModel *wish = [TYDKWishModel mj_objectWithKeyValues:[result.msg km_safeDictionaryForKey:@"wish"]];
        NSArray *offers = [TYDKOfferModel mj_objectArrayWithKeyValuesArray:[result.msg km_safeArrayForKey:@"offers"]];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(wish, offers);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
}

- (NSURLSessionDataTask *)getUploadToken:(void (^)(NSString *uptoken))success
                                 failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = @{}.mutableCopy;
    TYDKUserModel *user = [TYDKDataManager manager].user;
    
    if (user.isLogin) {
        [parameters setValue:user.member.ID forKey:@"user_id"];
    }
    
    
    return [self requestWithMethod:TYDKRequestMethodJSONGET URLString:@"/index.php/api/qiniu/getQiniuImageToken" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *data = responseObject;
        NSString *uptoken = [data km_safeStringForKey:@"uptoken"];
        success(uptoken);
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
    
}

- (NSURLSessionDataTask *)getBalance:(void (^)(CGFloat balance))success
                             failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = @{}.mutableCopy;
    TYDKUserModel *user = [TYDKDataManager manager].user;
    
    if (user.isLogin) {
        [parameters setValue:user.member.ID forKey:@"user_id"];
    }
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/user/getBalance" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        CGFloat balance = [responseObject km_safeStringForKey:@"msg"].doubleValue;
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(balance);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
}

- (NSURLSessionDataTask *)getWalletDetail:(void (^)(NSArray <TYDKWalletDetailModel *> *list))success
                                  failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = @{}.mutableCopy;
    TYDKUserModel *user = [TYDKDataManager manager].user;
    
    if (user.isLogin) {
        [parameters setValue:user.member.ID forKey:@"user_id"];
    }
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/user/walletDetail" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        NSArray *list = [TYDKWalletDetailModel mj_objectArrayWithKeyValuesArray:[responseObject km_safeArrayForKey:@"msg"]];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(list);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];


    
}

//发现
- (NSURLSessionDataTask *)discoverWishesWithCityCode:(NSInteger)cityCode
                                            keywords:(NSString *)keywords
                                                type:(TYDKDiscoverType)type
                                                page:(NSUInteger)page
                                             success:(void (^)(NSArray <TYDKWishModel *> *list))success
                                             failure:(void (^)(NSError *error))failure {
    
    
    NSMutableDictionary *parameters = [@{
                                         @"city" : @(cityCode),
                                         @"status" : @(type),
                                         @"rows" : @(20),
                                         } mutableCopy];
    [parameters setValue:@(page) forKey:@"page"];
    [parameters setValue:keywords forKey:@"keywords"];
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"index.php/api/Discovery/index" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        NSArray *wishArray = [TYDKWishModel mj_objectArrayWithKeyValuesArray:[responseObject km_safeArrayForKey:@"msg"]];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(wishArray);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];

    
}

#pragma mark - Public Request Methods - Create

- (NSURLSessionDataTask *)createWishWithWishDescription:(NSString *)wishDescription
                                              wishPrice:(NSString *)wishPrice
                                               cityCode:(NSInteger)cityCode
                                                success:(void (^)(TYDKPaymentModel *payment))success
                                                failure:(void (^)(NSError *error))failure {
    
    
    
    NSMutableDictionary *parameters = [@{
                                         @"wish_description" : wishDescription,
                                         @"wish_price" : wishPrice,
                                         @"city" : @(cityCode),
                                         } mutableCopy];
    
    if (kUser.isLogin) {
        [parameters setValue:kUser.member.ID forKey:@"user_id"];
    }

    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/wish/create" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
      
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        TYDKPaymentModel *payment = [TYDKPaymentModel mj_objectWithKeyValues:result.msg];

        if (result.flag == TYDKResultCodeSuccess) {

            success(payment);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
    
}

- (NSURLSessionDataTask *)createChargeWithWishID:(NSString *)wishID
                                         success:(void (^)(NSDictionary *chargeInfo))success
                                         failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [@{
                                         @"orderid" : wishID,
                                         } mutableCopy];
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/pay/requestCharge" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if (responseObject) {
            success(responseObject);

        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
    
    
}

- (NSURLSessionDataTask *)createChargeWithWishID:(NSString *)wishID
                                offerDescription:(NSString *)offerDescription
                                         success:(void (^)(TYDKResultModel *result))success
                                         failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parameters = [@{
                                         @"wish_id" : wishID,
                                         @"offer_description" : offerDescription,
                                         } mutableCopy];
    if (kUser.isLogin) {
        [parameters setValue:kUser.member.ID forKey:@"offer_user_id"];
    }

    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/api/offer/create" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
    
    
}

#pragma mark - Cancel

- (NSURLSessionDataTask *)cancelWishWithWishID:(NSString *)wishID
                                       success:(void (^)(TYDKResultModel *result))success
                                       failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [@{
                                         @"wish_id" : wishID,
                                         } mutableCopy];
    
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/api/wish/cancel" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
}

#pragma mark - Choose

- (NSURLSessionDataTask *)confirmOfferWithOfferID:(NSString *)offerID
                                          success:(void (^)(TYDKResultModel *result))success
                                          failure:(void (^)(NSError *error))failure {
    
    
    NSMutableDictionary *parameters = [@{
                                         @"offer_id" : offerID,
                                         } mutableCopy];
    
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/api/wish/confirm" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
}

#pragma mark - Done

- (NSURLSessionDataTask *)doneWishWithWishID:(NSString *)wishID
                                     success:(void (^)(TYDKResultModel *result))success
                                     failure:(void (^)(NSError *error))failure {
    
    
    NSMutableDictionary *parameters = [@{
                                         @"wish_id" : wishID,
                                         } mutableCopy];
    
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/api/wish/done" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        if (result.flag == TYDKResultCodeSuccess) {
            success(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
}

#pragma mark - Public Request Methods - Login & Profile & info

- (NSURLSessionDataTask *)sendSMSWithPhoneNumber:(NSString *)phoneNumber
                                         success:(void (^)(TYDKResultModel *result))success
                                         failure:(void (^)(NSError *error))failure {
    
    
    NSDictionary *parameters = @{
                            @"phone" : phoneNumber
                            };
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/SMS/sendCode" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
                
        if (result.flag == TYDKResultCodeSuccess) {
            success(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
    
}



- (NSURLSessionDataTask *)loginWithPhoneNumber:(NSString *)phoneNumber
                                          code:(NSString *)code
                                       success:(void (^)(TYDKMemberModel *member))success
                                       failure:(void (^)(NSError *error))failure {
    

    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    
    NSMutableDictionary *parameters = [@{
                                         @"mobile_no" : phoneNumber,
                                         @"code" : code
                                         } mutableCopy];
    
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"/index.php/OAuth/loginWithMobile" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        if (result.flag == TYDKResultCodeSuccess) {
            TYDKMemberModel *member = [[TYDKMemberModel alloc] initWithDictionary:result.msg];

            success(member);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:result.flag userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
    
    
}

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
                                          failure:(void (^)(NSError *error))failure {
    
    
    
    
    NSMutableDictionary *parameters = [@{
                                         @"id" : ID,
                                         @"nick_name" : nick_name,
                                         @"sex" : @(sex),
                                         @"age" : age,
                                         @"mobile_no" : mobile_no,
                                         @"headimg" : headimg,
                                         @"country" : country,
                                         @"province" : province,
                                         @"city" : city,
                                         } mutableCopy];
    return [self requestWithMethod:TYDKRequestMethodJSONPOST URLString:@"index.php/api/user/update" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        TYDKResultModel *result = [TYDKResultModel mj_objectWithKeyValues:responseObject];
        
        
        if (result.flag == TYDKResultCodeSuccess) {
            TYDKMemberModel *member = [[TYDKMemberModel alloc] initWithDictionary:result.msg];
            success(member);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:TYDKErrorTypeLoginFailure userInfo:responseObject];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];

    
    
}
#pragma mark - Notifications


#pragma mark - Private Methods


- (NSString*)DataTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


@end

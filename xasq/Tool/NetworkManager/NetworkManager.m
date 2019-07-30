//
//  NetworkManager.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"


#ifdef DEBUG
static NSString *xasqBaseUrl = @"https://xasq.com/";
#else
static NSString *xasqBaseUrl = @"https://xasq.com/";
#endif

const NSTimeInterval xasqTimeoutInterval = 15;

@interface NetworkManager()
    
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
    
@end


@implementation NetworkManager
    
+ (NetworkManager *)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
    
- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        
//        [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
        NSSet *acceptableContentTypes = _sessionManager.responseSerializer.acceptableContentTypes;
        NSSet *addSet = [NSSet setWithObjects:@"text/html",nil];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [acceptableContentTypes setByAddingObjectsFromSet:addSet];
        _sessionManager.requestSerializer.timeoutInterval = xasqTimeoutInterval;
    }
    return self;
}
    
- (void)getRequest:(NSString *)URLString parameters:(nullable NSDictionary * )parameters success:(nonnull SuccessBlock)success failure:(nonnull FailureBlock)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",xasqBaseUrl,URLString];
    [_sessionManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if (success) {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
        }
    }];
}

///post方法请求
- (void)postRequest:(NSString *)URLString parameters:(nullable NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",xasqBaseUrl,URLString];
    
    [_sessionManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark-

    
@end

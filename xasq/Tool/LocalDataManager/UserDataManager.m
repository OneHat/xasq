//
//  UserDataManager.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserDataManager.h"

NSString * const DSSJUserLoginAuthorization = @"DSSJUserLoginAuthorization";
NSString * const DSSJLoginAccount = @"DSSJLoginAccount";
NSString * const DSSJUserId = @"DSSJUserId";
NSString * const DSSJUserData = @"DSSJUserData";

@implementation UserDataManager

+ (instancetype)shareManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:DSSJUserId];
        self.authorization = [[NSUserDefaults standardUserDefaults] objectForKey:DSSJUserLoginAuthorization];
        self.loginAccount = [[NSUserDefaults standardUserDefaults] objectForKey:DSSJLoginAccount];
        NSDictionary *userData = [[NSUserDefaults standardUserDefaults] objectForKey:DSSJUserData];
        self.usermodel = [UserModel modelWithDictionary:userData];
    }
    return self;
}

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:DSSJUserId];
}

- (void)setAuthorization:(NSString *)authorization {
    _authorization = authorization;
    [[NSUserDefaults standardUserDefaults] setObject:authorization forKey:DSSJUserLoginAuthorization];
}

- (void)setLoginAccount:(NSString *)loginAccount {
    _loginAccount = loginAccount;
    [[NSUserDefaults standardUserDefaults] setObject:loginAccount forKey:DSSJLoginAccount];
}

- (void)deleteLoginStatus {
    self.userId = nil;
    self.authorization = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DSSJUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DSSJUserLoginAuthorization];
}

- (void)saveUserData:(NSDictionary *)userData {
    self.usermodel = [UserModel modelWithDictionary:userData];
    
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:DSSJUserData];
}

@end

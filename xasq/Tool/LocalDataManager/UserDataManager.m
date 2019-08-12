//
//  UserDataManager.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserDataManager.h"

NSString * const DSSJUserLoginAuthorization = @"DSSJUserLoginAuthorization";
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:DSSJUserId];
        self.userData = [[NSUserDefaults standardUserDefaults] objectForKey:DSSJUserData];
    }
    return self;
}

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:DSSJUserId];
}

- (void)setUserData:(NSDictionary *)userData {
    _userData = userData;
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:DSSJUserData];
}

- (void)deleteLoginStatus {
    self.userId = nil;
    self.userData = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DSSJUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DSSJUserData];
}

#pragma mark -
+ (NSString *)authorization {
    return [[NSUserDefaults standardUserDefaults] stringForKey:DSSJUserLoginAuthorization];
}

+ (void)saveAuthorization:(NSString *)authorization {
    [[NSUserDefaults standardUserDefaults] setObject:authorization forKey:DSSJUserLoginAuthorization];
}

+ (void)deleteAuthorization {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DSSJUserLoginAuthorization];
}

@end

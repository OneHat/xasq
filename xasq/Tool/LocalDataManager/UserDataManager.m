//
//  UserDataManager.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserDataManager.h"

NSString * const DSSJUserLoginStatus = @"DSSJUserLoginStatus";
NSString * const DSSJUserLoginAuthorization = @"DSSJUserLoginAuthorization";

@implementation UserDataManager

+ (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:DSSJUserLoginStatus];
}

+ (void)saveLoginStatus {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DSSJUserLoginStatus];
}

+ (void)deleteLoginStatus {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DSSJUserLoginStatus];
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

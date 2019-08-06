//
//  ApplicationData.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ApplicationData.h"

 NSString * const DSSJLastVersion = @"DSSJApplicationLastVersion";

@implementation ApplicationData

#pragma mark -
+(void)saveNewVersion {
    [[NSUserDefaults standardUserDefaults] setObject:AppVersion forKey:DSSJLastVersion];
}

+ (NSString *)lastVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:DSSJLastVersion];
}

#pragma mark -
+ (BOOL)checkVersion {
    NSString *lastVersion = [ApplicationData lastVersion];
    if (!lastVersion) {
        return YES;
    }
    
    lastVersion = [lastVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *currentVersion = [AppVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if (currentVersion.integerValue > lastVersion.integerValue) {
        return YES;
    }
    
    return NO;
}

@end

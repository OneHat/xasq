//
//  ApplicationData.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ApplicationData.h"
#import <YYModel/YYModel.h>

NSString * const DSSJLastVersion = @"DSSJApplicationLastVersion";

@implementation UpdateInfoObject

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    return [UpdateInfoObject yy_modelWithDictionary:dict];
}


@end


@implementation ApplicationData

+ (instancetype)shareData {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}

#pragma mark -
- (void)saveNewVersion {
    [[NSUserDefaults standardUserDefaults] setObject:AppVersion forKey:DSSJLastVersion];
}

- (NSString *)lastVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:DSSJLastVersion];
}

#pragma mark -
- (BOOL)isFirstLanuch {
    NSString *lastVersion = [self lastVersion];
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

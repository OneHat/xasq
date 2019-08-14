//
//  CapitalDataManager.m
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalDataManager.h"

NSString * const DSSJCapitalHideMoney = @"DSSJCapitalHideMoney";

@implementation CapitalDataManager

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
        _hideMoney = [[NSUserDefaults standardUserDefaults] boolForKey:DSSJCapitalHideMoney];
    }
    return self;
}

- (void)setHideMoney:(BOOL)hideMoney {
    _hideMoney = hideMoney;
    [[NSUserDefaults standardUserDefaults] setBool:hideMoney forKey:DSSJCapitalHideMoney];
}

@end

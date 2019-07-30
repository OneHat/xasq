//
//  DeviceInformation.m
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "DeviceInformation.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString *service = @"com.dssj";
static NSString *deviceIdKey = @"xasqDeviceIdKey";

@implementation DeviceInformation

+ (DeviceInformation *)currentInformation {
    DeviceInformation *information = [[DeviceInformation alloc] init];
    UIDevice *device = [UIDevice currentDevice];
    
    information.name = device.name;
    information.systemVersion = device.systemVersion;
    information.systemName = device.model;
    
    NSString *idfv = [SAMKeychain passwordForService:service account:deviceIdKey];
    if (!idfv) {
        idfv = device.identifierForVendor.UUIDString;
        [SAMKeychain setPassword:idfv forService:service account:deviceIdKey];
    }
    
    information.deviceId = idfv;
    
    return information;
}

@end

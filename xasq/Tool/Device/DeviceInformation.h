//
//  DeviceInformation.h
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInformation : NSObject

+ (DeviceInformation *)currentInformation;

///
@property (nonatomic, strong) NSString *name;

///版本号
@property (nonatomic, strong) NSString *systemVersion;

///设备，iphone6,iphonex
@property (nonatomic, strong) NSString *systemName;

///deviceId(adfv)
@property (nonatomic, strong) NSString *deviceId;

@end

NS_ASSUME_NONNULL_END

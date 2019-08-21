//
//  MiningAreaModel.h
//  xasq
//
//  Created by dssj on 2019/8/12.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiningAreaModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger areaCode;
@property (nonatomic, strong) NSString *name;//矿区名称
@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, strong) NSString *userLevel;//用户级别
@property (nonatomic, assign) NSInteger createdBy;//添加人
@property (nonatomic, assign) NSInteger updatedBy;//修改人



@end

NS_ASSUME_NONNULL_END

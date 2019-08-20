//
//  HomeRankViewCell.h
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRankModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HomeRankCellStyle) {
    HomeRankCellStylePower,//算力排行
    HomeRankCellStyleLevel,//等级排行
    HomeRankCellStyleInvite,//邀请排行
};

@interface HomeRankViewCell : UITableViewCell

@property (nonatomic, strong) UserRankModel *rankInfo;//

@property (nonatomic, assign) HomeRankCellStyle cellStyle;

@end

NS_ASSUME_NONNULL_END

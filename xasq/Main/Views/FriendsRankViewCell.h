//
//  FriendsRankViewCell.h
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRankModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendsRankViewCell : UITableViewCell

@property (nonatomic, strong) UserRankModel *friendInfo;

@end

NS_ASSUME_NONNULL_END

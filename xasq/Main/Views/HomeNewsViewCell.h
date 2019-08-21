//
//  HomeNewsViewCell.h
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeNewsViewCell : UITableViewCell

@property (nonatomic, strong) UserNewsModel *newsModel;

@end

NS_ASSUME_NONNULL_END

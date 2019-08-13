//
//  TaskViewCell.h
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TaskModel,MyTaskModel;
@interface TaskViewCell : UITableViewCell

@property (nonatomic, strong) TaskModel *task;//推荐、高分任务
@property (nonatomic, strong) TaskModel *myTaskl;//我的任务

@end

NS_ASSUME_NONNULL_END

//
//  TaskViewCell.h
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskViewCell : UITableViewCell

@property (nonatomic, strong) TaskModel *taskModel;

@end

NS_ASSUME_NONNULL_END

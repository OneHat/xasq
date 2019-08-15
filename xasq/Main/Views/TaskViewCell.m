//
//  TaskViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TaskViewCell.h"
#import "TaskModel.h"

@interface TaskViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//任务名称

@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;

@property (weak, nonatomic) IBOutlet UIButton *statusButton;

@end

@implementation TaskViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTask:(TaskModel *)task {
    _task = task;
}

@end

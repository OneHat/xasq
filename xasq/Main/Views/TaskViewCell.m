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

@property (weak, nonatomic) IBOutlet UIImageView *powerImageView;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *currencyImageView;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

@property (weak, nonatomic) IBOutlet UIButton *statusButton;

@end

@implementation TaskViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.powerLabel.textColor = ThemeColorTextGray;
    self.currencyLabel.textColor = ThemeColorTextGray;
    
    self.statusButton.titleLabel.font  =ThemeFontSmallText;
    
    [self.statusButton setTitle:@"去完成" forState:UIControlStateNormal];
    [self.statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.statusButton setBackgroundImage:[UIImage imageNamed:@"task_goFinish"] forState:UIControlStateNormal];
    
    [self.statusButton setImage:[UIImage imageNamed:@"task_complete"] forState:UIControlStateDisabled];
    [self.statusButton setTitle:@" 已完成" forState:UIControlStateDisabled];
    [self.statusButton setTitleColor:HexColor(@"EE5000") forState:UIControlStateDisabled];
    [self.statusButton setBackgroundImage:[UIImage imageFromColor:[UIColor clearColor]] forState:UIControlStateDisabled];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTaskModel:(TaskModel *)taskModel {
    _taskModel = taskModel;
    
    self.nameLabel.text = taskModel.name;
    
    if (taskModel.power > 0) {
        //赠送算力
        self.powerLabel.text = [NSString stringWithFormat:@"+%ld算力",taskModel.power];
        
        if (taskModel.quantity) {
            //赠送币
            self.currencyLabel.text = [NSString stringWithFormat:@"+%.8f%@",taskModel.quantity.doubleValue,taskModel.currencyCode];
            self.currencyImageView.image = Base64ImageStr(_taskModel.currencyIcon);
            
        } else {
            self.currencyImageView.hidden = YES;
            self.currencyLabel.hidden = YES;
        }
        
    } else {
        self.currencyImageView.hidden = YES;
        self.currencyLabel.hidden = YES;
        if (taskModel.quantity) {
            //赠送币
            self.powerLabel.text = [NSString stringWithFormat:@"+%.8f%@",taskModel.quantity.doubleValue,taskModel.currencyCode];
            self.currencyImageView.image = Base64ImageStr(_taskModel.currencyIcon);
            
        } else {
            self.powerLabel.hidden = YES;
            self.powerImageView.hidden = YES;
        }
        
    }
    
    self.statusButton.enabled = !taskModel.finished;
}



@end

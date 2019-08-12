//
//  UserHeaderView.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *dwellBtn;  // 跳转居住证明界面
@property (weak, nonatomic) IBOutlet UILabel *countLB;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn; // 消息通知Btn
@property (weak, nonatomic) IBOutlet UILabel *nameLB;  // 用户名
@property (weak, nonatomic) IBOutlet UILabel *regionLB;  // 地区
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageV; // 头像


@property (weak, nonatomic) IBOutlet UIButton *taskBtn; // 任务按钮
@property (weak, nonatomic) IBOutlet UIButton *friendBtn; // 好友按钮
@property (weak, nonatomic) IBOutlet UIImageView *taskImageV;
@property (weak, nonatomic) IBOutlet UIImageView *friendImageV;

@property (nonatomic, copy) void (^dwellBtnBlock)(void);
@property (nonatomic, copy) void (^messageBtnBlock)(void);
@property (nonatomic, copy) void (^taskBtnBlock)(void);
@property (nonatomic, copy) void (^friendBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END

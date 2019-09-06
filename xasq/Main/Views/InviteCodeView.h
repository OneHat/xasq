//
//  InviteCodeView.h
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,InviteCodeViewButtonStyle) {
    InviteCodeViewButtonStyleBind,//绑定邀请
    InviteCodeViewButtonStyleCopy,//复制
    InviteCodeViewButtonStyleStartInvite,//开始邀请
};

typedef void(^ButtonClickBlock)(InviteCodeViewButtonStyle style);

@interface InviteCodeView : UIView

@property (nonatomic, strong) ButtonClickBlock buttonClickBlock;

@property (nonatomic, strong) NSDictionary *inviteInfo;

- (void)bindInviteButtonSelection;

@end

NS_ASSUME_NONNULL_END

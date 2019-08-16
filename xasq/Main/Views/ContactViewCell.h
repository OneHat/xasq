//
//  ContactViewCell.h
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shortLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (weak, nonatomic) IBOutlet UIButton *inviteButton;
@end

NS_ASSUME_NONNULL_END

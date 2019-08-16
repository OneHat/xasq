//
//  CapitalListViewCell.h
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapitalListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名称
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;//个数
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;//美元

@end

NS_ASSUME_NONNULL_END

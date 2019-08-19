//
//  MobilePhoneTableViewCell.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobilePhoneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLB; // 名称

@property (weak, nonatomic) IBOutlet UILabel *codeLB; // 电话区号

@end

NS_ASSUME_NONNULL_END

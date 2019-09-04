//
//  PaymentsRecordsTableViewCell.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentsRecordsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *valueLB;

@property (nonatomic, strong) PaymentsRecordModel *model;
@end

NS_ASSUME_NONNULL_END

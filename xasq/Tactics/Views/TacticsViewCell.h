//
//  TacticsViewCell.h
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TacticsObject;
@interface TacticsViewCell : UITableViewCell

- (void)cellWithTacsics:(TacticsObject *)model;

@end

NS_ASSUME_NONNULL_END

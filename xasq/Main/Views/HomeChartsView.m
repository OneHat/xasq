//
//  HomeChartsView.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeChartsView.h"
#import "SegmentedControl.h"

@interface HomeChartsView ()

@property (nonatomic, strong) SegmentedControl *segmentedControl;

@end

@implementation HomeChartsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _segmentedControl = [[SegmentedControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)
                                                              items:@[@"算力排行",@"等级排行",@"邀请排行"]];
        [self addSubview:_segmentedControl];
        
    }
    return self;
}

@end

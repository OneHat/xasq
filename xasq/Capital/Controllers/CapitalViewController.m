//
//  CapitalViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalViewController.h"
#import "CapitalSegmentedControl.h"

//#import "CapitalModuleView.h"

@interface CapitalViewController ()

@property (weak, nonatomic) IBOutlet UIView *segmentedView;

//@property (strong, nonatomic) UIScrollView *segmentedView;

@end

@implementation CapitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资产";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBarBackGroundColor:[UIColor clearColor]];
    [self setNavBarTitleColor:[UIColor whiteColor]];
    
    _segmentedView.backgroundColor = [UIColor clearColor];
    CapitalSegmentedControl *segmentedControl = [[CapitalSegmentedControl alloc] initWithFrame:self.segmentedView.bounds items:@[@"我的钱包",@"挖财账户"]];
    [self.segmentedView addSubview:segmentedControl];
    
}



@end

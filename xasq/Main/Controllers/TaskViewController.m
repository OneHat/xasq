//
//  TaskViewController.m
//  xasq
//
//  Created by dssj on 2019/8/8.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[NetworkManager sharedManager] getRequest:CommunityTask parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
        NSLog(@"%@",data);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end

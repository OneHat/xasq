//
//  CapitalSearchViewController.m
//  xasq
//
//  Created by dssj on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalSearchViewController.h"

@interface CapitalSearchViewController ()<UISearchBarDelegate>

@end

@implementation CapitalSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate = self;
    
    self.navigationItem.titleView = searchBar;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"rtyrty" style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnAction)];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

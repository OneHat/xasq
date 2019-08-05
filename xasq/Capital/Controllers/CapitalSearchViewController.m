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
}

@end

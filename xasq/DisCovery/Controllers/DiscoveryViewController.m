//
//  DiscoveryViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "LettersViewController.h"
#import "CalendarViewController.h"

@interface DiscoveryViewController ()
@property (nonatomic, copy) NSArray *controllerArr;

//参考HomeViewController（首页）
@property (assign, nonatomic) BOOL hideNavBarAnimation;
@property (assign, nonatomic) BOOL hideNavBarWhenDisappear;//页面消失，是否需要隐藏导航栏，默认NO

@end

@implementation DiscoveryViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.automaticallyCalculatesItemWidths = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleColorSelected = ThemeColorBlue;
        self.titleColorNormal = ThemeColorGray;
        self.itemMargin = 15;
        self.progressHeight = 3;
        self.menuViewColor = [UIColor whiteColor];
        LettersViewController *vc0 = [[LettersViewController alloc] init];
        vc0.title = @"西岸快报";
        
        UIViewController *vc1 = [[UIViewController alloc] init];
        vc1.title = @"期货";
        
        UIViewController *vc2 = [[UIViewController alloc] init];
        vc2.title = @"加密货币";
        
        CalendarViewController *vc3 = [[CalendarViewController alloc] init];
        vc3.title = @"财经日历";
        
        self.controllerArr = @[vc0, vc1, vc2, vc3];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
    lineView.backgroundColor = ThemeColorLine;
    [self.menuView addSubview:lineView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDiscoveryHideAnimation) name:DSSJTabBarSelectDiscoveryNotification object:nil];
    
    [self getOperCategoryList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hideNavBarWhenDisappear = NO;
    [self getOperCategoryList];
}

- (void)changeDiscoveryHideAnimation {
    _hideNavBarAnimation = NO;
}

- (void)getOperCategoryList {
    NSDictionary *dict = @{@"fatherId"   : @"1",
                           @"client" : @"app",
                           };
    [[NetworkManager sharedManager] getRequest:OperCategoryList parameters:dict success:^(NSDictionary * _Nonnull data) {
        if (data) {
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return _controllerArr.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    UIViewController *vc = _controllerArr[index];
    return vc.title;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return _controllerArr[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, StatusBarHeight, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height-originY);
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    //    FXLog(@"开始进入");
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    //    FXLog(@"已经进入");
    if (pageController.selectIndex == 2) {

    } else if (pageController.selectIndex == 3) {

    }else {

    }
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

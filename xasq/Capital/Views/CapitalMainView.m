//
//  CapitalSubView.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalMainView.h"
#import "CapitalListViewCell.h"
#import "CapitalTopView.h"
#import "CapitalActionModuleView.h"

@interface CapitalMainView () <UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) CapitalActionModuleView *moduleView;
@property (nonatomic, strong) UITableView *tableView;

@end

static CGFloat CapitalSegmentControlH = 40;

@implementation CapitalMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    CGFloat topSpaceH = CapitalSegmentControlH + NavHeight;
    
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, topSpaceH, ScreenWidth, 20)];
    topView.viewStyle = CapitalTopViewAll;
    topView.RecordClickBlock = ^{
        if ([self.delegate respondsToSelector:@selector(capitalMainViewRecordClick)]) {
            [self.delegate capitalMainViewRecordClick];
        }
    };
    [self addSubview:topView];
    
    ////topView的高度会根据内容自己计算，这里重新赋值高度给外层
    CGFloat topViewH = topView.frame.size.height;
    _topCapitalViewH = topSpaceH + topViewH;
    
    //充币、提币模块view
    CapitalActionModuleView *modulView = [[CapitalActionModuleView alloc] initWithFrame:CGRectMake(0, _topCapitalViewH, ScreenWidth, 10)];
    modulView.ButtonClickBlock = ^(NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(capitalMainViewButtonModuleClick:)]) {
            [self.delegate capitalMainViewButtonModuleClick:index];
        }
    };
    [self addSubview:modulView];
    
    
//    CGFloat tableViewY = _topCapitalViewH + 10;
    CGFloat tableViewY = CGRectGetMaxY(modulView.frame) + 10;
    //列表
    CGRect rect = CGRectMake(0, tableViewY, ScreenWidth, self.frame.size.height - tableViewY);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"CapitalListViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = 55;
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.tableHeaderView = [self tableHeaderView];
    [self addSubview:_tableView];
}


#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CapitalListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    headerView.backgroundColor = ThemeColorBackground;
    
    //搜索
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [searchButton setImage:[UIImage imageNamed:@"Search_Button"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:searchButton];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 90, 44)];
    searchLabel.textColor = ThemeColorTextGray;
    searchLabel.font = ThemeFontSmallText;
    searchLabel.text = @"搜索币种";
    [headerView addSubview:searchLabel];
    
    //隐藏0余额
    UILabel *hideZeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 100, 0, 90, 44)];
    hideZeroLabel.textColor = ThemeColorTextGray;
    hideZeroLabel.font = ThemeFontSmallText;
    hideZeroLabel.textAlignment = NSTextAlignmentRight;
    hideZeroLabel.text = @"隐藏0余额";
    [headerView addSubview:hideZeroLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(capitalMainViewCellSelect:)]) {
        [self.delegate capitalMainViewCellSelect:indexPath.row];
    }
}

- (void)searchButtonClick {
    if ([self.delegate respondsToSelector:@selector(capitalMainViewSearchClick)]) {
        [self.delegate capitalMainViewSearchClick];
    }
}

#pragma mark-
- (UIView *)tableHeaderView {
    CapitalActionModuleView *modulView = [[CapitalActionModuleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    modulView.ButtonClickBlock = ^(NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(capitalMainViewButtonModuleClick:)]) {
            [self.delegate capitalMainViewButtonModuleClick:index];
        }
    };
    return modulView;
}

@end

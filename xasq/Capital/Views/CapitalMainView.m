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

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CapitalTopView *topView;//资产数值

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
    _topView = topView;
    
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
    
    //列表
    CGFloat tableViewY = _topCapitalViewH + 10;
    CGRect rect = CGRectMake(0, tableViewY, ScreenWidth, self.frame.size.height - tableViewY);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"CapitalListViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = 60;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [self tableHeaderView];
    [self addSubview:_tableView];
}

- (void)setHideMoney:(BOOL)hideMoney {
    _topView.hideMoney = hideMoney;
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
    CGFloat height = 50;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    headerView.backgroundColor = ThemeColorBackground;
    
    //搜索
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 90, height)];
    searchLabel.textColor = ThemeColorTextGray;
    searchLabel.font = ThemeFontSmallText;
    searchLabel.text = @"搜索币种";
    [headerView addSubview:searchLabel];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 80, height)];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [searchButton setImage:[UIImage imageNamed:@"Search_Button"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:searchButton];
    
    //隐藏0余额
    CGSize size = [@"隐藏0余额" sizeWithAttributes:@{NSFontAttributeName:ThemeFontSmallText}];
    CGFloat labelWidth = ceil(size.width);
    
    UILabel *hideZeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - labelWidth - 10, 0, labelWidth, height)];
    hideZeroLabel.textColor = ThemeColorTextGray;
    hideZeroLabel.font = ThemeFontSmallText;
    hideZeroLabel.textAlignment = NSTextAlignmentRight;
    hideZeroLabel.text = @"隐藏0余额";
    [headerView addSubview:hideZeroLabel];
    
    UIButton *checkButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - labelWidth - 40, 0, 44, height)];
    [checkButton setImage:[UIImage imageNamed:@"checkBox_unselect"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"checkBox_select"] forState:UIControlStateSelected];
    [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:checkButton];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(capitalMainViewCellSelect:)]) {
        [self.delegate capitalMainViewCellSelect:indexPath.row];
    }
}

#pragma mark -
- (UIView *)tableHeaderView {
    CapitalActionModuleView *modulView = [[CapitalActionModuleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    modulView.ButtonClickBlock = ^(NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(capitalMainViewButtonModuleClick:)]) {
            [self.delegate capitalMainViewButtonModuleClick:index];
        }
    };
    return modulView;
}

#pragma mark -
- (void)searchButtonClick {
    if ([self.delegate respondsToSelector:@selector(capitalMainViewSearchClick)]) {
        [self.delegate capitalMainViewSearchClick];
    }
}

- (void)checkButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end

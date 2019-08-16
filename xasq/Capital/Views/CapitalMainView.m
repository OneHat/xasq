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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHideMony) name:CapitalChangeHideMoneyStatus object:nil];
    }
    return self;
}

- (void)loadSubViews {
    CGFloat topSpaceH = CapitalSegmentControlH + NavHeight;
    
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, topSpaceH, ScreenWidth, 20)];
    topView.viewStyle = CapitalTopViewAll;
    topView.DrawClickBlock = ^{
        if ([self.delegate respondsToSelector:@selector(capitalMainViewDrawClick)]) {
            [self.delegate capitalMainViewDrawClick];
        }
    };
    [self addSubview:topView];
    _topView = topView;
    
    ////topView的高度会根据内容自己计算，这里重新赋值高度给外层
    CGFloat topViewH = topView.frame.size.height;
    _topCapitalViewH = topSpaceH + topViewH;
    
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
//    _tableView.tableHeaderView = [self tableHeaderView];
    [self addSubview:_tableView];
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CapitalListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if ([CapitalDataManager shareManager].hideMoney) {
        cell.numberLabel.text = @"****";
        cell.moneyLabel.text = @"****";
    } else {
        cell.numberLabel.text = @"0.000BTC";
        cell.moneyLabel.text = @"$0.00";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat height = 50;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    headerView.backgroundColor = ThemeColorBackground;
    
//    //搜索
//    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 90, height)];
//    searchLabel.textColor = ThemeColorTextGray;
//    searchLabel.font = ThemeFontSmallText;
//    searchLabel.text = @"搜索币种";
//    [headerView addSubview:searchLabel];
//
//    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 80, height)];
//    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [searchButton setImage:[UIImage imageNamed:@"Search_Button"] forState:UIControlStateNormal];
//    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:searchButton];
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 12)];
    leftView.image = [UIImage imageNamed:@"Search_Button"];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth * 0.5, 30)];
    [searchField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    searchField.leftView = leftView;
    searchField.leftViewMode = UITextFieldViewModeAlways;
    searchField.font = ThemeFontSmallText;
    searchField.placeholder = @"搜索币种";
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [headerView addSubview:searchField];
    
    
    //隐藏0余额
    CGFloat labelWidth = [@"隐藏0余额" getWidthWithFont:ThemeFontSmallText];
    
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
//- (UIView *)tableHeaderView {
//    CapitalActionModuleView *modulView = [[CapitalActionModuleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    modulView.ButtonClickBlock = ^(NSInteger index) {
//        if ([self.delegate respondsToSelector:@selector(capitalMainViewButtonModuleClick:)]) {
//            [self.delegate capitalMainViewButtonModuleClick:index];
//        }
//    };
//    return modulView;
//}

#pragma mark -
- (void)searchButtonClick {
    if ([self.delegate respondsToSelector:@selector(capitalMainViewSearchClick)]) {
        [self.delegate capitalMainViewSearchClick];
    }
}

///隐藏0余额按钮
- (void)checkButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
}

#pragma mark - UITextFieldDelegate
- (void)textChange:(UITextField *)field {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(search) object:nil];
    [self performSelector:@selector(search) withObject:nil afterDelay:0.4];
}

- (void)search {
    
}

- (void)changeHideMony {
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

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
#import "CapitalModel.h"

@interface CapitalMainView () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CapitalTopView *topView;//资产数值
@property (nonatomic, strong) NSMutableArray *dataArray;
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
    _dataArray = [NSMutableArray array];
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
    CGFloat tableViewY = _topCapitalViewH;
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

- (void)setTotalAssets:(NSDictionary *)dict {
    _topView.BTCStr = [NSString stringWithFormat:@"%@ BTC",dict[@"toBTCSum"]];
    _topView.moneyStr = [NSString stringWithFormat:@"%@",dict[@"toCNYSum"]];
}

- (void)setCapitalDataArray:(NSDictionary *)dict {
    NSArray *array = dict[@"data"][@"rows"];
    [_dataArray removeAllObjects];
    for (NSDictionary *dic in array) {
        CapitalModel *model = [CapitalModel modelWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CapitalListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CapitalModel *model = _dataArray[indexPath.row];
    cell.nameLabel.text = model.currency;
    if ([CapitalDataManager shareManager].hideMoney) {
        cell.numberLabel.text = @"****";
        cell.moneyLabel.text = @"****";
    } else {
        cell.numberLabel.text = model.amount;
        cell.moneyLabel.text = [NSString stringWithFormat:@"≈¥%@",model.toCNY];
    }
    UIImage *icon = Base64ImageStr(model.icon);
    if (icon) {
        cell.iconView.image = icon;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
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
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    _searchBar.searchBarStyle = UISearchBarStyleProminent;
    _searchBar.backgroundColor = ThemeColorBackground;
    _searchBar.barTintColor = ThemeColorBackground;
    // 清除上下横线
    for (UIView *subView in _searchBar.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
        }
    }
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    if(searchField){
        //设置字体颜色
        searchField.textColor = ThemeColorText;
        searchField.backgroundColor = ThemeColorBackground;
        searchField.font = ThemeFontSmallText;
    }
    _searchBar.showsCancelButton = NO;
    _searchBar.placeholder = @"搜索币种";
    _searchBar.delegate = self;
    [headerView addSubview:_searchBar];
    [headerView addSubview:searchField];
    
    //隐藏0余额
    CGFloat labelWidth = [@"隐藏0余额" getWidthWithFont:ThemeFontSmallText];
    
    UILabel *hideZeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - labelWidth - 10, 0, labelWidth, height)];
    hideZeroLabel.textColor = ThemeColorTextGray;
    hideZeroLabel.font = ThemeFontSmallText;
    hideZeroLabel.textAlignment = NSTextAlignmentRight;
    hideZeroLabel.text = @"隐藏0余额";
    [headerView addSubview:hideZeroLabel];
    
    UIButton *checkButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    checkButton.frame = CGRectMake(ScreenWidth - labelWidth - 40, 0, 44, height);
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

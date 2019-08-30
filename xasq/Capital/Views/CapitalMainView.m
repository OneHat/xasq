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
@property (nonatomic, strong) NSMutableArray *cacheArray;
@property (nonatomic, strong) UIButton *checkButton; // 隐藏按钮
@property (nonatomic, strong) UILabel *hideZeroLabel;  // 隐藏0金额label
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
    _cacheArray = [NSMutableArray array];
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
    [self addSubview:_tableView];
}

- (void)hiddenBtnOrLabel:(BOOL)isHidden {
    _checkButton.hidden = isHidden;
    _hideZeroLabel.hidden = isHidden;
}

- (void)setTotalAssets:(NSDictionary *)dict {
    _topView.BTCStr = [NSString stringWithFormat:@"%@ BTC",dict[@"toBTCSum"]];
    _topView.moneyStr = [NSString stringWithFormat:@"%@",dict[@"toCNYSum"]];
}

- (void)setCapitalDataArray:(NSDictionary *)dict {
    NSArray *array = dict[@"data"];
    [_dataArray removeAllObjects];
    [_cacheArray removeAllObjects];
    for (NSDictionary *dic in array) {
        CapitalModel *model = [CapitalModel modelWithDictionary:dic];
        [_dataArray addObject:model];
        [_cacheArray addObject:model];
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
        cell.moneyLabel.text = [NSString stringWithFormat:@"≈¥%@",model.toCNY?model.toCNY:@"--"];
    }
    UIImage *icon = Base64ImageStr(model.icon);
    if (icon) {
        cell.iconView.image = icon;
    } else {
        cell.iconView.image = [UIImage imageNamed:@"currency_btc"];
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
    
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth-10, 50)];
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
    }
    [headerView addSubview:_searchBar];
    
    CGFloat labelWidth = [@"隐藏0余额" getWidthWithFont:ThemeFontSmallText];
    if (!_hideZeroLabel) {
        //隐藏0余额
        _hideZeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - labelWidth - 20, 0, labelWidth, height)];
        _hideZeroLabel.textColor = ThemeColorTextGray;
        _hideZeroLabel.font = ThemeFontSmallText;
        _hideZeroLabel.textAlignment = NSTextAlignmentRight;
        _hideZeroLabel.text = @"隐藏0余额";
    }
    [headerView addSubview:_hideZeroLabel];
    
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _checkButton.frame = CGRectMake(ScreenWidth - labelWidth - 50, 0, 44, height);
        [_checkButton setImage:[UIImage imageNamed:@"checkBox_unselect"] forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"checkBox_select"] forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [headerView addSubview:_checkButton];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(capitalMainViewCellSelect:)]) {
        [self.delegate capitalMainViewCellSelect:indexPath.row];
    }
}

#pragma mark -

/// 更新隐藏0余额按钮状态
- (void)checkButtonClick:(UIButton *)sender {
    _checkButton.selected = !_checkButton.selected;
    if (_checkButton.selected) {
        // 隐藏0金额
        NSMutableArray *tempArray = [NSMutableArray array];
        for (CapitalModel *model in _cacheArray) {
            if ([model.amount integerValue] > 0) {
                [tempArray addObject:model];
            }
        }
        _dataArray = [NSMutableArray arrayWithArray:tempArray];
    } else {
        // 全部显示
        _dataArray = [NSMutableArray arrayWithArray:_cacheArray];
    }
    [_tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if ([_delegate respondsToSelector:@selector(hiddenAmountClick:)]) {
        [_delegate hiddenAmountClick:YES];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    BOOL isHidden;
    if (_searchBar.text.length > 0) {
        isHidden = YES;
    } else {
        isHidden = NO;
    }
    if ([_delegate respondsToSelector:@selector(hiddenAmountClick:)]) {
        [_delegate hiddenAmountClick:isHidden];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length > 0) {
        NSString *predicateStr = [NSString stringWithFormat:@"SELF CONTAINS[cd] '%@'",searchText];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateStr];
        NSMutableArray *valueArr = [NSMutableArray array];
        for (CapitalModel *model in _cacheArray) {
            BOOL isSearch = [predicate evaluateWithObject:model.currency];
            if (isSearch) {
                [valueArr addObject:model];
            }
        }
        _dataArray = [NSMutableArray arrayWithArray:valueArr];
    } else {
        _dataArray = [NSMutableArray arrayWithArray:_cacheArray];
//        if ([_delegate respondsToSelector:@selector(hiddenAmountClick:)]) {
//            [_delegate hiddenAmountClick:NO];
//        }
    }
    [_tableView reloadData];
}

- (void)changeHideMony {
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

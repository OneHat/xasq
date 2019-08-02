//
//  CapitalSubView.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalSubView.h"
#import "CapitalListViewCell.h"
#import "CapitalTopView.h"

@interface CapitalSubView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

static CGFloat CapitalSegmentControlH = 40;

@implementation CapitalSubView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    topImageView.image = [UIImage imageNamed:@"capital_topBackground"];
    [self addSubview:topImageView];
    
    CGFloat topSpaceH = CapitalSegmentControlH + NavHeight;
    
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, topSpaceH, ScreenWidth, 20)];
    [self addSubview:topView];
    
    ////topView的高度会根据内容自己计算，这里重新赋值高度给外层
    CGFloat topViewH = topView.frame.size.height;
    topImageView.frame = CGRectMake(0, 0, ScreenWidth, topSpaceH + topViewH);
    
    //充币、提币模块view
    UIView *modulView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topImageView.frame), ScreenWidth, 10)];
    [self addSubview:modulView];
    
    //列表
    CGRect rect = CGRectMake(0, CGRectGetMaxY(modulView.frame), ScreenWidth, self.frame.size.height - CGRectGetMaxY(modulView.frame));
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"CapitalListViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = 55;
    _tableView.dataSource = self;
    _tableView.delegate = self;
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
    
    UILabel *hideZeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 100, 0, 90, 44)];
    hideZeroLabel.font = ThemeFontText;
    hideZeroLabel.textAlignment = NSTextAlignmentRight;
    hideZeroLabel.text = @"隐藏0余额";
    [headerView addSubview:hideZeroLabel];
    
    return headerView;
}

@end

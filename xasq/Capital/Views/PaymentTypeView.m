//
//  PaymentTypeView.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PaymentTypeView.h"
#import "PaymentTypeCollectionViewCell.h"
#import "CapitalModel.h"

@interface PaymentTypeView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconArray;

@end

@implementation PaymentTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}
    
- (void)loadSubViews {
    self.backgroundColor = [UIColor clearColor];
    UIView *backgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backgV.backgroundColor = [UIColor blackColor];
    backgV.alpha = 0.6;
    backgV.userInteractionEnabled = YES;
    [self addSubview:backgV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearClick:)];
    [backgV addGestureRecognizer:tap];
    NSInteger height = 235;
    if (_type == 0) {
        height = 235;
    } else {
        height = 90;
        _titleArray = @[@"全部",@"奖励", @"提币"];
        _iconArray = @[@"capital_all",@"capital_reward_top", @"capital_mention_money"];
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置网状结构的属性
    // 最小行间距
    layout.minimumLineSpacing = 0;
    // 最小列间距
    layout.minimumInteritemSpacing = 0;
    // 设置内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    // item的大小
    layout.itemSize = CGSizeMake(90, 75);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) collectionViewLayout:layout];
    // 设置代理与数据源代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 注册要使用的cell
    [_collectionView registerNib:[UINib nibWithNibName:@"PaymentTypeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PaymentTypeCollectionViewCell"];

    [self addSubview:_collectionView];
    
}

- (void)setType:(NSInteger)type {
    _type = type;
    NSInteger height = 235;
    if (_type == 2) {
        height = 160;
        _titleArray = @[@"全部",@"任务奖励", @"提币", @"挖矿收益", @"团收益"];
        if (!_iconArray) {
            _iconArray = @[@"capital_all",@"capital_reward_top", @"capital_extract_top", @"capital_dig_top", @"capital_group_top"];
        }
    }
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    [_collectionView reloadData];
}

- (void)setCommunityAreaCurrency:(NSArray *)array {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableArray *iconTempArray = [NSMutableArray arrayWithCapacity:array.count];
    if (array.count > 0) {
        [tempArray addObject:@"全部"];
        [iconTempArray addObject:@"capital_all"];
        for (CapitalModel *model in array) {
            [tempArray addObject:model.currency];
            [iconTempArray addObject:model.icon];
        }
        _titleArray = [NSArray arrayWithArray:tempArray];
        _iconArray = [NSArray arrayWithArray:iconTempArray];
    }
    NSInteger height = ((_titleArray.count / 4) + ((_titleArray.count % 4)==0?0:1)) * 75 + 10;
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PaymentTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PaymentTypeCollectionViewCell" forIndexPath:indexPath];
    cell.titleLB.text = _titleArray[indexPath.row];
    if (_type == 1) {
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"capital_all"];
        } else {
            UIImage *icon = Base64ImageStr(_iconArray[indexPath.row]);
            if (icon) {
                cell.icon.image = icon;
            } else {
                cell.icon.image = [UIImage imageNamed:@"currency_default"];
            }
        }
    } else {
        cell.icon.image = [UIImage imageNamed:_iconArray[indexPath.row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_paymentTypeBlock) {
        _paymentTypeBlock(indexPath.row);
    }
    [self removeFromSuperview];
}

- (void)clearClick:(UITapGestureRecognizer *)tap {
    [self removeGestureRecognizer:tap];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

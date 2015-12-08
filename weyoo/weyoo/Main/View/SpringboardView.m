//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//


#import "SpringboardView.h"
#import "ItemView.h"


@implementation SpringboardView


#pragma mark ###############初始化方法##########################
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initViews];
}

/**
 * 初始化各试图
 */
- (void)initViews {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:mBackgroundImage];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
    }

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }

    [self initDatas];
    [self loadDataSource];
}

/**
 * 初始化各种变量以及数据
 */
- (void)initDatas {
    if (!_itemModelArray) {
        _itemModelArray = [NSMutableArray array];
    }
    if (!_itemCenterArray) {
        _itemCenterArray = [NSMutableArray array];
    }
    if (!_itemViewArray) {
        _itemViewArray = [NSMutableArray array];
    }
}


/**
 * 获取数据源方法,加载数据源
 */
- (void)loadDataSource {
    //先移除旧数据
    [_itemModelArray removeAllObjects];
    //增加最新数据库中数据
    [_itemModelArray addObjectsFromArray:[AppModel findAll]];
    NSLog(@"%@", _itemModelArray);

    //根据数据源配置items
    [self initItems];
}

/**
 * 初始化item的View
 */
- (void)initItems {
    if (_itemModelArray.count == 0) {
        return;
    }

    for (int i = 0; i < _itemModelArray.count; i++) {
        AppModel *appModel = _itemModelArray[i];
        ItemView *itemView = [[ItemView alloc] init];
        itemView.bounds.size = CGSizeMake(kItemWidth, kItemHeight);
        itemView.appModel = appModel;
    }
}

/**
 * 调整各控件的frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];

}


#pragma mark ##########################通用方法###################################
+ (int)columnCount {
    return 3;
}

+ (int)rowCount {
    return 3;
}

@end
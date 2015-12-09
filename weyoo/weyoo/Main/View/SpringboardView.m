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
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

/**
 * 初始化
 */
- (void)setup {
    [self initViews];
    [self initDatas];
    [self loadDataSource];
    [self loadItems];
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
}

/**
 * 初始化各种变量以及数据
 */
- (void)initDatas {
    if (!_itemModelArray) {
        _itemModelArray = [NSMutableArray array];
    }
    if (!_itemViewArray) {
        _itemViewArray = [NSMutableArray array];
    }
    if (!_itemCenterArray) {
        _itemCenterArray = [NSMutableArray array];
    }
}

/**
 * 清除旧数据
 */
- (void)clearOldData {
    //移除旧应用模型数据源
    [_itemModelArray removeAllObjects];
    //清除旧的item试图
    if (_itemViewArray.count != 0) {
        for (ItemView *itemView in _itemViewArray) {
            [itemView removeFromSuperview];
        }
        [_itemViewArray removeAllObjects];
    }
    //清除旧的item视图位置信息
    [_itemCenterArray removeAllObjects];
}


/**
 * 获取数据源方法,加载数据源
 */
- (void)loadDataSource {
    //增加最新数据库中数据
    [_itemModelArray addObjectsFromArray:[AppModel findAll]];
    NSLog(@"%@", _itemModelArray);
}

/**
 * 加载 itemView 以及相关 位置信息和手势判断
 */
- (void)loadItems {
    if (_itemModelArray.count == 0) {
        return;
    }
    [self loadItemViews];
}

/**
 * 根据数据源加载item视图
 */
- (void)loadItemViews {
    for (int i = 0; i < _itemModelArray.count; i++) {
        AppModel *appModel = _itemModelArray[i];
        [_itemViewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ItemView *beforeItem = _itemViewArray[idx];
            if (_itemViewArray.count != 0 &&
                    beforeItem.appModel.page == appModel.page &&
                    beforeItem.appModel.position == appModel.position) {
                [beforeItem addSubItemWithModel:appModel];
            } else {
                ItemView *itemView = [[ItemView alloc] init];
                itemView.bounds = CGRectMake(0, 0, kItemWidth, kItemHeight);
                itemView.appModel = appModel;
                [_scrollView addSubview:itemView];
                [_itemViewArray addObject:itemView];
                if (appModel.isFolder == 1) {
                    [itemView becomeFolder];
                }
            }
        }];
    }
}

#pragma mark #########################布局相关#####################################
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
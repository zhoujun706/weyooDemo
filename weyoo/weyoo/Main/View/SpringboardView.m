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
    [self initGesture];
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
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
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
    if (!_itemFrameArray) {
        _itemFrameArray = [NSMutableArray array];
    }

    _totalPage = 0;
    _currentPage = 0;
}

- (void)initGesture {
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self addGestureRecognizer:_longPressGesture];
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
    [_itemFrameArray removeAllObjects];
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
 * 根据数据源加载item视图, 涉及到应用有可能是文件夹
 */
- (void)loadItemViews {
    for (int i = 0; i < _itemModelArray.count; i++) {
        AppModel *appModel = _itemModelArray[i];
        NSMutableArray *pageItemViewArray;
        if (_itemViewArray.count > appModel.page) {
            pageItemViewArray = _itemViewArray[appModel.page];
        } else {
            pageItemViewArray = [NSMutableArray array];
            [_itemViewArray addObject:pageItemViewArray];
        }
        if (pageItemViewArray.count == 0) {
            [pageItemViewArray addObject:[self createItemViewWithModel:appModel]];
        } else {
            [pageItemViewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ItemView *beforeItem = pageItemViewArray[idx];
                if (beforeItem.appModel.page == appModel.page &&
                        beforeItem.appModel.position == appModel.position) {
                    [beforeItem addSubItemWithModel:appModel];
                } else if (idx == pageItemViewArray.count - 1) {
                    [pageItemViewArray addObject:[self createItemViewWithModel:appModel]];
                }
            }];
        }
    }
}

/**
 *  根据模型创建一个item视图
 */
- (ItemView *)createItemViewWithModel:(AppModel *)appModel {
    ItemView *itemView = [[ItemView alloc] init];
    itemView.frame = CGRectMake(0, 0, kItemWidth, kItemHeight);
    itemView.appModel = appModel;
    if (appModel.isFolder == 1) {
        [itemView becomeFolder];
    }
    //加到主视图上
    [_scrollView addSubview:itemView];
    
    return itemView;
}

#pragma mark #########################布局相关#####################################
/**
 * 调整各控件的frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];

    [self layoutBasicViews];
    [self updateItemsFrame];
    [self layoutItemViews];
}

/**
 * 布局基本控件位置
 */
- (void)layoutBasicViews {
    //计算出总页数
    _totalPage = (int)_itemViewArray.count;

    _bgImageView.frame = self.bounds;

    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(
            _scrollView.bounds.size.width * _totalPage,
            _scrollView.bounds.size.height);

}

- (void)layoutItemViews {
    for (NSMutableArray *pageItemViews in _itemViewArray) {
        for (ItemView *itemView in pageItemViews) {
            itemView.frame = [_itemFrameArray[itemView.appModel.page][itemView.appModel.position] CGRectValue];
        }
    }
}


/**
 * 更新各个item的位置信息
 */
- (void)updateItemsFrame {
    //间隔相等风格
    if (kIsEqualSpaceStyle) {
        [self updateEqualSpaceItemsFrame];
    } else {
        [self updateCustomSpaceItemsFrame];
    }
}

/**
 *  计算想通间隔风格时的item位置信息
 */
- (void)updateEqualSpaceItemsFrame {
    if (_itemFrameArray.count == 0) {
        //先计算出间隔以及第一个item的origin
        CGFloat totalWidth = self.bounds.size.width;
        CGFloat totalHeight = self.bounds.size.height - kPageControlHeight;
        //横向空白间隔（不是item之间的间隔，是item中icon之间的空白区域的间隔）
        CGFloat whiteSpaceH = (totalWidth - kIconWidth * mColumnCount) / (mColumnCount + 1);
        
        CGFloat itemSpaceH = whiteSpaceH - (kItemWidth - kIconWidth);
        CGFloat itemSpaceV = (totalHeight - kItemHeight * mRowCount) / (mRowCount + 1);
        
        //计算出第一个item的origin
        CGFloat firstItemX = whiteSpaceH;
        CGFloat firstItemY = itemSpaceV;
        
        for (int i = 0; i < _totalPage; i++) {
            //每一页的Frame数组
            NSMutableArray *pageFrameArray = [NSMutableArray array];
            _itemFrameArray[i] = pageFrameArray;
            for (int r = 0; r < mRowCount; r++) {
                for (int c = 0; c < mColumnCount; c++) {
                    CGFloat itemX = firstItemX + (kItemWidth + itemSpaceH) * c + totalWidth * i;
                    CGFloat itemY = firstItemY + (kItemHeight + itemSpaceV) * r;
                    NSValue *frameValue = [NSValue valueWithCGRect:CGRectMake(itemX, itemY, kItemWidth, kItemHeight)];
                    [pageFrameArray addObject:frameValue];
                }
            }
        }
    }
}

- (void)updateCustomSpaceItemsFrame {
    if (_itemFrameArray.count == 0) {
        //先计算出间隔以及第一个item的中线点坐标
        CGFloat totalWidth = self.bounds.size.width;
        CGFloat totalHeight = self.bounds.size.height;
        
        //计算出第一个item的中心点坐标
        CGFloat firstItemX = (totalWidth - kItemWidth * mColumnCount -
                                    kHorizontalSpace *(mColumnCount - 1)) / 2;
        CGFloat firstItemY = (totalHeight - kItemHeight * mRowCount -
                                    kVerticalSpace *(mRowCount - 1)) / 2;
        
        
        for (int i = 0; i < _totalPage; i++) {
            //每一页的坐标数组
            NSMutableArray *pageFrameArray = [NSMutableArray array];
            _itemFrameArray[i] = pageFrameArray;
            for (int r = 0; r < mRowCount; r++) {
                for (int c = 0; c < mColumnCount; c++) {
                    CGFloat itemX = firstItemX + (kItemWidth + kHorizontalSpace) * c + totalWidth * i;
                    CGFloat itemY = firstItemY + (kItemHeight + kVerticalSpace) * r;
                    NSValue *frameValue = [NSValue valueWithCGRect:CGRectMake(itemX, itemY, kItemWidth, kItemHeight)];
                    [pageFrameArray addObject:frameValue];
                }
            }
        }
    }
}

#pragma mark ##########################手势相关###################################
#pragma mark 长按手势
/**
 * 长按手势触发方法
 */
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture {
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
            [self handleLongPressBegan:longPressGesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self handleLongPressChange:longPressGesture];
            break;
        case UIGestureRecognizerStateEnded:
            [self handleLongPressEnd:longPressGesture];
            break;
            
        default:
            break;
    }
}

- (void)handleLongPressBegan:(UILongPressGestureRecognizer *)longPressGesture {
    CGPoint location = [longPressGesture locationInView:self];
    _heldItemView = [self itemViewAtGestureLocation:location];
    //如果获取到的itemView不为空的话即长按了一个itemView， 开始编辑模式
    if (_heldItemView) {
        //计算长按位置与长按itemView中心点的偏移量
        _deltaX = location.x - _heldItemView.center.x;
        _deltaY = location.y - _heldItemView.center.y;
        
        [self heldItemViewAnimation];
    }
    NSLog(@"location.x=%f, y=%f, item=%@", location.x, location.y, _heldItemView);
}

- (void)handleLongPressChange:(UILongPressGestureRecognizer *)longPressGesture {
    if (_heldItemView) {
        CGPoint location = [longPressGesture locationInView:self];
        _heldItemView.center = CGPointMake(location.x - _deltaX, location.y - _deltaY);

        [self checkRect];
    }
}

- (void)handleLongPressEnd:(UILongPressGestureRecognizer *)longPressGeusture {
    [self dropItemViewAnimation];
}


/**
 * 对移动的itemView位置进行判断,交换位置或者成为文件夹等
 */
- (void)checkRect {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ItemView *belowItemView = [self itemViewAtPoint:_heldItemView.center];
        if (belowItemView && ![belowItemView isEqual:_heldItemView]) {
            NSLog(@"%@, %d,%d",belowItemView, belowItemView.appModel.page, belowItemView.appModel.position);
        }
    });
}


/**
 *  对长按的itemView处理一些动画
 */
- (void)heldItemViewAnimation {
    //使长按的itemView变成最上层，而不被其他itemView遮挡
    [_heldItemView.superview bringSubviewToFront:_heldItemView];
    
    //放大一点点以及增加一点透明度
    [UIView animateWithDuration:0.2 animations:^{
        _heldItemView.alpha = 0.6;
        _heldItemView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }];
}

/**
 *  放开长按的itemView处理的一些基本动画
 */
- (void)dropItemViewAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        _heldItemView.alpha = 1;
        _heldItemView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    //移动到改变的位置上
    [UIView animateWithDuration:0.3 animations:^{
        _heldItemView.frame = [_itemFrameArray[_heldItemView.appModel.page][_heldItemView.appModel.position] CGRectValue];
    }];
}



#pragma mark ##########################代理方法###################################
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSLog(@"%d", _currentPage);
}




#pragma mark ##########################通用方法###################################
/**
 *  获取手势中心点上的itemView,以self 为坐标系
 *
 *  @param  需要获取的点
 *  @return 当前点上的itemView
 */
- (ItemView *)itemViewAtGestureLocation:(CGPoint) location {
    NSMutableArray *pageItemViewArray = _itemViewArray[_currentPage];
    NSMutableArray *pageFrameArray = _itemFrameArray[_currentPage];
    for (ItemView *itemView in pageItemViewArray) {
        CGRect convertRect = [self convertRect:[pageFrameArray[itemView.appModel.position] CGRectValue]
                                      fromView:_scrollView];
        if (CGRectContainsPoint(convertRect, location)) {
            return itemView;
        }
    }
    return nil;
}


/**
 * 获取当前位置点上的itemView,以scrollview为坐标系
 */
- (ItemView *)itemViewAtPoint:(CGPoint) point {
    NSMutableArray *pageItemViewArray = _itemViewArray[_currentPage];
    NSMutableArray *pageFrameArray = _itemFrameArray[_currentPage];
    for (ItemView *itemView in pageItemViewArray) {
        if (CGRectContainsPoint([pageFrameArray[itemView.appModel.position] CGRectValue], point)) {
            return itemView;
        }
    }
    return nil;
}


+ (int)columnCount {
    return 3;
}

+ (int)rowCount {
    return 3;
}

@end
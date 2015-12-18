//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//

#define mBackgroundImage    [UIImage imageNamed:@"main_bg"]
#define mColumnCount        [SpringboardView columnCount]
#define mRowCount           [SpringboardView rowCount]

#define kIsEqualSpaceStyle NO       //是否每个item间隔为平均分配的风格, 改为NO时需设置间距大小

#define kItemWidth         80
#define kItemHeight        80
#define kPageControlHeight 40

#define kHorizontalSpace 10
#define kVerticalSpace   10

@class ItemView;

@interface SpringboardView : UIView <UIScrollViewDelegate> {
    //UI
    UIImageView     *_bgImageView;
    UIScrollView    *_scrollView;
    UIPageControl   *_pageControl;
    
    UILongPressGestureRecognizer *_longPressGesture;    //长按手势，进入编辑状态
    UITapGestureRecognizer       *_tapGesture;          //单击手势，取消编辑状态
    UITapGestureRecognizer       *_addGesture;          //单击手势，新增应用
    
    ItemView *_heldItemView;                //长按住的itemView
    
    

    //DATA
    NSMutableArray *_itemFrameArray;       //item位置坐标集合
    NSMutableArray *_itemViewArray;         //itemView集合

    int _totalPage;                         //总页数
    int _currentPage;                       //当前页
    
    CGFloat _deltaX;                         //长按item时手指与item中心点的x轴偏移量
    CGFloat _deltaY;                         //长按item时手指与item中心点的y轴偏移量
}

@property (strong, nonatomic) NSMutableArray *itemModelArray;




/**
 * 更新了数据后重新加载页面
 */
//- (void)reloadData;

/**
 * 获取列数与行数
 */
+ (int)columnCount;
+ (int)rowCount;

@end
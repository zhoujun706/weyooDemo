//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//

#define mBackgroundImage [UIImage imageNamed:@"springboard_bg"]
#define mColumnCount [SpringboardView columnCount]
#define mRowCount [SpringboardView rowCount]

#define kItemWidth 80
#define kItemHeight 80

#define kIsEqualSpaceStyle NO       //是否每个item间隔为平均分配的风格


@interface SpringboardView : UIView <UIScrollViewDelegate> {
    //UI
    UIImageView *_bgImageView;
    UIScrollView *_scrollView;

    //DATA
    NSMutableArray *_itemCenterArray;       //item位置坐标集合
    NSMutableArray *_itemViewArray;         //itemView集合

}

@property (strong, nonatomic) NSMutableArray *itemModelArray;




/**
 * 更新了数据后重新加载页面
 */
- (void)reloadData;

/**
 * 获取列数与行数
 */
+ (int)columnCount;
+ (int)rowCount;

@end
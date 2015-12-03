//
//  HorizontalFlowLayout.h
//  h5
//
//  Created by 邹俊 on 15/10/29.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//
/**
 * CollectionViewLayout for an horizontal flow type:
 *
 *  |   0   1   |   6   7   |
 *  |   2   3   |   8   9   |   ----> etc...
 *  |   4   5   |   10  11  |
 *
 * Only supports 1 section and no headers, footers or decorator views.
 */

#define kColumnCount 3
#define kRowCount 3

#import <UIKit/UIKit.h>

@interface HorizontalFlowLayout : UICollectionViewLayout

@property (assign, nonatomic) int columnCount, rowCount;        //行数与列数
@property (assign, nonatomic) float spaceH, spaceV;             //水平间距,垂直间距
@property (assign, nonatomic) CGSize itemSize;                  //cell的大小


@end

//
//  HorizontalFlowLayout.m
//  h5
//
//  Created by 邹俊 on 15/10/29.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import "HorizontalFlowLayout.h"

@implementation HorizontalFlowLayout {
    NSInteger _cellCount;
    CGSize _boundsSize;
}

- (void)prepareLayout
{
    // Get the number of cells and the bounds size
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _boundsSize = self.collectionView.bounds.size;

    //行列默认都为3
    _columnCount = _columnCount?:kColumnCount;
    _rowCount = _rowCount?:kRowCount;

    //cell 的大小
    _itemSize = CGSizeMake(90, 90);

    //间隔
    _spaceH = 1;
    _spaceV = 15;
}

- (CGSize)collectionViewContentSize
{
    // We should return the content size. Lets do some math:

    NSInteger itemsPerPage = _columnCount * _rowCount;
    NSInteger numberOfItems = _cellCount;
    NSInteger numberOfPages = (NSInteger)ceilf((CGFloat)numberOfItems / (CGFloat)itemsPerPage);

    CGSize size = _boundsSize;
    size.width = numberOfPages * _boundsSize.width;
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // This method requires to return the attributes of those cells that intsersect with the given rect.
    // In this implementation we just return all the attributes.
    // In a better implementation we could compute only those attributes that intersect with the given rect.

    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:_cellCount];

    for (NSUInteger i=0; i<_cellCount; ++i)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self _layoutForAttributesForCellAtIndexPath:indexPath];

        [allAttributes addObject:attr];
    }

    return allAttributes;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self _layoutForAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    // We should do some math here, but we are lazy.
    return YES;
}

- (UICollectionViewLayoutAttributes*)_layoutForAttributesForCellAtIndexPath:(NSIndexPath*)indexPath
{
    // Here we have the magic of the layout.

    NSInteger row = indexPath.row;

    CGRect bounds = self.collectionView.bounds;
    CGSize itemSize = self.itemSize;

    // Get some info:
    NSInteger itemsPerPage = _columnCount * _rowCount;

    // Compute the column & row position, as well as the page of the cell.
    NSInteger columnPosition = row%_columnCount;
    NSInteger rowPosition = (row/_columnCount)%_rowCount;
    NSInteger itemPage = (NSInteger) floorf(row/itemsPerPage);

    // Creating an empty attribute
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGRect frame = CGRectZero;

    // And finally, we assign the positions of the cells
    float firstRowCellX = (bounds.size.width - _itemSize.width*_columnCount - _spaceH*(_columnCount-1)) / 2;
    float firstRowCellY = (bounds.size.height - _itemSize.height*_rowCount - _spaceV*(_rowCount-1)) / 2;
    frame.origin.x = itemPage * bounds.size.width + firstRowCellX + columnPosition * (itemSize.width + _spaceH);
    frame.origin.y = firstRowCellY + rowPosition * (itemSize.height + _spaceV);
    frame.size = _itemSize;

    attr.frame = frame;

    return attr;
}



@end

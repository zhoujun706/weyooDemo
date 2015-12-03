//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//



@interface SpringboardView : UIView

@property (assign, nonatomic) CGSize itemSize;
@property (assign, nonatomic) int columnCount;
@property (assign, nonatomic) int rowCount;

@property (strong, nonatomic) UIImage *backgroundImage;

@end
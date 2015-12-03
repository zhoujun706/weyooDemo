//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//

#define mBgImage [UIImage imageNamed:@"springboard_bg"]


#import "SpringboardView.h"


@implementation SpringboardView {
    //UI
    UIImageView *_bgImageView;

}


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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViews];
    }
    return self;
}

/**
 * 初始化各试图
 */
- (void)initViews {

}

@end
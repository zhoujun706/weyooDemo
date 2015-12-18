//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//

#import "ItemView.h"


@implementation ItemView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];

        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor yellowColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:24];
        label.tag = 10000;
        [self addSubview:label];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    UILabel *label = (UILabel *)[self viewWithTag:10000];
    label.frame = rect;
    label.text = [NSString stringWithFormat:@"%d, %d", _appModel.page, _appModel.position];
}



#pragma mark #########################文件夹相关##############################
/**
 * 当前应用的视图变成文件夹视图
 */
- (void)becomeFolder {

}

/**
 * 使当前应用视图增加另一个应用视图,从而变成一个文件夹
 */
- (void)addSubItemWithModel:(AppModel *)appModel {

}

@end
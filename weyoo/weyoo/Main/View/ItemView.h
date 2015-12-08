//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//

typedef NS_ENUM(NSInteger, ItemViewType) {
    ItemViewTypeApp,
    ItemViewTypeFolder
};

@interface ItemView : UIView {
    
}

//数据 (单个app)
@property (strong, nonatomic) AppModel *appModel;
@property (assign, nonatomic) ItemViewType itemViewType;

//数据 (文件)
@property (strong, nonatomic) NSMutableArray *appModels;

//UI



@end
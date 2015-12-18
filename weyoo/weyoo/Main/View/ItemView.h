//
// Created by 邹俊 on 15/12/1.
// Copyright (c) 2015 尚娱网络. All rights reserved.
//

#define kIconWidth 60
#define kIconHeight 60

typedef NS_ENUM(NSInteger, ItemViewType) {
    ItemViewTypeApp,
    ItemViewTypeFolder
};

@interface ItemView : UIView {
    
}

//数据 (单个app)
@property (strong, nonatomic) AppModel      *appModel;
@property (assign, nonatomic) ItemViewType  itemViewType;

//数据 (文件)
@property (strong, nonatomic) NSMutableArray *appModels;

//UI
@property (strong, nonatomic) UIImageView   *folderBorderImageView;         //处理变成文件夹的边框动画
@property (strong, nonatomic) UIImageView   *iconImageView;
@property (strong, nonatomic) UILabel       *titleLabel;
@property (strong, nonatomic) UIButton      *deleteButton;

//UI







#pragma mark #########################文件夹相关##############################
/**
 * 当前应用的视图变成文件夹视图
 */
- (void)becomeFolder;

/**
 * 使当前应用视图增加另一个应用视图,从而变成一个文件夹
 */
- (void)addSubItemWithModel:(AppModel *)appModel;



@end
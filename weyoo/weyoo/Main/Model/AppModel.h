//
//  AppModel.h
//  weyoo
//
//  Created by 邹俊 on 15/11/19.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import "DatabaseModel.h"

@interface AppModel : DatabaseModel

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *appIconUrl;
@property (strong, nonatomic) NSData   *appIconData;
@property (strong, nonatomic) NSString *appTitle;
@property (strong, nonatomic) NSString *appUrl;
@property (strong, nonatomic) NSString *appCategory;
@property (strong, nonatomic) NSString *appSize;

@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger position;

@property (assign, nonatomic) NSUInteger isFolder;


/** 查找在当前设备下放置所有应用的页数*/
//+ (int)findTotalPage;

/** 查找当前页的数据*/
+ (NSArray *)findAppModelsFromPage:(int)page;

/** 读取所有应用的id*/
//+ (NSString *)findAllAppIds;


@end

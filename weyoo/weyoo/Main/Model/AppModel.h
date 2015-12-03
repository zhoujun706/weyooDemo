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
@property (strong, nonatomic) NSString *appTitle;

@end

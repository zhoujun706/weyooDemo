//
//  DatabaseInstance.h
//  weyoo
//
//  Created by 邹俊 on 15/11/19.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

//数据库文件路径
#define DB_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.db"]

@interface DatabaseInstance : NSObject

@property (strong, nonatomic) FMDatabaseQueue *databaseQueue;

+ (DatabaseInstance *) getInstance;

@end

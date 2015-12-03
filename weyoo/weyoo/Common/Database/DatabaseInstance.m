//
//  DatabaseInstance.m
//  weyoo
//
//  Created by 邹俊 on 15/11/19.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import "DatabaseInstance.h"

@implementation DatabaseInstance

+ (DatabaseInstance *)getInstance {
    static DatabaseInstance *databaseInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseInstance = [[self alloc] init];
    });
    return databaseInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _databaseQueue = [[FMDatabaseQueue alloc] initWithPath:DB_PATH];
    }
    return self;
}


@end

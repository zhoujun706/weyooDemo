//
//  NetworkInstance.m
//  weyoo
//
//  Created by 邹俊 on 15/11/20.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import "NetworkInstance.h"

@implementation NetworkInstance

- (instancetype) init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}

+ (NetworkInstance *)getInstance {
    static NetworkInstance *networkInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkInstance = [[self alloc] init];
    });
    return networkInstance;
}


#pragma mark - 接口请求
//get请求
- (void)get:(NSString*)urlString
     params:(NSDictionary *)params
    success:(void (^)(id data))success
    failure:(void(^)(NSURLSessionDataTask *task)) failure {
    if (!mNetworkReachable) {
        NSLog(@"网络未连接");
        return;
    }
    [_manager GET:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task);
    }];
}
//post请求
- (void)post:(NSString*)urlString
      params:(NSDictionary *)params
     success:(void (^)(id data))success
     failure:(void(^)(NSURLSessionDataTask *task)) failure {
    if (!mNetworkReachable) {
        NSLog(@"网络未连接");
        return;
    }
    [_manager POST:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task);
    }];
}
//get请求
- (void)getWithParams:(NSDictionary *)params success:(void (^)(id data))success {
    [self get:kServiceUrl params:params success:success failure:nil];
}
- (void)getWithParams:(NSDictionary *)params
              success:(void (^)(id data))success
              failure:(void(^)(NSURLSessionDataTask *task)) failure {
    [self get:kServiceUrl params:params success:success failure:failure];
}
//post请求
- (void)postWithParams:(NSDictionary *)params success:(void (^)(id data))success {
    [self post:kServiceUrl params:params success:success failure:nil];
}
- (void)postWithParams:(NSDictionary *)params
               success:(void (^)(id data))success
               failure:(void(^)(NSURLSessionDataTask *task)) failure {
    [self post:kServiceUrl params:params success:success failure:failure];
}



@end

//
//  NetworkInstance.h
//  weyoo
//
//  Created by 邹俊 on 15/11/20.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkInstance : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *manager;



//网络请求--------------------------------------------------------------------------
//get请求
- (void)get:(NSString*)urlString
     params:(NSDictionary *)params
    success:(void (^)(id data))success
    failure:(void(^)(NSURLSessionDataTask *task)) failure;
//post请求
- (void)post:(NSString*)urlString
      params:(NSDictionary *)params
     success:(void (^)(id data))success
     failure:(void(^)(NSURLSessionDataTask *task)) failure;
//get请求
- (void)getWithParams:(NSDictionary *)params success:(void (^)(id data))success;
- (void)getWithParams:(NSDictionary *)params
              success:(void (^)(id data))success
              failure:(void(^)(NSURLSessionDataTask *task)) failure;
//post请求
- (void)postWithParams:(NSDictionary *)params success:(void (^)(id data))success;
- (void)postWithParams:(NSDictionary *)params
               success:(void (^)(id data))success
               failure:(void(^)(NSURLSessionDataTask *task)) failure;

@end

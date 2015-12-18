//
//  AppModel.m
//  weyoo
//
//  Created by 邹俊 on 15/11/19.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import "AppModel.h"
#import "SpringboardView.h"

@implementation AppModel



+ (NSArray *)findAppModelsFromPage:(int)page {
    NSString *criteria = [NSString stringWithFormat:@"where page=%d", page];
    return [self findByCriteria:criteria];
}

@end

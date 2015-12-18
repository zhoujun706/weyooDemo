//
//  AppDelegate.m
//  weyoo
//
//  Created by 邹俊 on 15/11/16.
//  Copyright © 2015年 尚娱网络. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)addTestData {
    AppModel *appModel1 = [[AppModel alloc] init];
    appModel1.appId = @"684";
    appModel1.appIconUrl = @"http://www.weyoo.com.cn/www/upload/site/1443173025664.png";
    appModel1.appTitle = @"百度";
    appModel1.appUrl = @"http://m.baidu.com?from=1010751a";
    appModel1.appCategory = @"装机必备";
    appModel1.appSize = @"88";
    appModel1.page = 0;
    appModel1.position = 0;
    [appModel1 save];

    AppModel *appModel2 = [[AppModel alloc] init];
    appModel2.appId = @"2446";
    appModel2.appIconUrl = @"http://www.weyoo.com.cn/www/upload/site/1436424217237.png";
    appModel2.appTitle = @"僵尸围城";
    appModel2.appUrl = @"http://jswc.egret-labs.org/zombie/?platInfo=open_228_18323";
    appModel2.appCategory = @"策略塔防";
    appModel2.appSize = @"39.8";
    appModel2.page = 0;
    appModel2.position = 1;
    [appModel2 save];

    AppModel *appModel3 = [[AppModel alloc] init];
    appModel3.appId = @"1029";
    appModel3.appIconUrl = @"http://a5.mzstatic.com/us/r30/Purple5/v4/9e/b0/a7/9eb0a7bd-4398-d7e4-793d-ab3f17d2f6af/icon175x175.png";
    appModel3.appTitle = @"淘宝";
    appModel3.appUrl = @"https://m.taobao.com/?sprefer=sypc00#index";
    appModel3.appCategory = @"装机必备";
    appModel3.appSize = @"97";
    appModel3.page = 0;
    appModel3.position = 2;
    [appModel3 save];

    AppModel *appModel4 = [[AppModel alloc] init];
    appModel4.appId = @"3010";
    appModel4.appIconUrl = @"http://www.weyoo.com.cn/www/upload/site/1444707018544.png";
    appModel4.appTitle = @"微用汽车";
    appModel4.appUrl = @"https://wyqc.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.5WzCTh&amp;user_number_id=2653557133&amp;rn=9113d7386524c8d846def3085fb379c9";
    appModel4.appCategory = @"购物·特价";
    appModel4.appSize = @"14";
    appModel4.page = 1;
    appModel4.position = 0;
    [appModel4 save];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self addTestData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  MacroDefine.h
//  weyoo
//
//  Created by 邹俊 on 15/11/19.
//  Copyright © 2015年 尚娱网络. All rights reserved.

//  开发中常用到的宏定义

#ifndef MacroDefine_h
#define MacroDefine_h

/*================================需要经常修改＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝*/
//版本号，每次新版需要修改该值，用于与服务器进行版本比较
#define kVersionCode 23
#define kVersion @"V 1.3.0"

//渠道
#define kTalkingDataChannel         @"appstore"
//小包名
#define kSmallBagType               @""

/*--------------------------------API------------------------------------------------------*/
//API请求地址
#define kServiceUrl              @"http://api.weyoo.com.cn/service"

//添加应用到桌面
#define kAddAppToDock(appId,siteUrl)     [NSString stringWithFormat:@"http://www.weyoo.com.cn/as/adhome?appId=%@&url=%@", appId, siteUrl]

//关于微用
#define kAboutWeyooUrl       @"http://api.weyoo.com.cn/www/about.html"

//市场地址
#define kAppStoreUrl              [NSString stringWithFormat:@"http://api.weyoo.com.cn/www/appv2/appCenter.html?b=%@&v=%d&c=%@" , kSmallBagType, kVersionCode, kTalkingDataChannel]

//游戏地址
#define kGameUrl              [NSString stringWithFormat:@"http://api.weyoo.com.cn/www/appv2/gameCenter.html?c=%@&b=%@&v=%d",kTalkingDataChannel, kSmallBagType, kVersionCode]

//广告地址
#define kAdUrl(appid)    [NSString stringWithFormat:@"http://api.weyoo.com.cn/www/ads/wapp.html?appid=%@&c=%@&b=%@&v=%d&m=%d", appid,kTalkingDataChannel, kSmallBagType, kVersionCode, 1]



/*--------------------------------方法简写--------------------------------------------------*/

//DEBUG  模式下打印日志:文件名,行号,方法名,结果
#ifdef DEBUG
#define NSLog(format, ...) do {                                                                             \
                             fprintf(stderr, "----------------------\n<%s : %d>\n%s\n",                     \
                             [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],     \
                             __LINE__, __func__);                                                           \
                             (NSLog)((format), ##__VA_ARGS__);                                              \
                             fprintf(stderr, "----------------------\n");                                   \
                           } while (0)
#else
#define NSLog(format, ...) 
#endif

//获取appDelegate实例。
#define AppDelegateInstance ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]

//系统目录
#define mDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define mLibrary  [(NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)) firstObject]

//数据库文件路径
#define DB_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.db"]
//数据库操作对象
#define DBQUEUE [DatabaseInstance getInstance].databaseQueue

//网络操作对象
#define NETMANAGER [NetworkInstance getInstance]
//是否联网
#define mNetworkReachable [[Reachability reachabilityForInternetConnection] currentReachabilityStatus]

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;



//颜色转换
#define mRGBColor(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define mRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb颜色转换（16进制->10进制）
#define mRGBToColor(rgb)       [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]


//简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alert show];


//----------设备系统相关---------
#define mRetina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define mIsiP5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define mIsPad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define mIsiphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define mIos7     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


//----------页面设计相关-------
#define mStatusBarHeight      ([UIApplication sharedApplication].statusBarFrame.size.height)
#define mSlideBarHeight       40.0f
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)


#endif /* MacroDefine_h */

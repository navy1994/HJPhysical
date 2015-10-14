//
//  AppDelegate.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "AppDelegate.h"
#import "PhysicalTestViewController.h"
#import "HomeTestViewController.h"
#import <ShareSDK/ShareSDK.h>

//第三方平台的SDK头文件，根据需要的平台导入
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import <QZoneConnection/ISSQZoneApp.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.physicalViewController = [[HomeTestViewController alloc]init];
    self.physicalNavigationController = [[MGLNavigationController alloc]init];
    [self.physicalNavigationController pushViewController:_physicalViewController animated:YES];

    [self.window setRootViewController:_physicalNavigationController];
    [self.window makeKeyAndVisible];
    
    //分享
    [ShareSDK registerApp:@"8a5f9986ff8c"];
    
    // 应用开发地址 https://github.com/navy1994/iOS-demo.git
    // 添加微信应用  注册网址 https://open.weixin.qq.com/
    [ShareSDK connectWeChatWithAppId:@"wx80dd30db3b620b29"   //微信APPID
                           appSecret:@"11cd234330a3e201c0c4c2b578ebedda"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1104438766"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104438766"
                           appSecret:@"RJgZml2kAzUi88H4"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
        //添加腾讯微博应用 注册网址 http://dev.t.qq.com
        [ShareSDK connectTencentWeiboWithAppKey:@"801564407"
                                      appSecret:@"ff23c57e7429942a9642a9fa0df911d1"
                                    redirectUri:@"https://github.com/navy1994/iOS-demo.git"
                                       wbApiCls:[WeiboApi class]];
    
        //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台 http://open.weibo.com/apps/357809030/info/basic
        [ShareSDK  connectSinaWeiboWithAppKey:@"4079682763"
                                    appSecret:@"4a83fd558a47adac09033ec5875db2e8"
                                  redirectUri:@"https://github.com/navy1994/iOS-demo.git"];
    
    //连接短信分享
    [ShareSDK connectSMS];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
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

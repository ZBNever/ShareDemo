//
//  AppDelegate.m
//  分享测试
//
//  Created by ccpg_it on 2017/9/7.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate () 
{
    XMShareUtilManager *manager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化注册管理类
    manager = [XMShareUtilManager sharedInstance];
    //注册AppID 不需要的就传nil
    [manager registerWithQQAppID:APP_KEY_QQ WechatAppID:APP_KEY_WEIXIN WeiboAppID:APP_KEY_WEIBO AliPayAppID:APP_KEY_ALIPAY DingTalkAppID:APP_KEY_DINGTALK];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

   return [manager RegisterApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

    return [manager RegisterApplication:application handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

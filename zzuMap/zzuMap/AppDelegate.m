//
//  AppDelegate.m
//  zzuMap
//
//  Created by 李鹏飞 on 14-8-10.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "APIKey.h"
#import "UIColorAdditions.h"
#import "MainPageViewController.h"
#import "MainViewController.h"
#import "EmptyRoomViewController.h"
#import "SGPageViewController.h"
#import "NewsNoticeViewController.h"
#import "MoreViewController.h"

@implementation AppDelegate
@synthesize root;

#pragma mark -高德地图APIKey配置
/*
 *配置高德地图
 */
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *name   = [NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__];
        NSString *reason = [NSString stringWithFormat:@"请首先配置APIKey.h中的APIKey, 申请APIKey参考见 http://api.amap.com"];
        @throw [NSException exceptionWithName:name
                                       reason:reason
                                     userInfo:nil];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor  = [UIColor whiteColor];
    //执行配置高德地图
    [self configureAPIKey];
    
    //主页面
    MainPageViewController *mainPage=[[MainPageViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:mainPage];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end

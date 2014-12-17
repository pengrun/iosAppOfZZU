//
//  AppDelegate.h
//  zzuMap
//
//  Created by 李鹏飞 on 14-8-10.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BCTabBarController *root;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BCTabBarController *root;
@end

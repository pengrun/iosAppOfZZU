//
//  ZZUViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14-10-20.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"
@interface ZZUViewController : UIViewController<MBProgressHUDDelegate>
{
    
    id m_attrs;
    AppDelegate *appDelegate;
    UIButton *cancelBtn;//取消按钮
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) id m_attrs;

- (id)initWithAttributes:(id)_attributes;
//创建左侧按钮
-(void)createLeftItem:(NSString *)title font:(float)font  normalImage:(NSString *)normalImage highLightedImage:(NSString *)highLightedImage;
//左侧按钮绑定方法
-(void)leftItem;

//创建右侧按钮
-(void)createRightItem:(NSString *)title font:(float)font  normalImage:(NSString *)normalImage highLightedImage:(NSString *)highLightedImage;
//右侧按钮绑定方法
-(void)rightItem;

-(void)showLogin;
-(void)hiedeLogin;

-(void)startAnimation;
-(void)stopAnimation;
@end

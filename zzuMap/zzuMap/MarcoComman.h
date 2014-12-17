//
//  MarcoComman.h
//  healthManagement
//
//  Created by renqing on 13-10-17.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#ifndef ZZUAPP_MarcoComman_h
#define ZZUAPP_MarcoComman_h

//输出视图坐标
#define LOG_RECT(__OBJECT_VIEW) { NSLog(@"%g, %g, %g, %g", (__OBJECT_VIEW).frame.origin.x, (__OBJECT_VIEW).frame.origin.y, (__OBJECT_VIEW).frame.size.width, (__OBJECT_VIEW).frame.size.height); }
#endif

//====================================================
// 用途: 判断字符串是否为空
//====================================================
#define strIsEmpty(str) (str==nil || [str length]<1 ? YES : NO )

//====================================================
// 用途: color
//====================================================
#define RGBACOLOR(_r, _g, _b, _a) [UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:(_a)]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//====================================================
// 用途: 设备
//====================================================

#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
//====================================================
// 用途: image处理
//====================================================
#define TO_DAN_YE(__IMG_NAME) [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:(__IMG_NAME) ofType:@"png"]]]
#define IMG_Bendi(__IMG_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:(__IMG_NAME) ofType:@"png"]]
#define UMAPPKEY @"52c0d98756240b3070198642"


//===================================================
//用途：定义学习宝参数
//===================================================
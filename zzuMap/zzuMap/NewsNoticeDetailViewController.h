//
//  NewsNoticeDetailViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14-9-29.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface NewsNoticeDetailViewController : UIViewController
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,retain)NSString *urlString;
@property (nonatomic,retain)NSString *newsTitle;
@end

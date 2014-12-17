//
//  NewsNoticeDetailViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14-9-29.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "NewsNoticeDetailViewController.h"
#import "UIColorAdditions.h"

@interface NewsNoticeDetailViewController ()

@end

@implementation NewsNoticeDetailViewController
@synthesize urlString,newsTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /*
     *Web视图，显示所对应链接内容
     */
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 320, 568)];
    /*
     *标题   来显示所选得标题内容
     */
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(55, 25, 320-110, 40)];
    label.text=newsTitle;
    label.textColor=[UIColor colorWithHexString:@"25b3e3"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    
    /*
     *填充WebView
     */
    //NSString *newURL=@"http://115.28.230.185:8080/AppZZU/test1.html";
    NSString *newURL=urlString;
    NSURL *url=[NSURL URLWithString:newURL];
    NSURLRequest *rq=[NSURLRequest requestWithURL:url];
    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:rq];
    [self.view addSubview:self.webView];
    MyLog(@"newsDetail----------");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    
}
  

-(void)leftItem
{
    //默认为返回
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    [app.root setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

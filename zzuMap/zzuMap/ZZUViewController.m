//
//  ZZUViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14-10-20.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "ZZUViewController.h"
@interface ZZUViewController ()

@end

@implementation ZZUViewController
@synthesize m_attrs;

- (id)initWithAttributes:(id)_attributes {
    if (self = [super init])
    {
        
    }
    return self;
}

-(void)createLeftItem:(NSString *)title font:(float)font  normalImage:(NSString *)normalImage highLightedImage:(NSString *)highLightedImage
{
    
    UIButton* btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSwitch.frame=CGRectMake(0., 0., [UIImage imageNamed:normalImage].size.width, [UIImage imageNamed:normalImage].size.height);
    [btnSwitch setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btnSwitch setBackgroundImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
    [btnSwitch setTitle:title forState:UIControlStateNormal];
    [btnSwitch.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [btnSwitch addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lefrtItem = [[UIBarButtonItem alloc] initWithCustomView:btnSwitch];
    self.navigationItem.leftBarButtonItem = lefrtItem;
}

-(void)leftItem
{
    //默认为返回
    [appDelegate.root setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createRightItem:(NSString *)title font:(float)font  normalImage:(NSString *)normalImage highLightedImage:(NSString *)highLightedImage{
    
    UIButton* btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSwitch.frame=CGRectMake(0., 0., [UIImage imageNamed:normalImage].size.width+10, [UIImage imageNamed:normalImage].size.height+8);
    [btnSwitch setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btnSwitch setBackgroundImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
    [btnSwitch setTitle:title forState:UIControlStateNormal];
    [btnSwitch.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [btnSwitch addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnSwitch];
    self.navigationItem.rightBarButtonItem = rightItem;
}


-(void)rightItem
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}
-(void)startAnimation
{
    BOOL isExistenceNetwork=YES;
    Reachability* reach=[Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork=NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            break;
            
        default:
            break;
    }
    if (isExistenceNetwork)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载";
        [HUD show:YES];
    }else{
        UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败，请检查网络设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)stopAnimation
{
    [HUD removeFromSuperview];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

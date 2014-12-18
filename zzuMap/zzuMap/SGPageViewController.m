//
//  SGPageViewController.m
//  zzuMap
//
//  Created by apple on 14-9-21.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "SGPageViewController.h"
#import "AppDelegate.h"
#import "UIColorAdditions.h"
@interface SGPageViewController ()

@end

@implementation SGPageViewController
{
    AppDelegate *appdelegate;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate=[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden=YES;
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /*
     *标题 查成绩
     */
    UILabel *lbl_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    lbl_title.text=@"查成绩";
    lbl_title.textColor=[UIColor colorWithHexString:@"25b3e3"];
    lbl_title.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lbl_title];
    
   
    /*
     * 定义返回按钮
     */
    UIButton *btn_back=[[UIButton alloc]initWithFrame:CGRectMake(0, 25, 40, 40)];
    [btn_back setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_back];
    
    
    

    /*
     * 提示输入学号
     */
    UILabel *xuehao=[[UILabel alloc]initWithFrame:CGRectMake(10, 145-20, 70, 35)];
    xuehao.textAlignment=NSTextAlignmentCenter;
    xuehao.textColor=[UIColor blackColor];
    xuehao.text=@"学号:";
    [self.view addSubview:xuehao];
    
    /*
     * 提示输入密码
     */
    UILabel *mima=[[UILabel alloc]initWithFrame:CGRectMake(10, 190-10, 70, 35)];
    mima.textAlignment=NSTextAlignmentCenter;
    mima.textColor=[UIColor blackColor];
    mima.text=@"密码:";
    [self.view addSubview:mima];

    
    /*
     * 输入学号
     */
    xuehaoText=[[UITextField alloc]initWithFrame:CGRectMake(90, 145-20, 200, 35)];
    xuehaoText.borderStyle=UITextBorderStyleRoundedRect;
    xuehaoText.placeholder=@"请输入学号";
    xuehaoText.keyboardType=UIKeyboardTypeNumberPad;
    xuehaoText.textAlignment=NSTextAlignmentCenter;
    xuehaoText.clearButtonMode=YES;
    [self.view addSubview:xuehaoText];
    xuehaoText.delegate=self;
    
    /*
     * 输入密码
     */
    mimaText=[[UITextField alloc]initWithFrame:CGRectMake(90, 190-10, 200, 35)];
    mimaText.borderStyle=UITextBorderStyleRoundedRect;
    mimaText.placeholder=@"请输入密码";
    mimaText.keyboardType=UIKeyboardTypeDefault;
    mimaText.secureTextEntry=YES;
    mimaText.clearButtonMode=YES;
    mimaText.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:mimaText];
    mimaText.delegate=self;
    
    xuehaoText.text=@"20120510112";
    mimaText.text=@"junyu910";
    
    /*
     * 查询按钮
     */
    UIButton * btn_select=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_select.frame=CGRectMake(320/2-80/2, 230, 80, 35);
    [btn_select setTitle:@"查询" forState:UIControlStateNormal];
    btn_select.titleLabel.font=[UIFont systemFontOfSize:17];
    [btn_select  addTarget:self action:@selector(QDViod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_select];

}
-(void)leftItem
{
    //默认为返回
    [appdelegate.root setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark void

//代理方法--点击键盘后键盘消失的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

/*
 *方法--点击查询后的方法
 */
-(void)QDViod
{
    if ([xuehaoText.text length]>0&&mimaText.text>0)
    {

        NSString *nianji=[xuehaoText.text substringToIndex:4];
        MyLog(@"%@",mimaText.text);
        [xuehaoText resignFirstResponder];
        [mimaText resignFirstResponder];
        
        [self uploadRoomData:nianji xuehao:xuehaoText.text mima:mimaText.text];
    }else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入正确的学号和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//------------------------从服务器端请求数据
-(void)uploadRoomData:(NSString *)nianjiID xuehao:(NSString *)xuehao mima:(NSString *)mimaID
{
    [self startAnimation];
    [[ServiceBaseRequest sharedService] getGrade:nianjiID xuehao:xuehao mima:mimaID completionHandler:^(ServiceBaseResponse *response)
     {
         [self stopAnimation];
         NSMutableArray* KCNameArray=[NSMutableArray array];
         NSMutableArray* jidian=[NSMutableArray array];
         NSMutableArray* chengji=[NSMutableArray array];
         
         if ([response.retValue isKindOfClass:[NSDictionary class]])
         {
             //请求数据失败之后
             if ([[response.retValue objectForKey:@"response"] isEqualToString:@"0"])
             {
                 MyLog(@"请求数据失败，请输入正确的用户名和密码");
                 UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入正确的学号和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alertView show];
             }
             
             //请求数据成功
             if ([[response.retValue objectForKey:@"response"] isEqualToString:@"1"])
             {
                 NSArray *array=[response.retValue objectForKey:@"chengji"];
                 NSArray *urlarray=[response.retValue objectForKey:@"url"];
                 
                 NSMutableArray*  URLString=[NSMutableArray array];
                 
                 [KCNameArray removeAllObjects];
                 [URLString removeAllObjects];
                 
                 for (int i=0; i<array.count; i++)
                 {
                     NSDictionary* dic1=[array objectAtIndex:i];
                     [KCNameArray addObject:[dic1 objectForKey:@"课程"]];
                     [jidian addObject:[dic1 objectForKey:@"绩点"]];
                     [chengji addObject:[dic1 objectForKey:@"成绩"]];
                 }
                 for (int i=0; i<urlarray.count; i++)
                 {
                     NSDictionary* dic2=[urlarray objectAtIndex:i];
                     [URLString addObject:[dic2 objectForKey:@"urlDetail"]];
                 }

                 ChengjiResultViewController *cjVC=[[ChengjiResultViewController alloc]init];
                 cjVC.KCNameArray=KCNameArray;
                 cjVC.ChengjiArray=chengji;
                 cjVC.JidingArray=jidian;
                 [self.navigationController pushViewController:cjVC animated:NO];
             }
         }
     }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MoreViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/22.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "MoreViewController.h"
#import "AppDelegate.h"
#import "UMFeedbackViewController.h"
#import "UIColorAdditions.h"
#import "VisionsTestViewController.h"
#import "AboutUsViewController.h"
@interface MoreViewController ()
{
    AppDelegate *appdelegate;
    
}
@end

@implementation MoreViewController
@synthesize tableView;
- (NSString *)iconImageName
{
    return @"more_normal.png";
}

-(NSString *)labelName
{
    return @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"More";
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    label.text=@"More";
    label.textColor=[UIColor colorWithHexString:@"25b3e3"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(0, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    appdelegate =[UIApplication sharedApplication].delegate;
    /*
     *TableView 表视图
     */
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    tableView.scrollEnabled=NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    dataArray=[NSMutableArray arrayWithObjects:@"推荐给朋友",@"关于我们", nil];
    section2Array=[NSMutableArray arrayWithObjects:@"联系我们",@"版本检测", nil];
    
}
//secction的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//每个secction的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        
        return 2;
    }

    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"CellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.section==0)
    {
      cell.textLabel.text=[dataArray objectAtIndex:indexPath.row];
    }
    
    if (indexPath.section==1)
    {
        cell.textLabel.text=[section2Array objectAtIndex:indexPath.row];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                MyLog(@"000--000-推荐给朋友");
            }
                break;
            case 1:
            {
                MyLog(@"111--111-关于我们");
                AboutUsViewController *aboutUs_VC=[[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
                [self.navigationController pushViewController:aboutUs_VC animated:YES];
                
            }
                break;

            default:
                break;
        }
    }
    
    if (indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                MyLog(@"111-000-联系我们");
                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
                [self showNativeFeedbackWithAppkey:UMENG_APPKEY];
            }
                break;
            case 1:
            {
                MyLog(@"111-111-版本检测");
                VisionsTestViewController *visionsTest_VC=[[VisionsTestViewController alloc]initWithNibName:@"VisionsTestViewController" bundle:nil];
                [self.navigationController pushViewController:visionsTest_VC animated:YES];
            }
                break;
                
            default:
            break;
        }
    }
}
//反馈
- (void)showNativeFeedbackWithAppkey:(NSString *)appkey {
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = appkey;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentModalViewController:navigationController animated:YES];
}
 //默认为返回
-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

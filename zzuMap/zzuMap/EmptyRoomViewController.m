//
//  EmptyRoomViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14-8-13.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "EmptyRoomViewController.h"
#import "ServiceBaseRequest.h"
#import "ServiceBaseResponse.h"
#import "AppDelegate.h"
#import "EmptyRoomTableViewCell.h"
#import "UIColorAdditions.h"
@interface EmptyRoomViewController ()
{
    UIButton *bt1;
    UIButton *bt2;
    Boolean *isSelectClassRoom;
    Boolean *isSelectTime;
}
@end

@implementation EmptyRoomViewController
{
    AppDelegate *appdelegate;
}

- (NSString *)iconImageName
{
    return @"";
}
-(NSString *)labelName{
    return @"";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"查询空教室";
    
    //设置初始化参数
    string1=@"0";
    string2=@"南核心";
    string4=@"星期一";
    string3=@"1";
    compus=@"0";
    stringDisplay=@"新校区";
    
    appdelegate=[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden=YES;
    count=0;
    emptyRoomArray=[[NSMutableArray alloc]init];
    buildingDataArray=[[NSMutableArray alloc]init];
    capacityArray=[[NSMutableArray alloc]init];
    
    isSelectClassRoom=NO;
    isSelectTime=NO;
//界面
    UIImageView *imagVC=[[UIImageView alloc]init];
    imagVC.frame=self.view.frame;
    imagVC.image=[UIImage imageNamed:@"jiemian.png"];
    [self.view addSubview:imagVC];
    
//定义一个视图
    UIView *view = [[UIView alloc] init];
    //设置颜色和界面颜色相同
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"jiemian.png"]];
    
    

//定义一个表视图
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 150-20, 320, iPhone5?568-66-150:502-150-88) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.tableView.backgroundView addSubview:view];
    [self.tableView.backgroundView sendSubviewToBack:view];
    self.tableView.separatorColor=[UIColor lightGrayColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.alpha=1;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    /*
     *校区
     */
 
    campusArray=[[NSMutableArray alloc]initWithObjects:@"新区",@"北区",nil];
    
    /*
     *新校区建筑楼
     */
    newBuildingArray=[[NSMutableArray alloc]initWithObjects:@"南核心",@"北核心",@"材料学院",@"护理学院", @"化工学院",@"环境学院",@"生命科学学院",@"数学统计学院",@"物理工程学院",nil];
    /*
     *北校区建筑楼
     */
   oldBuildingArray=[[NSMutableArray alloc]initWithObjects:@"教学楼",@"水环楼",@"化工楼",@"南实训",@"北实训" ,nil];
    
    /*
     *课程节数
     */
    timeArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    /*
     *星期
     */
    weekArray=[[NSMutableArray alloc]initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
    
    /*
     *初始化是新校区
     */
    buildingDataArray=newBuildingArray;
    
    
    /*
     *标题显示图片
     */
    UIImage *image=[UIImage imageNamed:@"chajiaoshi"];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    imageView.frame=CGRectMake(320/2-image.size.width/2, 20, image.size.width, image.size.height);
    [self.view addSubview:imageView];
    
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    //定义教室按钮
    bt1=[[UIButton alloc]initWithFrame:CGRectMake(0, 64+15, 320/2, 40)];
    [bt1 setBackgroundColor:[UIColor colorWithHexString:@"25b3e3"]];
    [bt1 setTitle:@"教室" forState:UIControlStateNormal];
    [bt1 addTarget:self action:@selector(bt1Click:) forControlEvents:UIControlEventTouchUpInside];
    [bt1.layer setBorderColor:[UIColor colorWithHexString:@"25b3e3"].CGColor];//边框颜色
    [bt1.layer setBorderWidth:1.0f];
    [bt1.layer setCornerRadius:5.0f];
    [self.view addSubview:bt1];
    
    //定义课时按钮
    bt2=[[UIButton alloc]initWithFrame:CGRectMake(320/2, 64+15, 320/2, 40)];
    [bt2 setBackgroundColor:[UIColor colorWithHexString:@"25b3e3"]];
    [bt2 addTarget:self action:@selector(bt2Click) forControlEvents:UIControlEventTouchUpInside];
    [bt2 setTitle:@"课时" forState:UIControlStateNormal];
    [bt2.layer setBorderColor:[UIColor colorWithHexString:@"25b3e3"].CGColor];//边框颜色
    [bt2.layer setBorderWidth:1.0f];
    [bt2.layer setCornerRadius:5.0f];
    [self.view addSubview:bt2];

}

/*
 *读取当前处于星期几
 */
-(void)setWeekDay
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    MyLog(@"-----------weekday is %d",[comps weekday]);
    
    switch ([comps weekday])
    {
        case 1:
            string4=@"星期天";
            break;
        case 2:
            string4=@"星期一";
            break;
        case 3:
            string4=@"星期二";
            break;
        case 4:
            string4=@"星期三";
            break;
        case 5:
            string4=@"星期四";
            break;
        case 6:
            string4=@"星期五";
            break;
        case 7:
            string4=@"星期六";
            break;
        default:
            break;
    }
}
//-(void)createLeftItem:(NSString *)title font:(float)font  normalImage:(NSString *)normalImage highLightedImage:(NSString *)highLightedImage
//{
//    
//    UIButton* btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnSwitch.frame=CGRectMake(0., 20., [UIImage imageNamed:normalImage].size.width, [UIImage imageNamed:normalImage].size.height);
//    [btnSwitch setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
//    [btnSwitch setBackgroundImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
//    [btnSwitch setTitle:title forState:UIControlStateNormal];
//    [btnSwitch.titleLabel setFont:[UIFont systemFontOfSize:font]];
//    [btnSwitch addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *lefrtItem = [[UIBarButtonItem alloc] initWithCustomView:btnSwitch];
//    self.navigationItem.leftBarButtonItem = lefrtItem;
//}


/*
 *返回上一页
 */
-(void)leftItem
{
    [appdelegate.root setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *选教室的方法
 */
-(void)bt1Click:(id)sender
{
    
    [bt1 setBackgroundColor:[UIColor colorWithHexString:@"25b3e3"]];//设置按钮的以背景颜色
    
    //顶上数组的位置的确定
    CGPoint point = CGPointMake(bt1.frame.origin.x + bt1.frame.size.width/2,bt1.frame.origin.y+ bt1.frame.size.height-10);
    MyLog(@"%f,,,,,%f",bt1.frame.origin.x + bt1.frame.size.width/2,bt1.frame.origin.y + bt1.frame.size.height);
    popTable *pop = [[popTable alloc] initWithPoint:point titles:newBuildingArray];
    
    pop.selectRowAtIndex = ^(NSInteger index){
      [bt1 setTitle:[newBuildingArray objectAtIndex:index] forState:UIControlStateNormal];
      MyLog(@"-------------%d",index);
      buildingID=[newBuildingArray objectAtIndex:index];
      isSelectClassRoom=YES;
      if (isSelectTime==YES){
            [self uploadRoomData:buildingID  weekDayTime:weekDay section:sectionID
                          compus:compus];
        }
    };
        [pop show];
}

-(void)bt2Click
{
    CGPoint point = CGPointMake(bt2.frame.origin.x + bt2.frame.size.width/2,bt2.frame.origin.y+ bt2.frame.size.height-10);
    NSArray *keshiArray=@[@"1-2节",@"3-4节",@"5－6节",@"7-8节",@"9-10节",];
    popTable *pop = [[popTable alloc] initWithPoint:point titles:keshiArray];
    pop.selectRowAtIndex = ^(NSInteger index){
        [bt2 setTitle:[keshiArray objectAtIndex:index] forState:UIControlStateNormal];
        sectionID=[NSString stringWithFormat:@"%d",index+1];
        isSelectTime=YES;
        if (isSelectClassRoom==YES)
        {
            MyLog(@"-----buildingID is %@,  sectionID is %@",buildingID,sectionID);
            [self uploadRoomData:buildingID  weekDayTime:weekDay section:sectionID
                          compus:compus];
        }
    };
    [pop show];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return emptyRoomArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentity=@"emptyRoomCell";
    EmptyRoomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"EmptyRoomTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.emptyRoomLabel.textColor=[UIColor whiteColor];
    cell.CapacityLabel.textColor=[UIColor whiteColor];
    cell.emptyRoomLabel.text=[emptyRoomArray objectAtIndex:indexPath.row];
    cell.CapacityLabel.text=[capacityArray objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//从服务器端请求数据
-(void)uploadRoomData:(NSString *)buildingID  weekDayTime:(NSString *)weekDay section:(NSString *)sectionID compus:(NSString *)compus
{
//    NSString *compus=@"1";//校区类型
//    NSString *buildID=@"教学楼";//教学楼
//    NSString *weekDay=@"星期一";//星期
//    NSString *sectionID2=@"2";//节数
    
    string3=sectionID;
    string2=buildingID;
    [self startAnimation];
    [self setWeekDay];
    
    [[ServiceBaseRequest sharedService] getHealthCondition:string2 weekDayTime:string4 section:string3 compus:compus completionHandler:^(ServiceBaseResponse *response)
     {
         [self stopAnimation];
         if ([response.retValue isKindOfClass:[NSDictionary class]])
         {
             NSArray *array=[response.retValue objectForKey:@"roomInfo"];
             NSArray *capacityDataArray=[response.retValue objectForKey:@"Capacity"];
             [emptyRoomArray removeAllObjects];
             [capacityArray removeAllObjects];
             for (int i=0; i<array.count; i++)
             {
                 NSDictionary* dic1=[array objectAtIndex:i];
                 [emptyRoomArray addObject:[dic1 objectForKey:@"RoomName"]];
                  [capacityArray addObject:[dic1 objectForKey:@"Capacity"]];
             }
            
         }
         [self.tableView reloadData];
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
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
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
@end

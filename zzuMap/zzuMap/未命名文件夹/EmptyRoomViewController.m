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

#import "EmptyRoomTableViewCell.h"

@interface EmptyRoomViewController ()

@end

@implementation EmptyRoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"空教室查询";
    self.navigationController.navigationBarHidden=YES;
        string1=@"0";
        string2=@"南核心";
        string4=@"星期一";
        string3=@"1";
        compus=@"0";
        stringDisplay=@"新校区";
    
       count=0;
       emptyRoomArray=[[NSMutableArray alloc]init];
       buildingDataArray=[[NSMutableArray alloc]init];
       capacityArray=[[NSMutableArray alloc]init];
    
      selectedContent=@"请选择要查询的空教室"  ;
      //界面背景
     UIImageView *imagVC=[[UIImageView alloc]init];
    imagVC.frame=self.view.frame;
    imagVC.image=[UIImage imageNamed:@"jiemian.png"];
    [self.view addSubview:imagVC];
    

    //定义一个视图
    UIView *view = [[UIView alloc] init];
    
    
    //设置颜色和界面颜色相同
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"jiemian.png"]];
    
//坐上角"返回"的按钮
    
    UIButton *backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 25, 40, 40)];
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
 
    [backButton addTarget:self action:@selector(backButtonTarge) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:backButton];
    
//空教室显示
    UILabel *labelNoteLeft=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, 320/2, 30)];
    labelNoteLeft.textAlignment=NSTextAlignmentCenter;
    labelNoteLeft.text=@"空教室";
//容纳人数显示
    UILabel *labelNoteRight=[[UILabel alloc]initWithFrame:CGRectMake(320/2, 120, 320/2, 30)];
    labelNoteRight.textAlignment=NSTextAlignmentCenter;
    labelNoteRight.text=@"可容纳人数";
    
    [self.view addSubview:labelNoteLeft];
    [self.view addSubview:labelNoteRight];
//分割线
    UILabel *labelLine1=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, 320, 1)];
    labelLine1.backgroundColor=[UIColor grayColor];
    [self.view addSubview:labelLine1];
//定义一个表视图
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, 320, self.view.frame.size.height-150) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.tableView.backgroundView addSubview:view];
    [self.tableView.backgroundView sendSubviewToBack:view];
//定义选择器
    self.tableView.separatorColor=[UIColor lightGrayColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.alpha=1;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
//校区
    buildingArray=[[NSMutableArray alloc]initWithObjects:@"新区",@"北区",nil];
//哪个楼
   newBuildingArray=[[NSMutableArray alloc]initWithObjects:@"南核心",@"北核心",@"材料学院",@"护理学院", @"化工学院",@"环境学院",@"生命科学学院",@"数学统计学院",@"物理工程学院",nil];
    
   oldBuildingArray=[[NSMutableArray alloc]initWithObjects:@"教学楼",@"水环楼",@"化工楼",@"南实训",@"北实训" ,nil];
//第几节
    
    timeArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
//星期
    weekArray=[[NSMutableArray alloc]initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
//默认显示新校区
   
    buildingDataArray=newBuildingArray;
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 59, 300, 0.6)];
    [label1 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 60+40, 300, 0.6)];
    [label2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, 59, 0.6, 40)];
    [label3 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:label3];
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(310, 59, 0.6, 40)];
    [label4 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:label4];

//显示@"请选择要查询的空教室";
    buttonB=[[UIButton alloc]initWithFrame:CGRectMake(10, 60, 300, 40)];
    [buttonB setTitle:selectedContent forState:UIControlStateNormal];
    [buttonB setTitleColor:[UIColor colorWithRed:154 green:78 blue:232 alpha:1] forState:UIControlStateNormal];
    [buttonB addTarget:self action:@selector(chooseBuilding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonB];

//设置一个toolbar
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0,iPhone5?self.view.frame.size.height-150-35:310 , self.view.frame.size.width, 35)];
    NSLog(@"%f",self.view.frame.size.height-150-35);
    UIBarButtonItem *buton1=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(SelectCancel)];
    UIBarButtonItem *button02=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *picker1Button=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(SelectPicker1_OK)];
    NSMutableArray *itemArray=[[NSMutableArray alloc]init];
    [itemArray addObject:buton1];
    [itemArray addObject:button02];
    [itemArray addObject:picker1Button];
    [toolbar setItems:itemArray];
    toolbar.hidden=YES;
    [self.view addSubview:toolbar];
    
    pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0,iPhone5?self.view.frame.size.height-150:330, self.view.frame.size.width, 150)];
    pickerView.dataSource=self;
    pickerView.delegate=self;
    pickerView.backgroundColor=[UIColor grayColor];
    pickerView.hidden=YES;
    pickerView.showsSelectionIndicator=YES;
    pickerView.tag=100;
    [self.view addSubview:pickerView];
 
}
//pickerView样式
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *myView=nil;
    
    if (component==0) {
        myView =[[UILabel alloc]initWithFrame:CGRectMake(0, 403, 60, 80)];
        
    }
    if (component==1) {
       myView =[[UILabel alloc]initWithFrame:CGRectMake(0, 403, 150, 50)] ;
        
    }
    if (component==2) {
        myView =[[UILabel alloc]initWithFrame:CGRectMake(0, 403, 70, 50)] ;
    }
    if (component==3) {
        myView =[[UILabel alloc]initWithFrame:CGRectMake(0, 403, 40, 50)] ;
    }
    myView.textColor=[UIColor whiteColor];
    myView.font=[UIFont systemFontOfSize:18];
    myView.textAlignment= NSTextAlignmentCenter;
    myView.text=[self pickerView:pickerView titleForRow:row forComponent:component];

    
    
    return  myView;
}




//视图返回到根视图
-(void)backButtonTarge
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark -UIPickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return buildingArray.count;//校区
    }
    if (component==1)
    {
        return buildingDataArray.count;//楼
    }
    if (component==2)
    {
       
        return weekArray.count;//星期
    }
    if (component==3)
    {
         return timeArray.count;//节数
    }
    
    return 0;
}
//pickerView填充
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component==0)
    {
        return [buildingArray objectAtIndex:row];
    }
    if (component==1)
    {
        return [buildingDataArray objectAtIndex:row];
    }
    if (component==2)
    {
        return [weekArray objectAtIndex:row];
        
    }
    if (component==3)
    {
        return [timeArray objectAtIndex:row];
    }
    
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (row==0&&component==0)
    {
        buildingDataArray=newBuildingArray;
        string1=[buildingArray objectAtIndex:row];//校区，新区或者老区
        buildingID=[newBuildingIDArray objectAtIndex:row];
        
        compus=@"0";
        //设置显示默认值
        stringDisplay=@"新校区";
    }
    if (row==1&&component==0)
    {
        buildingDataArray=oldBuildingArray;
        string1=[buildingArray objectAtIndex:row];
        buildingID=[newBuildingIDArray objectAtIndex:row];
        compus=@"1";
        //设置显示默认值
        string2=@"教学楼";
        stringDisplay=@"北校区";
        
    }
    if (component==1)
    {
        string2=[buildingDataArray objectAtIndex:row];
        buildingID=[oldBuildingIDArray objectAtIndex:row];
            }
    if (component==2)
    {
        string4=[weekArray objectAtIndex:row];
        weekID=[weekArray objectAtIndex:row];
    }
    if (component==3)
    {
        string3=[timeArray objectAtIndex:row];
        sectionID=[timeArray objectAtIndex:row];

        
    }
    [pickerView reloadComponent:1];
    //在最上边显示选择的内容
    selectedContent=[NSString stringWithFormat:@"%@->%@->%@->%@",stringDisplay,string2,string4,string3];
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
    cell.emptyRoomLabel.text=[emptyRoomArray objectAtIndex:indexPath.row];
    cell.CapacityLabel.text=[capacityArray objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//确定按钮
-(void)chooseBuilding
{
    toolbar.hidden=NO;
    pickerView.hidden=NO;
    selectedContent=[NSString stringWithFormat:@"%@->%@->%@->%@",stringDisplay, string2,string4,string3];
}

//-(void)chooseTime
//{
//    toolbar.hidden=NO;
//    pickerView2.hidden=NO;
//}

-(void)SelectCancel
{
    pickerView.hidden=YES;
    pickerView.hidden=YES;
    toolbar.hidden=YES;
    
}

-(void)SelectPicker1_OK
{
    pickerView.hidden=YES;
    toolbar.hidden=YES;
    [buttonB setTitle:selectedContent forState:UIControlStateNormal];
    
    [self uploadRoomData:buildingID  weekDayTime:weekDay section:sectionID
     compus:compus];
    
}

//-(void)SelectedPicker2OK
//{
//    pickerView2.hidden=YES;
//    toolbar2.hidden=YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//点击确定后显示信息的

//从服务器端请求数据
-(void)uploadRoomData:(NSString *)buildingID  weekDayTime:(NSString *)weekDay section:(NSString *)sectionID compus:(NSString *)compus
{
//    NSString *compus=@"1";//校区类型
//    NSString *buildID=@"教学楼";//教学楼
//    NSString *weekDay=@"星期一";//星期
//    NSString *sectionID2=@"2";//节数
    [self startAnimation];
    
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

//
//  ChengjiResultViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/23.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "ChengjiResultViewController.h"
#import "UIColorAdditions.h"

@interface ChengjiResultViewController ()

@end

@implementation ChengjiResultViewController
@synthesize tableView,ChengjiArray,JidingArray,KCNameArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"成绩详情";
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    label.text=@"成绩详情";
    label.textColor=[UIColor colorWithHexString:@"25b3e3"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(20,70, 100, 25)];
    l1.text=@"课程名称";
    l1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:l1];
    
    UILabel *l2=[[UILabel alloc]initWithFrame:CGRectMake(215, 70, 40, 25)];
    l2.textAlignment=NSTextAlignmentCenter;
    l2.text=@"成绩";
    [self.view addSubview:l2];
    
    UILabel *l3=[[UILabel alloc]initWithFrame:CGRectMake(260, 70, 40, 25)];
    l3.text=@"绩点";
    l3.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:l3];
    
    
    /*
     *TableView
     */
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,100, 320, iPhone5?400:400-88) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
    
    
}

/*
 *TableView 行数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return KCNameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"cellID";
    ChengjiCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[ChengjiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.kechengLable.text=[KCNameArray objectAtIndex:indexPath.row];
    cell.jidianLabel.text=[JidingArray objectAtIndex:indexPath.row];
    cell.chengjiLabel.text=[ChengjiArray objectAtIndex:indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



@end

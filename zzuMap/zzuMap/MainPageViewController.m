//
//  MainPageViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14/11/14.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "MainPageViewController.h"
#import "NewsNoticeViewController.h"//新闻通告信息
#import "EmptyRoomViewController.h"//空教室查询
#import "SGPageViewController.h"//成绩查询
#import "JobViewController.h"//就业信息
#import "MainViewController.h"//地图导航
#import "MoreViewController.h"//更多
@interface MainPageViewController ()

@end

@implementation MainPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    /*
     *设置背景
     */
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"zzu.png"];
    [self.view addSubview:imageView];
    /*
     *设置滚动视图
     */
    scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    CGFloat width=scrollView.bounds.size.width;
    CGFloat height=scrollView.bounds.size.height;
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setBounces:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake(width, 2*height)];
    [scrollView setPagingEnabled:YES];
    [self.view addSubview:scrollView];
    
    
    
    //新闻按钮
    UIImage *newsImage=[UIImage imageNamed:@"news"];
    UIButton *btn_news=[[UIButton alloc]initWithFrame:CGRectMake(320/2-35, 80, 70, 70)];
    [btn_news setBackgroundImage:newsImage forState:UIControlStateNormal];
    btn_news.tag=10001;
    [btn_news addTarget:self action:@selector(BTClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_news];
    
    
    //查自习室按钮
    UIImage *roomImage=[UIImage imageNamed:@"room"];
    UIButton *btn_room=[[UIButton alloc]initWithFrame:CGRectMake(320/2-35, 220, 70, 70)];
    [btn_room setBackgroundImage:roomImage forState:UIControlStateNormal];
    btn_room.tag=10002;
    [btn_room addTarget:self action:@selector(BTClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_room];
    
    //查成绩按钮
    UIImage *gradeImage=[UIImage imageNamed:@"grade"];
    UIButton *btn_grade=[[UIButton alloc]initWithFrame:CGRectMake(320/2-35, 360, 70, 70)];
    [btn_grade setBackgroundImage:gradeImage forState:UIControlStateNormal];
    btn_grade.tag=10003;
    [btn_grade addTarget:self action:@selector(BTClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_grade];
    
    //招聘信息按钮
    UIImage *jobImage=[UIImage imageNamed:@"job"];
    UIButton *btn_job=[[UIButton alloc]initWithFrame:CGRectMake(320/2-35, height+80, 70, 70)];
    [btn_job setBackgroundImage:jobImage forState:UIControlStateNormal];
    btn_job.tag=10004;
    [btn_job addTarget:self action:@selector(BTClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_job];
    
    //地图按钮
    UIImage *mapImage=[UIImage imageNamed:@"map"];
    UIButton *b5=[[UIButton alloc]initWithFrame:CGRectMake(320/2-35, height+220, 70, 70)];
    [b5 setBackgroundImage:mapImage forState:UIControlStateNormal];
    b5.tag=10005;
    [b5 addTarget:self action:@selector(BTClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:b5];
    
    //关于我们按钮
    UIButton *btnAboutUs=[[UIButton alloc]initWithFrame:CGRectMake(320/2-35, height+360, 70, 70)];
    [btnAboutUs setBackgroundImage:roomImage forState:UIControlStateNormal];
    btnAboutUs.tag=10006;
    [btnAboutUs addTarget:self action:@selector(BTClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btnAboutUs];
    
}

-(void)BTClick:(UIButton *)button
{
    switch (button.tag){
            
        case 10001:
        {
            MyLog(@"新闻通告");
            NewsNoticeViewController *news=[[NewsNoticeViewController alloc]init];
                                            [self.navigationController pushViewController:news animated:YES];
            break;
        }

        case 10002:
        {
            MyLog(@"查询空教室");
            EmptyRoomViewController *empty=[[EmptyRoomViewController alloc]initWithNibName:@"EmptyRoomViewController" bundle:nil];
            [self.navigationController pushViewController:empty animated:YES];
        }
            break;
        
        case 10003:
        {
            MyLog(@"查询期末成绩");
            SGPageViewController *chengjiVC=[[SGPageViewController alloc]init];
            [self.navigationController pushViewController:chengjiVC animated:YES];
        }
            break;
            
        case 10004:
        {
            MyLog(@"查询招聘信息");
            JobViewController *job=[[JobViewController alloc]init];
            [self.navigationController pushViewController:job animated:YES];
        }
            break;
            
        case 10005:
        {
            MyLog(@"查询地图导航");
            MainViewController *mainVC=[[MainViewController alloc]init];
            [self.navigationController pushViewController:mainVC animated:YES];
        }
            break;
            
        case 10006:
        {
            MyLog(@"更多模块");
            MoreViewController *moreVC=[[MoreViewController alloc]init];
            [self.navigationController pushViewController:moreVC animated:YES];

            
        }
            break;
            
        default:
            break;
    }
}



#pragma mark -滚动视图代理方法
//完成减速意味着页面切换完成

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    int pageNumber=scrollView.contentOffset.y/568;
////    [self changeValue:pageNumber];
//    [pageControll setCurrentPage:pageNumber];
//}
//
//-(void)changeValue:(NSInteger )i
//{
//    NSLog(@"changeValue%d",i);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

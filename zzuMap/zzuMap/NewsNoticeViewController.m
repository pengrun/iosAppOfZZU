//
//  NewsNoticeViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14-9-29.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "NewsNoticeViewController.h"
#import "NewsNoticeDetailViewController.h"
#import "ServiceBaseRequest.h"
#import "ServiceBaseResponse.h"
#import "UIColorAdditions.h"

@interface NewsNoticeViewController ()
@end

@implementation NewsNoticeViewController

-(NSString *)labelName
{
    return @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     *设置返回图标效果 按下变颜色
     */
     //[self createLeftItem:@"" font:15 normalImage:@"back_normal.png" highLightedImage:@"back_pressed.png"];
    
    
    /*
     *定义新闻列表数组&&定义相对应的新闻链接数组
    */
    self.newsTitle=[NSMutableArray array];
    self.newsURL=[NSMutableArray array];
    
    //先刷新
    [self uploadNewsInformation];
    
    //界面
    self.view.backgroundColor=[UIColor clearColor];
    UIImageView *imagVC=[[UIImageView alloc]init];
    imagVC.frame=self.view.frame;
    imagVC.image=[UIImage imageNamed:@"zzu"];
    [self.view addSubview:imagVC];

    
    /*
     *设置分段的选项
     */
    NSArray *array=@[@"学院新闻",@"通知公告"];
    self.segment=[[UISegmentedControl alloc]initWithItems:array];
    self.segment.frame=CGRectMake(80, 66-44, 160, 45);
    self.segment.selectedSegmentIndex=0;
    [self.segment addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.segment setTintColor:[UIColor colorWithHexString:@"25b3e3"]];
    [self.navigationController.navigationItem.titleView addSubview:self.segment];
    [self.view addSubview:self.segment];
    
    /*
    *设置返回按钮
    */
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(5, 22, 50, 44)];
    [bt setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    /*
     *定义显示新闻内容表视图
     */
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,115-44, 320, iPhone5?568-120:568-120-88)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    /*
     *初始化设置刷新视图
     */
    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *egoView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height,320, self.tableView.bounds.size.height)];
        egoView.delegate = self;
        [self.tableView addSubview:egoView];
        _refreshHeaderView = egoView;
    }

    //  刷新数据
    [_refreshHeaderView refreshLastUpdatedDate];
    
    
    /*
     *手势滑动
     */
    UISwipeGestureRecognizer *swipe1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipe1 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:swipe1];
    
    UISwipeGestureRecognizer *swipe2=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipe2 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.tableView addGestureRecognizer:swipe2];
    
}
/*
 *手势滑动 方法；滑动切换视图
 */
-(void)swipe:(UISwipeGestureRecognizer *)swiper
{
    
    if (self.segment.selectedSegmentIndex==0&&UISwipeGestureRecognizerDirectionRight==swiper.direction)
    {
        MyLog(@"left");
        [UIView animateWithDuration:0.5f animations:^{
            [self.segment setSelectedSegmentIndex:1];
        }];
        [self changeValue:self.segment];
    }
    
    if (self.segment.selectedSegmentIndex==1&&UISwipeGestureRecognizerDirectionLeft==swiper.direction)
    {
        MyLog(@"");
        [UIView animateWithDuration:0.5f animations:^{
            [self.segment setSelectedSegmentIndex:0];
        }];
        [self changeValue:self.segment];
    }
    
}
/*
 *返回上一页
 */
-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -TableView

/*
 *根据标题数组的个数确定表视图多少行数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsTitle.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"cellID";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        //cell的字体
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        
        //一个cell的行数
        
        [cell.textLabel setNumberOfLines:2];
    }
    //设置选中行后效果风格
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    //填充cell
    cell.textLabel.text=[self.newsTitle objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationController.navigationBarHidden=NO;
     [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NewsNoticeDetailViewController *nnVC=[[NewsNoticeDetailViewController alloc]init];
                                          nnVC.urlString=[self.newsURL objectAtIndex:indexPath.row];
    nnVC.newsTitle=[self.newsTitle objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nnVC animated:YES];
}

/*
 *切换手势改变内容
 */
-(void)changeValue:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
        case 0:
        {
            [self.newsTitle removeAllObjects];
            [self.newsURL removeAllObjects];
            [self uploadNewsInformation];
        }
            break;
        case 1:
        {
            [self.newsTitle removeAllObjects];
            [self.newsURL removeAllObjects];
            [self uploadNoticeInformation];
        }
        default:
            break;
    }
}
/*
 *刷新获取《学院新闻》方法
 */
-(void)uploadNewsInformation
{
     [[ServiceBaseRequest sharedService] getNews:^(ServiceBaseResponse *response)
      {
          NSMutableArray *newsTime=[NSMutableArray array];
          if ([response.retValue isKindOfClass:[NSDictionary class]])
          {
              [self.newsTitle removeAllObjects];
              [self.newsURL removeAllObjects];
              NSArray *array=[response.retValue objectForKey:@"newsDetail"];
              for (int i=0; i<array.count; i++)
              {
                  NSDictionary* dic1=[array objectAtIndex:i];
                  [self.newsTitle addObject:[dic1 objectForKey:@"title"]];
                  [self.newsURL   addObject:[dic1 objectForKey:@"url"]];
                  [newsTime  addObject:[dic1 objectForKey:@"nTime"]];
              }
          }
          NSLog(@"-----%d",self.newsTitle.count);
          [self.tableView reloadData];
      }];
}
/*
 *刷新获取《通知公告》消息方法
 */
-(void)uploadNoticeInformation
{
    [[ServiceBaseRequest sharedService] getNotice:^(ServiceBaseResponse *response)
     {
         NSMutableArray *newsTime=[NSMutableArray array];
         if ([response.retValue isKindOfClass:[NSDictionary class]])
         {
             [self.newsTitle removeAllObjects];
             [self.newsURL removeAllObjects];
             NSArray *array=[response.retValue objectForKey:@"newsDetail"];
             for (int i=0; i<array.count; i++)
             {
                 NSDictionary* dic1=[array objectAtIndex:i];
                 [self.newsTitle addObject:[dic1 objectForKey:@"title"]];
                 [self.newsURL   addObject:[dic1 objectForKey:@"url"]];
                 [newsTime  addObject:[dic1 objectForKey:@"nTime"]];
             }
         }
         NSLog(@"-----%d",self.newsTitle.count);
         [self.tableView reloadData];
     }];
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods


/*
 *获取表数据
 */
- (void)reloadTableViewDataSource
{
  
  if (self.segment.selectedSegmentIndex==0)
    {
        [self uploadNewsInformation];
    }
    
    if (self.segment.selectedSegmentIndex==1)
    {
        [self uploadNoticeInformation];
    }
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData
{
        _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    
    return [NSDate date]; // should return date data source was last changed
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

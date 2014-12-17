//
//  JobViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/23.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "JobViewController.h"
#import "UIColorAdditions.h"
#import "ServiceBaseRequest.h"
#import "ServiceBaseResponse.h"

@interface JobViewController ()

@end

@implementation JobViewController
@synthesize segment,tableView;
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title=@"招聘信息";
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    label.text=@"就业信息";
    label.textColor=[UIColor colorWithHexString:@"25b3e3"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    
    self.navigationController.navigationBar.titleTextAttributes=dict;
    NSArray *array=@[@"校园招聘",@"事业单位信息",@"公务员信息"];
    self.segment=[[UISegmentedControl alloc]initWithItems:array];
    self.segment.frame=CGRectMake(320/2-250/2, 66, 250, 45);
    self.segment.selectedSegmentIndex=0;
    [self.segment addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.segment setTintColor:[UIColor colorWithHexString:@"25b3e3"]];
    [self.segment setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationItem.titleView addSubview:self.segment];
    [self.view addSubview:self.segment];
    
    self.newsTitle=[NSMutableArray array];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,111, 320, 568-111)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    if (_refreshHeaderView == nil)
    {
        
        EGORefreshTableHeaderView *egoView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height,320, self.tableView.bounds.size.height)];
        egoView.delegate = self;
        [self.tableView addSubview:egoView];
        _refreshHeaderView = egoView;
        
        NSLog(@" 0.0f - self.tableView.bounds.size.height--%f,%f,%f", 0.0f - self.tableView.bounds.size.height,self.view.frame.size.width,self.tableView.bounds.size.height);
        
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    [self uploadNoticeInformation];
    
    UISwipeGestureRecognizer *swipe1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipe1 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:swipe1];
    
    UISwipeGestureRecognizer *swipe2=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipe2 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.tableView addGestureRecognizer:swipe2];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
}
-(void)swipe:(UISwipeGestureRecognizer *)swiper
{
    //当segment的index值为0时
    if (self.segment.selectedSegmentIndex==0&&UISwipeGestureRecognizerDirectionRight==swiper.direction)
    {
        MyLog(@"left");
        [UIView animateWithDuration:0.5f animations:^{
            [self.segment setSelectedSegmentIndex:1];
        }];
        
        [self changeValue:self.segment];
    }
    
    //当segment的index值为1时，并且向左滑动时
    if (self.segment.selectedSegmentIndex==1&&UISwipeGestureRecognizerDirectionLeft==swiper.direction)
    {
        MyLog(@"");
        [UIView animateWithDuration:0.5f animations:^{
            [self.segment setSelectedSegmentIndex:0];
        }];
        [self changeValue:self.segment];
    }
    //当segment的index值为1时，并且向右滑动时
    if (self.segment.selectedSegmentIndex==1&&UISwipeGestureRecognizerDirectionRight==swiper.direction)
    {
        MyLog(@"向右滑动");
        [UIView animateWithDuration:0.5f animations:^{
            [self.segment setSelectedSegmentIndex:2];
        }];
        [self changeValue:self.segment];
    }
    //当segment的index值为2时，并且向左滑动时
    if (self.segment.selectedSegmentIndex==2&&UISwipeGestureRecognizerDirectionLeft==swiper.direction)
    {
        MyLog(@"");
        [UIView animateWithDuration:0.5f animations:^{
            [self.segment setSelectedSegmentIndex:1];
        }];
        [self changeValue:self.segment];
    }
    
}


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
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    //填充cell
    cell.textLabel.text=[self.newsTitle objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appdelegate=[UIApplication sharedApplication].delegate;
    [appdelegate.root setTabBarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden=YES;
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

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

- (void)reloadTableViewDataSource
{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
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
    
    //  model should call this when its done loading
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

//
//  MainViewController.m
//  zzuMapGD
//
//  Created by 李鹏飞 on 14-9-18.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "MainViewController.h"
#import "NorthViewController.h"
#import "BaseMapViewController.h"
#import "NewSectionViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation MainViewController
@synthesize mapView     = _mapView;
@synthesize search      = _search;

- (NSString *)iconImageName
{
    return @"day_normal.png";
}
-(NSString *)labelName
{
    return @"地图导航";
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
    appdelegate = [[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
//    [self createLeftItem:@"" font:15 normalImage:@"back_normal.png" highLightedImage:@"back_pressed.png"];
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    self.title=@"地图";
    [self initMapView];
}

-(void)leftItem
{
    [appdelegate.root setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)northBTClick:(id)sender
{
    [appdelegate.root setTabBarHidden:YES animated:NO];
    BaseMapViewController *northVC=[[NorthViewController alloc]init];
    
    northVC.mapView=self.mapView;
    northVC.search=self.search;
    
    [self.navigationController pushViewController:northVC animated:YES];
}

- (IBAction)newBTClick:(id)sender
{
    NewSectionViewController *newVC=[[NewSectionViewController alloc]init];
    newVC.mapView=self.mapView;
    
    [self.navigationController pushViewController:newVC animated:YES];
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.title =@"高德地图";
        /* 初始化search. */
        [self initSearch];
        
    }
    
    return self;
}


@end

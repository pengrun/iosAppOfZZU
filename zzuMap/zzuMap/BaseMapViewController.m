//
//  BaseMapViewController.m
//  zzuMapGD
//
//  Created by 李鹏飞 on 14-9-18.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "BaseMapViewController.h"


@interface BaseMapViewController ()

@end

@implementation BaseMapViewController
@synthesize mapView = _mapView;
@synthesize search  = _search;

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
    appdelegate = [[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBarHidden=NO;
    self.title=@"北校区";
    [self initTitle:self.title];
    [self initBaseNavigationBar];
    [self initSearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}

#pragma mark - Handle Action

- (void)returnAction
{
    self.navigationController.navigationBarHidden=NO;
    [appdelegate.root setTabBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
    
    [self clearSearch];
}

#pragma mark - AMapSearchDelegate

- (void)search:(id)searchRequest error:(NSString *)errInfo
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [searchRequest class], errInfo);
}

#pragma mark - Initialization

- (void)initMapView
{
    self.mapView.frame = self.view.bounds;
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.centerCoordinate=CLLocationCoordinate2DMake(34.782756,113.662291);
    MACoordinateSpan span;
    span.latitudeDelta=0.007;
    span.longitudeDelta=0.007;
    
    MACoordinateRegion region={CLLocationCoordinate2DMake(34.782756,113.662491),span};
    [self.mapView setRegion:region];
}

- (void)initSearch
{
    self.search.delegate = self;
}

- (void)initBaseNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"校园导航"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(returnAction)];
}

- (void)initTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}


@end

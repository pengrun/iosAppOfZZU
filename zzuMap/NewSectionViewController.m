//
//  NewSectionViewController.m
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/28.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "NewSectionViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIColorAdditions.h"
#define TileOverlayViewControllerCoordinate CLLocationCoordinate2DMake(34.814209,113.535901)
#define TileOverlayViewControllerDistance   10

enum
{
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};

@interface NewSectionViewController ()
{
    CLLocationManager   *_locationManager;
    
    CLGeocoder          *_geocoder;
}

@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) MAGroundOverlay *groundOverlay;
@property (nonatomic, strong) UIView *ttView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MAPolyline *polyline;
@end

@implementation NewSectionViewController
@synthesize mapView = _mapView;
@synthesize search  = _search;
@synthesize annotations = _annotations;

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate = [[UIApplication sharedApplication] delegate];
    
    self.title=@"新校区";
    
    self.title=@"新校区地图导航";
    
    self.navigationController.navigationBarHidden=YES;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    label.text=@"新校区地图导航";
    label.textColor=[UIColor colorWithHexString:@"25b3e3"];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    //定义返回按钮
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    
    [self initMapView];

    self.mapView.rotateEnabled=NO;

    
    UIButton *lifeBT=[[UIButton alloc]initWithFrame:CGRectMake(260, 90, 60, 30)];
    [lifeBT setTitle:@"生活" forState:UIControlStateNormal];
    [lifeBT setBackgroundColor:[UIColor redColor]];
    [lifeBT addTarget:self action:@selector(chooseLifeBT) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:lifeBT];
    
    UIButton *studyBT=[[UIButton alloc]initWithFrame:CGRectMake(260, 120, 60, 30)];
    [studyBT setTitle:@"学习" forState:UIControlStateNormal];
    [studyBT setBackgroundColor:[UIColor redColor]];
    [studyBT addTarget:self action:@selector(chooseStudy) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:studyBT];
    
    UIButton *roadBT=[[UIButton alloc]initWithFrame:CGRectMake(260, 150, 60, 30)];
    [roadBT setTitle:@"道路" forState:UIControlStateNormal];
    [roadBT setBackgroundColor:[UIColor redColor]];
    [roadBT addTarget:self action:@selector(chooseRoadBT) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:roadBT];
    
    
    NSURL *URLTemplate =[[NSBundle mainBundle] URLForResource:@"icon" withExtension:@"png"];
    
    MATileOverlay *tileOverlay = [[MATileOverlay alloc] initWithURLTemplate:[URLTemplate description]];
    NSLog(@"[URLTemplate description]-----%@",[URLTemplate description]);
    
    
    /* minimumZ 是tileOverlay的可见最小Zoom值. */
    tileOverlay.minimumZ = 18;
    /* minimumZ 是tileOverlay的可见最大Zoom值. */
    tileOverlay.maximumZ = 20;
    
    /* boundingMapRect 是用来 设定tileOverlay的可渲染区域. */
    tileOverlay.boundingMapRect = MAMapRectForCoordinateRegion(MACoordinateRegionMakeWithDistance(TileOverlayViewControllerCoordinate, TileOverlayViewControllerDistance, TileOverlayViewControllerDistance));
    [self.mapView addOverlay:tileOverlay];
    
    
}


//#pragma mark - MKMapViewDelegate
//
//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MATileOverlay class]])
//    {
//        MATileOverlayView *tileOverlayView = [[MATileOverlayView alloc] initWithTileOverlay:overlay];
//        
//        return tileOverlayView;
//    }
//    
//    return nil;
//}

-(void)chooseLifeBT
{
    [self showGrid];
}
-(void)chooseStudy
{
    [self showGrid2];
}
-(void)chooseRoadBT
{
    for (double i=0.001; i<0.02; i=i+0.001)
    {
        MACoordinateSpan span;
        span.latitudeDelta=0.007;
        span.longitudeDelta=0.007;
        
        MACoordinateRegion region={CLLocationCoordinate2DMake(34.782756,113.662491),span};
        [self.mapView setRegion:region];
    }
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:pointReuseIndetifier];
        }
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeInfoDark];
        [button addTarget:self action:@selector(ClickBT:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = button;
        //        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = [self.annotations indexOfObject:annotation];
        
        return annotationView;
    }
    
    return nil;
}


-(void)ClickBT:(UIButton *)bt
{
    NSLog(@"aaaa");
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAGroundOverlay class]])
    {
        MAGroundOverlayView *groundOverlayView = [[MAGroundOverlayView alloc] initWithGroundOverlay:overlay];
        
        return groundOverlayView;
    }
    
    if ([overlay isKindOfClass:[MATileOverlay class]])
        {
            MATileOverlayView *tileOverlayView = [[MATileOverlayView alloc] initWithTileOverlay:overlay];
            NSLog(@"asdfasdfasdf");
            return tileOverlayView;
        }
    
    if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonView *polygonView = [[MAPolygonView alloc] initWithPolygon:overlay];
        polygonView.lineWidth   = 8.f;
        polygonView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        polygonView.fillColor   = [UIColor redColor];
        
        return polygonView;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 8.f;
        //        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        polylineView.strokeColor=[UIColor redColor];
        polylineView.fillColor   = [UIColor purpleColor];
        polylineView.backgroundColor=[UIColor redColor];
        return polylineView;
    }
    else
    {
        return nil;
    }
    
}


#pragma mark - Initialization

//-----------初始化生活-------------
- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    dormitoryArray=[NSMutableArray array];//宿舍数组
    diningRoomArray=[NSMutableArray array];//餐厅数组
    bathsRoomArray=[NSMutableArray array]; //澡堂数组
    boiledWaterRoomArray=[NSMutableArray array];//开水房数组
    sportArray=[NSMutableArray array];//运动数组
    supermarketArray=[NSMutableArray array];//超市数组
    hospitalArray=[NSMutableArray array];//医院数组
    barberShopArray=[NSMutableArray array];//理发店数组
    
    
    //-----------------------------------------宿舍楼-----------------------------------
    
    /* ------------1号宿舍楼------------- */
    MAPointAnnotation *firstSH = [[MAPointAnnotation alloc] init];
    firstSH.coordinate = CLLocationCoordinate2DMake(34.780677,113.666042);
    firstSH.title= @"1号宿舍楼";
    [self.annotations insertObject:firstSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:firstSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    /* ------------2号宿舍楼------------- */
    MAPointAnnotation *secondSH = [[MAPointAnnotation alloc] init];
    secondSH.coordinate = CLLocationCoordinate2DMake(34.780192,113.666031);
    secondSH.title= @"2号宿舍楼";
    [self.annotations insertObject:secondSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:secondSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------3号宿舍楼------------- */
    MAPointAnnotation *thirdSH = [[MAPointAnnotation alloc] init];
    thirdSH.coordinate = CLLocationCoordinate2DMake(34.780686,113.6641);
    thirdSH.title= @"3号宿舍楼";
    [self.annotations insertObject:thirdSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:thirdSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------4号宿舍楼------------- */
    MAPointAnnotation *forthSH = [[MAPointAnnotation alloc] init];
    forthSH.coordinate = CLLocationCoordinate2DMake(34.780201,113.664132);
    forthSH.title= @"4号宿舍楼";
    [self.annotations insertObject:forthSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:forthSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    /* ------------5号宿舍楼------------- */
    MAPointAnnotation *fiveSH = [[MAPointAnnotation alloc] init];
    fiveSH.coordinate = CLLocationCoordinate2DMake(34.780465,113.663521);
    fiveSH.title= @"5号宿舍楼";
    [self.annotations insertObject:fiveSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:fiveSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    /* ------------6号宿舍楼------------- */
    MAPointAnnotation *sixSH = [[MAPointAnnotation alloc] init];
    sixSH.coordinate = CLLocationCoordinate2DMake(34.783091,113.665967);
    sixSH.title= @"6号宿舍楼";
    [self.annotations insertObject:sixSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:sixSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    /* ------------7号宿舍楼------------- */
    MAPointAnnotation *sevenSH = [[MAPointAnnotation alloc] init];
    sevenSH.coordinate = CLLocationCoordinate2DMake(34.783523,113.66586);
    sevenSH.title= @"7号宿舍楼";
    [self.annotations insertObject:sevenSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:sevenSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    /* ------------8号宿舍楼------------- */
    MAPointAnnotation *eightSH = [[MAPointAnnotation alloc] init];
    eightSH.coordinate = CLLocationCoordinate2DMake(34.782043,113.659658);
    eightSH.title= @"8号宿舍楼";
    [self.annotations insertObject:eightSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:eightSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    /* ------------研一楼------------- */
    MAPointAnnotation *yanyiSH = [[MAPointAnnotation alloc] init];
    yanyiSH.coordinate = CLLocationCoordinate2DMake(34.783505,113.659884);
    yanyiSH.title= @"研一楼";
    [self.annotations insertObject:yanyiSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    [dormitoryArray insertObject:yanyiSH atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    //------------------------------------------餐厅--------------------------------------------
    
    /* ------------一食堂------------- */
    MAPointAnnotation *firstDiningRoom = [[MAPointAnnotation alloc] init];
    firstDiningRoom.coordinate = CLLocationCoordinate2DMake(34.783417,113.665012);
    firstDiningRoom.title= @"一食堂";
    [self.annotations insertObject:firstDiningRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    [diningRoomArray insertObject:firstDiningRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------二食堂------------- */
    MAPointAnnotation *secondDiningRoom = [[MAPointAnnotation alloc] init];
    secondDiningRoom.coordinate = CLLocationCoordinate2DMake(34.780333,113.665098);
    secondDiningRoom.title= @"二食堂";
    [self.annotations insertObject:secondDiningRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    [diningRoomArray insertObject:secondDiningRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------三食堂------------- */
    MAPointAnnotation *thirdDininigRoom = [[MAPointAnnotation alloc] init];
    thirdDininigRoom.coordinate = CLLocationCoordinate2DMake(34.780439,113.664669);
    thirdDininigRoom.title= @"三食堂";
    [self.annotations insertObject:thirdDininigRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    [diningRoomArray insertObject:thirdDininigRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    //------------------------------------------澡堂--------------------------------------------
    
    /* ------------澡堂------------- */
    MAPointAnnotation *bathsRoom = [[MAPointAnnotation alloc] init];
    bathsRoom.coordinate = CLLocationCoordinate2DMake(34.783452,113.661053);
    bathsRoom.title= @"澡堂";
    [self.annotations insertObject:bathsRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    [bathsRoomArray insertObject:bathsRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    //------------------------------------------开水房--------------------------------------------
    
    /* ------------开水房(南)------------- */
    MAPointAnnotation *boiledWaterRoom1= [[MAPointAnnotation alloc] init];
    boiledWaterRoom1.coordinate = CLLocationCoordinate2DMake(34.781241,113.663939);
    boiledWaterRoom1.title= @"开水房(南)";
    boiledWaterRoom1.subtitle=@"开放时间:上午07:00--09:00 中午:11:30--01:30 晚上:17:00--21:00";
    [self.annotations insertObject:boiledWaterRoom1 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [boiledWaterRoomArray insertObject:boiledWaterRoom1 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------开水房(北)------------- */
    MAPointAnnotation *boiledWaterRoom2= [[MAPointAnnotation alloc] init];
    boiledWaterRoom2.coordinate = CLLocationCoordinate2DMake(34.783259,113.661042);
    boiledWaterRoom2.title= @"开水房(北)";
    [self.annotations insertObject:boiledWaterRoom2 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [boiledWaterRoomArray insertObject:boiledWaterRoom2 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    //------------------------------------------超市--------------------------------------------
    
    /* ------------5号楼－超市------------- */
    MAPointAnnotation *supermarket1= [[MAPointAnnotation alloc] init];
    supermarket1.coordinate = CLLocationCoordinate2DMake(34.780368,113.663542);
    supermarket1.title= @"5号楼－超市";
    [self.annotations insertObject:supermarket1 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [supermarketArray insertObject:supermarket1 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------7号楼－超市------------- */
    MAPointAnnotation *supermarket2= [[MAPointAnnotation alloc] init];
    supermarket2.coordinate = CLLocationCoordinate2DMake(34.783423,113.665903);
    supermarket2.title= @"7号楼－超市";
    [self.annotations insertObject:supermarket2 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [supermarketArray insertObject:supermarket2 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------青年教师公寓－超市------------- */
    MAPointAnnotation *supermarket3= [[MAPointAnnotation alloc] init];
    supermarket3.coordinate = CLLocationCoordinate2DMake(34.783159,113.660034);
    supermarket3.title= @"青年教师公寓－超市";
    [self.annotations insertObject:supermarket3 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [supermarketArray insertObject:supermarket3 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    
    //------------------------------------------体育--------------------------------------------
    
    /* ------------室内体育馆------------- */
    MAPointAnnotation *sportRoom= [[MAPointAnnotation alloc] init];
    sportRoom.coordinate = CLLocationCoordinate2DMake(34.782034,113.659637);
    sportRoom.title= @"室内体育馆";
    [self.annotations insertObject:sportRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    [sportArray insertObject:sportRoom atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------足球场------------- */
    MAPointAnnotation *footBallField= [[MAPointAnnotation alloc] init];
    footBallField.coordinate = CLLocationCoordinate2DMake(34.782034,113.659637);
    footBallField.title= @"足球场";
    [self.annotations insertObject:footBallField atIndex:AnnotationViewControllerAnnotationTypeRed];
    [sportArray insertObject:footBallField atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------操场------------- */
    MAPointAnnotation *playground= [[MAPointAnnotation alloc] init];
    playground.coordinate = CLLocationCoordinate2DMake(34.781831,113.660839);
    playground.title= @"操场";
    [self.annotations insertObject:playground atIndex:AnnotationViewControllerAnnotationTypeRed];
    [sportArray insertObject:playground atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------排球场------------- */
    MAPointAnnotation *volleyballCourt= [[MAPointAnnotation alloc] init];
    volleyballCourt.coordinate = CLLocationCoordinate2DMake(34.78288,113.660527);
    volleyballCourt.title= @"排球场";
    [self.annotations insertObject:volleyballCourt atIndex:AnnotationViewControllerAnnotationTypeRed];
    [sportArray insertObject:volleyballCourt atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------网球场------------- */
    MAPointAnnotation *tennisCourt= [[MAPointAnnotation alloc] init];
    tennisCourt.coordinate = CLLocationCoordinate2DMake(34.782862,113.661128);
    tennisCourt.title= @"网球场";
    [self.annotations insertObject:tennisCourt atIndex:AnnotationViewControllerAnnotationTypeRed];
    [sportArray insertObject:tennisCourt atIndex:AnnotationViewControllerAnnotationTypeRed];
    //
    /* ------------篮球场------------- */
    MAPointAnnotation *basekateBallCourt= [[MAPointAnnotation alloc] init];
    basekateBallCourt.coordinate = CLLocationCoordinate2DMake(34.782228,113.660066);
    basekateBallCourt.title= @"篮球场";
    [self.annotations insertObject:basekateBallCourt atIndex:AnnotationViewControllerAnnotationTypeRed];
    [sportArray insertObject:basekateBallCourt atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    
    
    //------------------------------------------校医院--------------------------------------------
    
    /* ------------校医院------------- */
    MAPointAnnotation *hospital= [[MAPointAnnotation alloc] init];
    hospital.coordinate = CLLocationCoordinate2DMake(34.782853,113.666278);
    hospital.title= @"校医院";
    [self.annotations insertObject:hospital atIndex:AnnotationViewControllerAnnotationTypeRed];
    [hospitalArray insertObject:hospital atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    //------------------------------------------美发--------------------------------------------
    
    /* ------------南门理发店:------------- */
    MAPointAnnotation *meifa1= [[MAPointAnnotation alloc] init];
    meifa1.coordinate = CLLocationCoordinate2DMake(34.780254,113.660978);
    meifa1.title= @"南门理发店:";
    [self.annotations insertObject:meifa1 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [barberShopArray insertObject:meifa1 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* ------------一食堂理发店------------- */
    MAPointAnnotation *meifa2= [[MAPointAnnotation alloc] init];
    meifa2.coordinate = CLLocationCoordinate2DMake(34.780377,113.664422);
    meifa2.title= @"一食堂理发店";
    [self.annotations insertObject:meifa2 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [barberShopArray insertObject:meifa2 atIndex:AnnotationViewControllerAnnotationTypeRed];
    //113.663532,34.780307
    
    /* ------------5号楼理发店------------- */
    MAPointAnnotation *meifa3= [[MAPointAnnotation alloc] init];
    meifa3.coordinate = CLLocationCoordinate2DMake(34.780307,113.663532);
    meifa3.title= @"5号楼理发店";
    [self.annotations insertObject:meifa3 atIndex:AnnotationViewControllerAnnotationTypeRed];
    [barberShopArray insertObject:meifa3 atIndex:AnnotationViewControllerAnnotationTypeRed];
    
}

//--------初始化教室锚点---------
- (void)initClassAnnotations
{
    classRoomArray=[NSMutableArray array];//初始化班级数组
    laboratoryArray=[NSMutableArray array];//初始化实验室数组
    tushuguanArray=[NSMutableArray array];//初始化图书馆数组
    
    /*-------------- 水环楼 ---------------*/
    MAPointAnnotation *shuiHuan = [[MAPointAnnotation alloc] init];
    shuiHuan.coordinate = CLLocationCoordinate2DMake(34.781285,113.665122);
    shuiHuan.title= @"水环楼";
    
    [classRoomArray insertObject:shuiHuan atIndex:AnnotationViewControllerAnnotationTypeRed];
    NSLog(@"---clss count is %d",classRoomArray.count);
    /*------------ 化工楼 ------------*/
    MAPointAnnotation *huaGong = [[MAPointAnnotation alloc] init];
    huaGong.coordinate = CLLocationCoordinate2DMake(34.782457,113.665109);
    huaGong.title= @"化工楼";
    [classRoomArray insertObject:huaGong atIndex:AnnotationViewControllerAnnotationTypeRed];
    NSLog(@"---22clss count is %d",classRoomArray.count);
    /*-------------- 教学楼 ---------------*/
    MAPointAnnotation *jiaoXue= [[MAPointAnnotation alloc] init];
    jiaoXue.coordinate = CLLocationCoordinate2DMake(34.78218,113.662062);
    jiaoXue.title      = @"教学楼";
    jiaoXue.subtitle=@"位于北校区";
    [classRoomArray insertObject:jiaoXue atIndex:AnnotationViewControllerAnnotationTypeGreen];
    
    //---------南实训楼－－－－－－－－－
    MAPointAnnotation *nanshixun= [[MAPointAnnotation alloc] init];
    nanshixun.coordinate = CLLocationCoordinate2DMake(34.781476,113.663201);
    nanshixun.title= @"南实训楼";
    nanshixun.subtitle=@"位于北校区";
    [laboratoryArray addObject:nanshixun];
    
    //---------北实训楼－－－－－－－－－
    MAPointAnnotation *beishixun= [[MAPointAnnotation alloc] init];
    beishixun.coordinate = CLLocationCoordinate2DMake(34.782246,113.66322);
    beishixun.title= @"北实训楼";
    beishixun.subtitle=@"位于北校区";
    [laboratoryArray insertObject:beishixun atIndex:AnnotationViewControllerAnnotationTypeRed];
    //---------科研楼－－－－－－－－－
    MAPointAnnotation *keyan= [[MAPointAnnotation alloc] init];
    keyan.coordinate = CLLocationCoordinate2DMake(34.781805,113.662398);
    keyan.title= @"科研楼";
    keyan.subtitle=@"位于北校区";
    [laboratoryArray insertObject:keyan atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    [laboratoryArray insertObject:shuiHuan atIndex:AnnotationViewControllerAnnotationTypeRed];
    [laboratoryArray insertObject:huaGong atIndex:AnnotationViewControllerAnnotationTypeGreen];
    //---------图书馆－－－－－－－－－
    MAPointAnnotation *tushuguan= [[MAPointAnnotation alloc] init];
    tushuguan.coordinate = CLLocationCoordinate2DMake(34.781854, 113.663971);
    tushuguan.title= @"图书馆";
    tushuguan.subtitle=@"位于北校区";
    [tushuguanArray insertObject:tushuguan atIndex:0];
    NSLog(@"----=====%d",classRoomArray.count);
}

/*  -------------覆盖道路初始化方法－－－－－－－－－－*/
-(void)initializationRoad
{
    CLLocationCoordinate2D polylineCoords[2];//113.664229,34.780906
    polylineCoords[0].latitude=34.780906;
    polylineCoords[0].longitude=113.664229;
    polylineCoords[1].latitude=34.780888;//113.663639,34.780888
    polylineCoords[1].longitude=113.663639;
    self.polyline=[MAPolyline polylineWithCoordinates:polylineCoords count:2 ];
    [self.mapView addOverlay:self.polyline];
}



#pragma mark - Initialization

- (void)initGroundOverlay
{
    MACoordinateBounds coordinateBounds = MACoordinateBoundsMake(CLLocationCoordinate2DMake(34.781449,113.664397),
                                                                 CLLocationCoordinate2DMake(34.781176,113.665753));
    
    self.groundOverlay = [MAGroundOverlay groundOverlayWithBounds:coordinateBounds icon:[UIImage imageNamed:@"ph"]];
}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initAnnotations];
        [self initClassAnnotations];
    }
    
    return self;
}


#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex
{
    NSLog(@"Dismissed with item %d: %@", itemIndex, item.title);
    
    /**
     *－－－－－－－－－学习按钮
     **/
    if (gridMenu.view.tag==1002)
    {
        NSLog(@"1002");
        switch (itemIndex)
        {
            case 0:
            {
                NSLog(@"1002-－－－00000");
                
                //教室113.663542,34.78199
                MACoordinateSpan span;
                span.latitudeDelta=0.006;
                span.longitudeDelta=0.0046;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.78199,113.663542),span};
                [self.mapView setRegion:region];
                
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:laboratoryArray];
                [self.mapView removeAnnotations:tushuguanArray];
                
                [self initClassAnnotations];
                [self.mapView addAnnotations:classRoomArray];
                
            }
                break;
            case 1:
            {
                NSLog(@"1002-－－－111111");
                
                //实验室
                MACoordinateSpan span;
                span.latitudeDelta=0.006;
                span.longitudeDelta=0.0046;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.781946,113.66424),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:classRoomArray];
                [self.mapView removeAnnotations:tushuguanArray];
                
                [self initClassAnnotations];
                [self.mapView addAnnotations:laboratoryArray];
            }
                break;
            case 2:
            {
                NSLog(@"1002-－－－222222");
                
                //图书馆113.663789,34.781928
                MACoordinateSpan span;
                span.latitudeDelta=0.0027;
                span.longitudeDelta=0.0016;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.781928,113.663789),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:classRoomArray];
                [self.mapView removeAnnotations:laboratoryArray];
                
                [self initClassAnnotations];
                [self.mapView addAnnotations:tushuguanArray];
            }
                break;
            default:
                break;
        }
    }
    
    /**
     *－－－－－－－－－生活按钮
     **/
    if (gridMenu.view.tag==1001)
    {
        switch (itemIndex)
        {
            case 0:
            {
                NSLog(@"1001-－－－00000");
                //113.662877,34.781805,,,34.781856,113.663991
                MACoordinateSpan span;
                span.latitudeDelta=0.013;
                span.longitudeDelta=0.0002;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.781805,113.662877),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView addAnnotations:dormitoryArray];
            }
                break;
            case 1:
            {
                NSLog(@"1001-－－－11111");
                //113.663167,34.781919,,,34.781805,113.662877,,113.665098,34.781981
                MACoordinateSpan span;
                span.latitudeDelta=0.0073;
                span.longitudeDelta=0.005;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.781981,113.665098),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView addAnnotations:diningRoomArray];
            }
                break;
            case 2:
            {
                NSLog(@"1001-－－－22222");
                //113.661976,34.782025
                MACoordinateSpan span;
                span.latitudeDelta=0.013;
                span.longitudeDelta=0.004;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.782925,113.662376),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView addAnnotations:supermarketArray];
            }
                break;
            case 3:
            {
                NSLog(@"1001-－－－333333");
                //113.662641,34.782809
                
                MACoordinateSpan span;
                span.latitudeDelta=0.010;
                span.longitudeDelta=0.004;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.782809,113.662641),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView addAnnotations:bathsRoomArray];
            }
                break;
                
            case 4:
            {
                NSLog(@"1001-－－－444444");
                
                MACoordinateSpan span;
                span.latitudeDelta=0.010;
                span.longitudeDelta=0.004;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.782809,113.662641),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView addAnnotations:boiledWaterRoomArray];
            }
                break;
            case 5:
            {
                NSLog(@"1001-－－－555555");
                
                //运动
                MACoordinateSpan span;
                span.latitudeDelta=0.005;
                span.longitudeDelta=0.001;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.781893,113.660839),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView addAnnotations:sportArray];
            }
                break;
            case 6:
            {
                NSLog(@"1001-－－－666666");
                
                //校医院
                MACoordinateSpan span;
                span.latitudeDelta=0.005;
                span.longitudeDelta=0.001;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.782298,113.665988),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView addAnnotations:hospitalArray];
            }
                break;
            case 7:
            {
                NSLog(@"1001-－－－777777");
                
                //理发店
                MACoordinateSpan span;
                span.latitudeDelta=0.01;
                span.longitudeDelta=0.005;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.78206,113.662544),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView addAnnotations:barberShopArray];
            }
                break;
            case 8:
            {
                NSLog(@"1001-－－－888888");
                
                //其他
                MACoordinateSpan span;
                span.latitudeDelta=0.007;
                span.longitudeDelta=0.006;
                MACoordinateRegion region={CLLocationCoordinate2DMake(34.781664,113.662663),span};
                [self.mapView setRegion:region];
                
                [self.mapView removeAnnotations:self.annotations];
                [self.mapView removeAnnotations:dormitoryArray];
                [self.mapView removeAnnotations:diningRoomArray];
                [self.mapView removeAnnotations:barberShopArray];
                [self.mapView removeAnnotations:supermarketArray];
                [self.mapView removeAnnotations:bathsRoomArray];
                [self.mapView removeAnnotations:boiledWaterRoomArray];
                [self.mapView removeAnnotations:sportArray];
                [self.mapView removeAnnotations:hospitalArray];
                [self.mapView removeAnnotations:classRoomArray];
                [self.mapView removeAnnotations:laboratoryArray];
                [self.mapView removeAnnotations:tushuguanArray];
                
            }
                break;
                
            default:
                break;
        }
    }
}
- (void)showGrid
{
    NSInteger numberOfOptions =9;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"宿舍"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"食堂"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"超市"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"洗澡堂"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"开水房"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"运动"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"enter"] title:@"校医院"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"理发店"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"github"] title:@"其他"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.bounces = NO;
    av.view.tag=1001;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}


- (void)showGrid2
{
    NSInteger numberOfOptions =3;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"教室"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"实验室"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"图书馆"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.view.tag=1002;
    av.delegate = self;
    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}


#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

#pragma mark - Handle Action

- (void)returnAction
{
    self.navigationController.navigationBarHidden=NO;
    [appdelegate.root setTabBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
}

#pragma mark - Initialization

- (void)initMapView
{
//    self.mapView.frame = self.view.bounds;
    self.mapView.frame=CGRectMake(0, 65, 320, 568-65);
    self.mapView.delegate = self;
    
    
    [self.view addSubview:self.mapView];
    
    MACoordinateSpan span;
    span.latitudeDelta=0.01;
    span.longitudeDelta=0.007;

    MACoordinateRegion region={CLLocationCoordinate2DMake(34.814209,113.535901),span};
    [self.mapView setRegion:region];
}


-(void)createLeftItem:(NSString *)title font:(float)font  normalImage:(NSString *)normalImage highLightedImage:(NSString *)highLightedImage
{
    
    UIButton* btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSwitch.frame=CGRectMake(0., 20., [UIImage imageNamed:normalImage].size.width, [UIImage imageNamed:normalImage].size.height);
    [btnSwitch setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btnSwitch setBackgroundImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
    [btnSwitch setTitle:title forState:UIControlStateNormal];
    [btnSwitch.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [btnSwitch addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lefrtItem = [[UIBarButtonItem alloc] initWithCustomView:btnSwitch];
    self.navigationItem.leftBarButtonItem = lefrtItem;
}
-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

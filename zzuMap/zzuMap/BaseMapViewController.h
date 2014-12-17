//
//  BaseMapViewController.h
//  zzuMapGD
//
//  Created by 李鹏飞 on 14-9-18.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "AppDelegate.h"
@interface BaseMapViewController : UIViewController<MAMapViewDelegate,AMapSearchDelegate>
{
    AppDelegate *appdelegate;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

- (void)returnAction;
@end

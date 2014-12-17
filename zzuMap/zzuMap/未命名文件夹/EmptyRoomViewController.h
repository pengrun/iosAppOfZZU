//
//  EmptyRoomViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14-8-13.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "MarcoComman.h"

@interface EmptyRoomViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MBProgressHUDDelegate>
{
//    UITableView *tableView;
    MBProgressHUD *HUD;
    NSMutableArray *emptyRoomArray;
    
    NSArray *floorArray;
    NSMutableArray *buildingArray;
    NSMutableArray *newBuildingArray;
    NSMutableArray *oldBuildingArray;
    NSMutableArray *timeArray;
    NSMutableArray *weekArray;
    NSMutableArray *buildingDataArray;
    NSMutableArray *capacityArray;
    
    NSMutableArray *newBuildingIDArray;
    NSMutableArray *oldBuildingIDArray;
    
    UIButton *buttonB;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    int count;
    UIPickerView *pickerView;
    UIPickerView *pickerView2;
    UIToolbar *toolbar;
    UIToolbar *toolbar2;
    NSString *selectedContent;
    NSString *string1;
    NSString *string2;//显示楼名字
    NSString *string3;//显示节数
    NSString *string4;//显示星期名字
    NSString *stringDisplay;//显示校区
    NSString *buildingID;//校区ID
    NSString *sectionID;
    NSString *weekID;
    NSString *weekDay;
    NSString *compus;
    NSString * buildID;

    
    
}
@property(nonatomic,strong)UITableView *tableView;
@end

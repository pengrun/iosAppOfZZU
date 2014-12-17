//
//  NorthViewController.h
//  zzuMapGD
//
//  Created by 李鹏飞 on 14-9-18.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "BaseMapViewController.h"
#import "RNGridMenu.h"
#import <QuartzCore/QuartzCore.h>
@interface NorthViewController : BaseMapViewController<RNGridMenuDelegate>
{
    NSMutableArray *classRoomArray;//教室数组
    NSMutableArray *dormitoryArray;//宿舍数组
    NSMutableArray *laboratoryArray;//实验室数组
    NSMutableArray *diningRoomArray;//餐厅数组
    NSMutableArray *barberShopArray;//理发店数组
    NSMutableArray *supermarketArray;//超市数组
    NSMutableArray *boiledWaterRoomArray;//水房数组
    NSMutableArray *bathsRoomArray;//澡堂数组
    NSMutableArray *pharmacyArray;//药店数组
    NSMutableArray *tushuguanArray;//图书馆数组
    NSMutableArray *sportArray;//体育数组
    NSMutableArray *hospitalArray;//医院数组
    NSMutableArray *dormitoryCoorArray;//
    NSMutableArray *testForArray;//测试数组
}
@end

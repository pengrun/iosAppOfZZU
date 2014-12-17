//
//  ChengjiResultViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/23.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChengjiCell.h"
@interface ChengjiResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSMutableArray *KCNameArray;
@property(retain,nonatomic)NSMutableArray *JidingArray;
@property(retain,nonatomic)NSMutableArray *ChengjiArray;

@end

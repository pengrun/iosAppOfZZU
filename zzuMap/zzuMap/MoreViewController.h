//
//  MoreViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/22.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
    NSMutableArray *section2Array;
}
@property(nonatomic,retain)UITableView *tableView;

@end

//
//  NewsNoticeViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14-9-29.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "ASIHTTPREQUEST/ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface NewsNoticeViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UISegmentedControl *segment;
@property (nonatomic,retain)NSMutableArray *newsTitle;
@property (nonatomic,retain)NSMutableArray *newsURL;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

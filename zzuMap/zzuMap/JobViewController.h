//
//  JobViewController.h
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/23.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "ZZUViewController.h"
#import "ASIHTTPREQUEST/ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface JobViewController : ZZUViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic,strong)UISegmentedControl *segment;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *newsTitle;
@property (nonatomic,retain)NSMutableArray *newsURL;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end

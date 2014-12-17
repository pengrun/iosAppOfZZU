//
//  popTable.m
//  popButtonTable
//
//  Created by 李鹏飞 on 14/10/29.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "popTable.h"
#import "popTableCell.h"
#define kArrowHeight 10.f
#define kArrowCurvature 6.f
#define SPACE 2.f
#define ROW_HEIGHT 44.f
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]


@interface popTable ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIButton *handerView;

@end

@implementation popTable


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];;
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles
{
    self=[super init];
    
    if (self)
    {
        self.showPoint=point;
        self.titleArray=titles;
        self.frame = [self getViewFrame];
        [self addSubview:self.tableView];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    
    NSLog(@"------%d",[self.titleArray count]);
    
    if ([self.titleArray count]<6)
    {
        frame.size.height = [self.titleArray count]* ROW_HEIGHT + SPACE + kArrowHeight;
    }else
    {
      frame.size.height = 5*ROW_HEIGHT + SPACE + kArrowHeight-20;
    }
    
//    frame.size.height = kArrowHeight+300;
    frame.size.width=110;
    
    frame.size.width = 10 + frame.size.width + 40;
    
    frame.origin.x = self.showPoint.x - frame.size.width/2;
//    frame.origin.x = self.showPoint.x ;
    frame.origin.y = self.showPoint.y;
    
//    //左间隔最小5x
//    if (frame.origin.x < 5) {
//        frame.origin.x = 5;
//    }
//    //右间隔最小5x
//    if ((frame.origin.x + frame.size.width) > 315) {
//        frame.origin.x = 315 - frame.size.width;
//    }
    
    return frame;
}

-(void)show
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    self.frame = [self getViewFrame];
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

-(void)dismiss
{
    [self dismiss:YES];
}

-(void)dismiss:(BOOL)animate
{
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
    }];
    
}


#pragma mark - UITableView

-(UITableView *)tableView
{
    if (_tableView != nil)
    {
        return _tableView;
    }
    
    CGRect rect = self.frame;
//    rect.origin.x = SPACE;
//    rect.origin.y = kArrowHeight + SPACE;
//    rect.size.width -= SPACE * 2;
//    rect.size.height -= (SPACE - kArrowHeight);
    rect.origin.x =0;
    rect.origin.y = kArrowHeight;
    rect.size.width =160;
    rect.size.height -= (SPACE - kArrowHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.alwaysBounceHorizontal = NO;
//    _tableView.alwaysBounceVertical = NO;
//    _tableView.showsHorizontalScrollIndicator = NO;
//    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    return _tableView;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    popTableCell *popCell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (popCell==nil)
    {
        popCell=[[[NSBundle mainBundle] loadNibNamed:@"popTableCell" owner:self options:nil] objectAtIndex:0];
    }
    popCell.backgroundColor=[UIColor blackColor];
    popCell.textName.text=[_titleArray objectAtIndex:indexPath.row];
    popCell.textName.textColor=[UIColor whiteColor];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    cell.backgroundColor=[UIColor clearColor];
//    if ([_imageArray count] == [_titleArray count]) {
//        cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
//    }
//    cell.textLabel.font = [UIFont systemFontOfSize:16];
//    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
//    cell.textLabel.textAlignment=NSTextAlignmentCenter;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    
    return popCell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex)
    {
        self.selectRowAtIndex(indexPath.row);
    }
    [self dismiss:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

@end

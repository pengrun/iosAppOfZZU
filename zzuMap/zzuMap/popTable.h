//
//  popTable.h
//  popButtonTable
//
//  Created by 李鹏飞 on 14/10/29.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popTable : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, assign) BOOL isChangeColor;
@end

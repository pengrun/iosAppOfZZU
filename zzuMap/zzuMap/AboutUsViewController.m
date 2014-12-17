//
//  AboutUsViewController.m
//  zzuMap
//
//  Created by 翔冰 on 14/12/16.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end
@implementation AboutUsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(0, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
}
-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  VisionsTestViewController.m
//  zzuMap
//
//  Created by 翔冰 on 14/12/16.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "VisionsTestViewController.h"

@interface VisionsTestViewController ()

@end

@implementation VisionsTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btBack=[[UIButton alloc]initWithFrame:CGRectMake(0, 25, 40, 40)];
    [btBack setImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
    [btBack setImage:[UIImage imageNamed:@"back_pressed.png"] forState:UIControlStateHighlighted];
    [btBack addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];

    // Do any additional setup after loading the view from its nib.
}
-(void)leftItem

{
    [self .navigationController popViewControllerAnimated:YES ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

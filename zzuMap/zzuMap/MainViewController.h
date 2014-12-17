//
//  MainViewController.h
//  zzuMapGD
//
//  Created by 李鹏飞 on 14-9-18.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MainViewController : UIViewController
{
    AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet UIButton *northBT;
//@property (weak, nonatomic) IBOutlet UIButton *newBT;
- (IBAction)northBTClick:(id)sender;
- (IBAction)newBTClick:(id)sender;

@end

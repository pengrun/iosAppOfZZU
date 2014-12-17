//
//  SGPageViewController.h
//  zzuMap
//
//  Created by apple on 14-9-21.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "ServiceBaseRequest.h"
#import "ServiceBaseResponse.h"
#import "ChengjiResultViewController.h"


@interface SGPageViewController : UIViewController<UITextFieldDelegate>
{
    UITextField * nianjiText;//TextFiled--年级
    UITextField * xuehaoText;//TextFiled--学号
    UITextField *mimaText;//TextFiled--密码
    MBProgressHUD* HUD;
}
@end

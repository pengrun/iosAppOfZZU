//
//  StringValidate.h
//  healthManagement
//
//  Created by renqing on 14-1-11.
//  Copyright (c) 2014年 renqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringValidate : NSObject
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateMobile:(NSString *)mobile;
@end

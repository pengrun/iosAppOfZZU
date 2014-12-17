//
//  DATAService.m
//  healthManagement
//
//  Created by renqing on 13-11-13.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#import "DATAService.h"

@implementation DATAService
+(void)saveDataToLocal:(NSString *)key value:(id)value{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}
+(id)getDataFormLocal:(NSString *)key{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:key]) {
        return [userDefault objectForKey:key];
    }
    return nil ;
}

+(void)removeDataFromLocal:(NSString *)key{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:key]) {
        [userDefault removeObjectForKey:key];
    }
}

@end

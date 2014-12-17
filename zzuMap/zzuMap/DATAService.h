//
//  DATAService.h
//  healthManagement
//
//  Created by renqing on 13-11-13.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATA_FILE_PATH(__FILE_NAME) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:(__FILE_NAME)]


@interface DATAService : NSObject

+(void)saveDataToLocal:(NSString *)key value:(id)value;
+(id)getDataFormLocal:(NSString *)key;
+(void)removeDataFromLocal:(NSString *)key;

@end

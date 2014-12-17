//
//  ServiceBaseResponse.m
//  healthManagement
//
//  Created by renqing on 13-11-25.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#import "ServiceBaseResponse.h"

@implementation ServiceBaseResponse
- (id)initWithRequest:(ASIFormDataRequest *)request
{
    self = [super init];
    if (self) {
        NSLog(@"request url: %@  response-- :%@", request.url.absoluteString,request.responseString);
        
        NSError *error = request.error;
        id dic = nil;
        
        if (error == nil) {
            NSError *jsonError = nil;
            dic = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                  options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError != nil) {
                //                NSLog(@"json parse error");
                self.success = NO;
                self.retValue = @"";
            }
            
            if (dic) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    
                    if ([[dic allKeys] containsObject:@"code"]) {
                        
                    }else{
                        self.success = YES;
                        self.retValue = dic;
                    }
                }else{
                    self.success = YES;
                    self.retValue = dic;
                }
            }else{
                self.success = NO;
                //test error
            }
        }else{
            if(error.code == ASIRequestCancelledErrorType){
                self.success = NO;
                self.error = nil;
            }else{
                self.success = NO;
                self.error = error;
                
                //                NSLog(@"errorerroe: %@",error.localizedDescription);
                
            }
        }
    }
    return self;
}

- (id)initWithSubRequest:(ASIFormDataRequest *)request
{
    self = [super init];
    if (self) {
        //        NSLog(@"request url: %@  response-- :%@", request.url.absoluteString,request.responseString);
        
        NSError *error = request.error;
        NSDictionary *dic = nil;
        if (error == nil) {
            NSError *jsonError = nil;
            
            NSData *responseData = [request.responseData subdataWithRange:NSMakeRange(3,request.responseData.length - 3)];
            
            dic = [NSJSONSerialization JSONObjectWithData:responseData
                                                  options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError != nil) {
                //                NSLog(@"json parse error");
                self.success = NO;
                self.retValue = @"";
            }
            
            if (dic) {
                self.success = YES;
                self.retValue = dic;
            }else{
                self.success = NO;
                //test error
            }
            //            NSLog(@"kasdflkasjdlfka: %@",dic);
            
        }else{
            if(error.code == ASIRequestCancelledErrorType){
                self.success = NO;
                self.error = nil;
            }else{
                self.success = NO;
                self.error = error;
            }
        }
    }
    return self;
}

- (id)initWithNumRequest:(ASIFormDataRequest *)request
{
    self = [super init];
    if (self) {
        
        //        NSLog(@"request url: %@  response-- :%@", request.url.absoluteString,request.responseString);
        
        NSScanner* scan = [NSScanner scannerWithString:request.responseString];
        int val;
        BOOL ret = [scan scanInt:&val] && [scan isAtEnd];
        self.success = ret;
        
        //        NSError *error = request.error;
        //        NSDictionary *dic = nil;
        //        if (error == nil) {
        //            NSError *jsonError = nil;
        //            dic = [NSJSONSerialization JSONObjectWithData:request.responseData
        //                                                  options:NSJSONReadingMutableContainers error:&jsonError];
        //            if (jsonError != nil) {
        //                NSLog(@"json parse error");
        //                self.success = NO;
        //                self.retValue = @"";
        //            }
        //
        //            if (dic) {
        //                self.success = YES;
        //                self.retValue = dic;
        //            }else{
        //                self.success = NO;
        //                //test error
        //            }
        //        }else{
        //            if(error.code == ASIRequestCancelledErrorType){
        //                self.success = NO;
        //                self.error = nil;
        //            }else{
        //                self.success = NO;
        //                self.error = error;
        //
        //                NSLog(@"errorerroe: %@",error.localizedDescription);
        //
        //            }
        //        }
    }
    return self;
}

@end

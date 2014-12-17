//
//  ServiceBaseResponse.h
//  healthManagement
//
//  Created by renqing on 13-11-25.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"


@interface ServiceBaseResponse : NSObject
@property (nonatomic,assign) BOOL success;
@property (nonatomic,assign) int protocol;
@property (nonatomic,retain) id retValue;

@property (nonatomic,retain) NSError *error;

- (id)initWithRequest:(ASIFormDataRequest *)request;

- (id)initWithSubRequest:(ASIFormDataRequest *)request;//截取多余的字符串

- (id)initWithNumRequest:(ASIFormDataRequest *)request;
@end

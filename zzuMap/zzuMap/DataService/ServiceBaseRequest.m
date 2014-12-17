//
//  ServiceBaseRequest.m
//  healthManagement
//
//  Created by renqing on 13-11-25.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#import "ServiceBaseRequest.h"
#import "DATAService.h"
#import "StringValidate.h"

@implementation ServiceBaseRequest
+ (ServiceBaseRequest *)sharedService{
    static ServiceBaseRequest *_sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[ServiceBaseRequest alloc] init];
    });
    
    return _sharedService;
}


- (id)init
{
    self = [super init];
    if (self) {
        appDelegate = [[UIApplication sharedApplication] delegate];

    }
    return self;
}

- (ASIFormDataRequest *)requestMethod:(NSString *)method
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:method]];
    request=[self addCommanHeader:request];
    request=[self addCommanPostValue:request];
    request.delegate = self;
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:10];
    [request setNumberOfTimesToRetryOnTimeout:3];
    [ASIFormDataRequest setShouldUpdateNetworkActivityIndicator:YES];
    
    return request;
}

-(ASIFormDataRequest *)addCommanHeader:(ASIFormDataRequest *)request{
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
//    [request addPostValue:@"ios" forKey:@"os"];

    return request;
}

-(ASIFormDataRequest *)addCommanPostValue:(ASIFormDataRequest *)request{
//    [request addPostValue:appDelegate.uesrId forKey:@"userId"];

    return  request;
}

-(void )setRequestService:(ASIFormDataRequest *)request completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;{
    __block ASIFormDataRequest *nowRequest = request;
    [request setCompletionBlock:^{
    ServiceBaseResponse *response = [[ServiceBaseResponse alloc] initWithRequest:nowRequest];
    completionHandler(response);
    }];
    [request setFailedBlock:^{
    ServiceBaseResponse *response = [[ServiceBaseResponse alloc] initWithRequest:nowRequest];
    completionHandler(response);
    }];
    [request startAsynchronous];
}
//自习室的方法
-(void)getHealthCondition:(NSString *)buildingID  weekDayTime:(NSString *)weekDay section:(NSString *)sectionID compus:(NSString *)compus   completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler
{
    ASIFormDataRequest *request = [self requestMethod:@"http://115.28.230.185:8080/AppZZU/zapp"];
    
    [request addPostValue:buildingID forKey:@"buildID"];
    [request addPostValue:weekDay  forKey:@"weekDay"];
    [request addPostValue:sectionID  forKey:@"section"];
    [request addPostValue:compus forKey:@"campus"];
    
    NSLog(@"%@,%@,%@,%@",buildingID,weekDay,sectionID,compus);
    
    [self setRequestService:request completionHandler:completionHandler];
    
}
//显示成绩的方法
-(void)getGrade:(NSString *)nianjiID xuehao:(NSString *)xuehao mima:(NSString *)mimaID    completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
{
    ASIFormDataRequest *request = [self requestMethod:@"http://115.28.230.185:8080/AppZZU/QueryScore"];
    
    [request addPostValue:nianjiID forKey:@"nianji"];
    [request addPostValue:xuehao  forKey:@"xuehao"];
    [request addPostValue:mimaID  forKey:@"mima"];
    NSLog(@"%@,%@,%@",nianjiID,xuehao,mimaID);
    
    [self setRequestService:request completionHandler:completionHandler];
}
//选择学期显示成绩的方法
-(void)selectItem:(NSString *)urlString   completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler
{
    ASIFormDataRequest *request = [self requestMethod:@"http://115.28.230.185:8080/AppZZU/QueryScoreFromURL"];
    [request addPostValue:urlString forKey:@"url"];
 
    NSLog(@"%@",urlString);
    
    [self setRequestService:request completionHandler:completionHandler];
}

//获取新闻列表的方法
-(void)getNews:(void(^)(ServiceBaseResponse *response))completionHandler
{
    ASIFormDataRequest *request = [self requestMethod:@"http://115.28.230.185:8080/AppZZU/ObtainNewsInformation"];
    [self setRequestService:request completionHandler:completionHandler];
}

//获取通知公告的方法
-(void)getNotice:(void(^)(ServiceBaseResponse *response))completionHandler
{
    ASIFormDataRequest *request = [self requestMethod:@"http://115.28.230.185:8080/AppZZU/ObtainNoticeInformation"];
    [self setRequestService:request completionHandler:completionHandler];
}
//获取问题列表的方法实现
-(void)getWentiLiebiao:(void(^)(ServiceBaseResponse *response))completionHandler
{
    ASIFormDataRequest *request = [self requestMethod:@"http://115.28.230.185:8080/AppZZU/ResponseWentiServlet"];
    [self setRequestService:request completionHandler:completionHandler];
}
//加载学习宝问题评论的列表
-(void)getCommentsList:(NSString *)pID comletionHandler:(void(^)(ServiceBaseResponse *response))completionHandler
{
    NSString *urlString=@"http://115.28.230.185:8080/AppZZU/ResponseCommentsServlet";
    urlString=[NSString stringWithFormat:@"%@?pID=%@",urlString,pID];
    ASIFormDataRequest *request = [self requestMethod:urlString];
    [self setRequestService:request completionHandler:completionHandler];
}

//提交评论并不附带图片
-(void)postCommentWithoutImage:(NSString *)pID comment:(NSString *)comment  comletionHandler:(void(^)(ServiceBaseResponse *response))completionHandler
{
    NSString *urlString=@"http://115.28.230.185:8080/AppZZU/ReceiveCommentsNoImageServlet";
    ASIFormDataRequest *request = [self requestMethod:urlString];
    [request addPostValue:pID forKey:@"ID"];
    [request addPostValue:comment forKey:@"content"];
    [self setRequestService:request completionHandler:completionHandler];
}
@end

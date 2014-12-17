//
//  ServiceBaseRequest.h
//  healthManagement
//
//  Created by renqing on 13-11-25.
//  Copyright (c) 2013年 renqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceBaseResponse.h"
#import "AppDelegate.h"

@interface ServiceBaseRequest : NSObject
{
    AppDelegate *appDelegate;

    
}

+ (ServiceBaseRequest *)sharedService;
- (ASIFormDataRequest *)requestMethod:(NSString *)method;
-(ASIFormDataRequest *)addCommanHeader:(ASIFormDataRequest *)request;
-(ASIFormDataRequest *)addCommanPostValue:(ASIFormDataRequest *)request;
-(void )setRequestService:(ASIFormDataRequest *)request completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;


#pragma mark 自习室查询、成绩查询、获得新闻和获得通告

//自习室用的
-(void)getHealthCondition:(NSString *)buildingID weekDayTime:(NSString *)weekDay section:(NSString *)sectionID compus:(NSString *)compus   completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//查成绩
-(void)getGrade:(NSString *)nianjiID xuehao:(NSString *)xuehao mima:(NSString *)mimaID    completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//选学期
-(void)selectItem:(NSString *)urlString   completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//加载新闻
-(void)getNews:(void(^)(ServiceBaseResponse *response))completionHandler;
//加载通告
-(void)getNotice:(void(^)(ServiceBaseResponse *response))completionHandler;
//加载学习宝问题列表
-(void)getWentiLiebiao:(void(^)(ServiceBaseResponse *response))completionHandler;
//加载学习宝问题评论的列表
-(void)getCommentsList:(NSString *)pID comletionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//提交评论并不附带图片
-(void)postCommentWithoutImage:(NSString *)pID comment:(NSString *)comment  comletionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//提交评论并不附带图片

#pragma mark 健康计划

//获取评估数据
-(void)getAssess:(void(^)(ServiceBaseResponse *response))completionHandler;
//上传评估数据
-(void)postAssess:(NSDictionary *)dicForData completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//修改评估数据
-(void)changeAssess:(NSDictionary *)dicForData completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//健康问题
-(void)healthProblem:(void(^)(ServiceBaseResponse *response))completionHandler;
//健康问题详情
-(void)healthProblemDetail:(NSString *)methodId completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//健康计划制定
-(void)healthPlanMake:(void(^)(ServiceBaseResponse *response))completionHandler;
//设置时间
-(void)lifePlanSet:(NSString *)name  time  :(NSString *)time completionHandler:(void(^)(ServiceBaseResponse *response))completionHandlerl;


#pragma mark 健康档案
//血压数据
-(void)getBloodPressStatistics:(NSString*)type startTime:(NSString *)startTime completionHandler:(void(^)(ServiceBaseResponse *response))completionHandlerl;
//血糖数据
-(void)getBloodSugarStatistics:(NSString*)type startTime:(NSString *)startTime completionHandler:(void(^)(ServiceBaseResponse *response))completionHandlerl;
//睡眠数据
-(void)getSleepPressStatistics:(NSString*)type startTime:(NSString *)startTime completionHandler:(void(^)(ServiceBaseResponse *response))completionHandlerl;
//运动跑步数据
-(void)getRunPressStatistics:(NSString*)type startTime:(NSString *)startTime completionHandler:(void(^)(ServiceBaseResponse *response))completionHandlerl;
//体重数据
-(void)getWeightPressStatistics:(NSString*)type startTime:(NSString *)startTime completionHandler:(void(^)(ServiceBaseResponse *response))completionHandlerl;


#pragma mark 每一天

//上传血压数据
-(void)postBloodPreess:(NSString *)highPress lowPress:(NSString *)lowPress pulse:(NSString *)pulse    completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//上传体重数据
-(void)postWeight:(NSString *)weight completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//上传运动数据
-(void)postRun:(NSString *)runSteps  runDistance:(NSString *)runDistance   runTime:(NSString *)runTime    completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//上传血糖数据
-(void)postBloodSugar:(NSString *)bloodSugar time:(NSString *)time   completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//上传睡眠数据
-(void)postSleep:(NSString *)sleepTime  deepSleep:(NSString *)deepSleep  lightSleep:(NSString *)lightSleep     completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;

//获取所有数据
-(void)getEveryDay:(void(^)(ServiceBaseResponse *response))completionHandler;

//获取最新版本
-(void)getUpdateVersion:(void(^)(ServiceBaseResponse *response))completionHandler;




#pragma mark 更多
//注销
-(void)logout:(void(^)(ServiceBaseResponse *response))completionHandler;
//登陆
-(void)login:(NSString *)email  password:(NSString *)password completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//注册
-(void)registration:(NSString *)email  password:(NSString *)password nickName:(NSString*)nickName completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//获取个人信息
-(void)GetAccountWithUserID:(NSString*)userid completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//修改个人信息
-(void)EditAccountInfoWithUserName:(NSString*)username
                          TelPhone:(NSString*)telphone
                             Email:(NSString*)email
                 completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//修改密码
-(void)EditAccountInfoWithPwd:(NSString*)pwd
            completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//健康知识
-(void)GetHealthyKnowledgeWithType:(NSString *)type completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
//绑定微信
-(void)getData:(NSString *)username wxId:(NSString *)wxId name:(NSString *)name completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;

//绑定设备
-(void)bindDevice:(NSString *)token bind:(NSString *)bind model:(NSString *)model completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;

//版本检测
-(void)version:(NSString *)version completionHandler:(void(^)(ServiceBaseResponse *response))completionHandler;
@end

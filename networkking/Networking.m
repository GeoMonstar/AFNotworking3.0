//
//  Networking.m
//  networkking
//
//  Created by Monstar on 16/5/16.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "Networking.h"

@implementation Networking
#pragma mark --GET
+(AFHTTPSessionManager *)networkingGETWithURL:(NSString *)URL
                            requestDictionary:(NSDictionary *)requestDictionary
                                      success:(void (^)(NSURLSessionDataTask *operation, NSDictionary* responseObject))success
                                      failure:(void (^)(NSURLSessionDataTask * operation, NSError *error))failure{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) {
    }
    else{
        NSLog(@"JSON字符串转换失败:%@ ,error: %@",requestDictionary,error);
    }
    NSString  *getURL =[NSString stringWithFormat:@"%@%@",@"http://infosoul.oicp.net:8080/fsj",URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"application/json",@"text/javascript", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager GET:getURL parameters:requestDictionary progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
         success(task,[self transJSONtoDic:responseObject]);
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
                failure(task,error);
    }];
    return manager;
}
+ (AFHTTPSessionManager *)networkingGETWithActionType:(NetworkConnectionActionType)actionType
                                             requestDictionary:(NSDictionary *)requestDictionary
                                                       success:(void (^)(NSURLSessionDataTask *operation, NSDictionary* responseObject))success
                                                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) {
    }
    else{
        NSLog(@"JSON字符串转换失败:%@ ,error: %@",requestDictionary,error);
    }
    NSString  *URL =[NSString stringWithFormat:@"%@%@",@"http://infosoul.oicp.net:8080/fsj",[self actionWithConnectionActionType:actionType]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"application/json",@"text/javascript", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:URL parameters:requestDictionary progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
         success(task,[self transJSONtoDic:responseObject]);
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
                failure(task,error);
    }];
    return manager;
}

#pragma mark --POST
+ (AFHTTPSessionManager *)networkingPOSTWithActionType:(NetworkConnectionActionType)actionType
                                       requestDictionary:(NSDictionary *)requestDictionary
                                                 success:(void (^)(NSURLSessionDataTask *operation, NSDictionary* responseObject))success
                                                 failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) {
        
    }
    else{
        NSLog(@"JSON字符串转换失败:%@ ,error: %@",requestDictionary,error);
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",@"http://infosoul.oicp.net:8080/fsj",[self actionWithConnectionActionType:actionType]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"application/json",@"text/javascript", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:URL parameters:requestDictionary progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
         success(task,[self transJSONtoDic:responseObject]);
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        failure(task,error);
    }];
    return manager;
}
#pragma mark --上传
+ (AFHTTPSessionManager *)networkingPostIconWithActionType:(NetworkConnectionActionType)actionType
                                                  requestDictionary:(NSDictionary *)requestDictionary
                                                  formdata:(void (^)(id<AFMultipartFormData>formData))data
                                                  success:(void (^)(NSURLSessionDataTask *operation,NSDictionary* responseObject))success
                                                    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) {
    }
    else{
        NSLog(@"JSON字符串转换失败:%@ ,error: %@",requestDictionary,error);
    }
    NSString  *URL =[NSString stringWithFormat:@"%@%@",@"http://infosoul.oicp.net:8080/fsj",[self actionWithConnectionActionType:actionType]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"application/json",@"text/javascript", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:URL parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>formData) {
        data(formData);
    } progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        success(task,[self transJSONtoDic:responseObject]);
    } failure:^(NSURLSessionDataTask * task, NSError *  error) {
        failure(task,error);
    }];
    return manager;
}
+ (NSDictionary *)transJSONtoDic:(id)data{
    NSDictionary *responseDict ;
    if ([data isKindOfClass:[NSData class]]) {
        responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }else{
        NSLog(@"数据不是NSData数据");
        return data;
    }
    return responseDict;
}
+ (NSString *)actionWithConnectionActionType:(NetworkConnectionActionType)actionType{
    NSString *url = @"";
    switch (actionType) {
        case LoginAction:
            url = @"/rs/user/login";
            break;
        case NationalarmStatus:
            url = @"/rs/app/map/alarmStatus";
            break;
        case AreaalarmStatus:
            url = @"/rs/app/map/alarmStatus";
            break;
        case Allstationquery:
            url = @"/rs/app/map/station/transmitter/list";
            break;
        case Onestationquery:
            url = @"rs/app/map/station/transmitter/getById";
            break;
        case Keywordsquery:
            url = @"/rs/app/map/query";
            break;
        case UserInfoPreview:
            url = @"/rs/app/user/info";
            break;
        case UserInfoChange:
            url = @"/rs/app/user/updateUser";
            break;
        case UserPwdChange:
            url = @"/rs/app/user/changePassword";
            break;
        case UserIconUpload:
            url = @"/rs/user/upload/photo";
            break;
        case UserLogoutAction:
            url = @"/rs/app/user/logout";
            break;
        case GetAllManager:
            url = @"/rs/app/station/manager/list";
            break;
        case GetOneManager:
            url = @"/rs/app/station/manager/info";
            break;
        case GetGongxiao:
            url = @"/rs/app/device/transmitter";
            break;
        case GetGongxiaoDetail:
            url = @"/rs/app/device/amparam";
            break;
        case GetZhengji:
            url = @"/rs/app/device/master";
            break;
        case GetGongzuo:
            url = @"/rs/app/device/workStatus";
            break;
        default:
            break;
    }
    return url;
}
@end

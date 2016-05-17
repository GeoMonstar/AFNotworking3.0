//
//  Networking.h
//  networkking
//
//  Created by Monstar on 16/5/16.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking.h>


@interface Networking : AFHTTPSessionManager

+(AFHTTPSessionManager *)networkingGETWithURL:(NSString *)URL
                            requestDictionary:(NSDictionary *)requestDictionary
                                      success:(void (^)(NSURLSessionDataTask *operation, NSDictionary* responseObject))success
                                      failure:(void (^)(NSURLSessionDataTask * operation, NSError *error))failure;

@end

//
//  SJHTTPRequestOperationManager.h
//  tBook
//
//  Created by 陈少杰 on 14/12/4.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "SJURLRequestMethodDefined.h"

@interface SJHTTPRequestOperationManager : AFHTTPRequestOperationManager
-(AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
-(AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(id)parameters cacheMethod:(SJCacheMethod)cacheMethod  success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
@end

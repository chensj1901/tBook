//
//  SJRecommendAppURLRequest.h
//  Yunpan
//
//  Created by 陈少杰 on 15/8/5.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJHTTPRequestOperationManager.h"

@interface SJRecommendAppURLRequest : SJHTTPRequestOperationManager
+(void)apiQueryAppLinkWithSuccess:(void (^)(AFHTTPRequestOperation *op, id dictionary))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;
+(void)apiGetAppRecommendWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
@end

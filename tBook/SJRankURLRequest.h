//
//  SJRankURLRequest.h
//  tBook
//
//  Created by 陈少杰 on 15/3/10.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJHTTPRequestOperationManager.h"
#import "SJRank.h"



@interface SJRankURLRequest : NSObject

/**
 *	@brief	查询起点榜单
 *
 *	@param 	type 榜单类型
 *	@param 	pageIndex 	分页
 */
+(void)apiGetQidianTopBookWithType:(SJQidianType)type pageIndex:(NSInteger)pageIndex success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

@end

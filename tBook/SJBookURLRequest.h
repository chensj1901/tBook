//
//  SJBookURLRequest.h
//  tBook
//
//  Created by 陈少杰 on 14/12/12.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJHTTPRequestOperationManager.h"
#import "SJBookChapter.h"
#import "SJBook.h"

@interface SJBookURLRequest : NSObject

+(void)apiLoadFirstBooksWithKeyWord:(NSString*)keyWorld pageId:(NSInteger)pageId  success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

+(void)apiLoadBookDetailWithGid:(NSInteger)gid  cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

+(void)apiLoadContentWithChapter:(SJBookChapter*)chapter  success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

+(void)apiLoadBookChapterWithBook:(SJBook*)book cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;


+(void)apiLoadSearchHintBooksWithKeyWord:(NSString*)keyWorld success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
@end

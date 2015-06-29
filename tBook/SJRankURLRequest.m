//
//  SJRankURLRequest.m
//  tBook
//
//  Created by 陈少杰 on 15/3/10.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRankURLRequest.h"

@implementation SJRankURLRequest
+(void)apiGetQidianTopBookWithType:(SJQidianType)type pageIndex:(NSInteger)pageIndex success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"http://3g.if.qidian.com/BookStoreAPI/GetTopBooks.ashx?TopId=%ld&pageIndex=%ld",(long)type,(long)pageIndex];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil cacheMethod:SJCacheMethodNone success:success failure:failure];
}


@end

/*


 http://3g.if.qidian.com/BookUnit/GetUnitBookList.ashx?order=1&finishType=1&pageIndex=2
 起点完本书单
 
 */
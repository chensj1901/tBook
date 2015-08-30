//
//  SJBookURLRequest.m
//  tBook
//
//  Created by 陈少杰 on 14/12/12.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookURLRequest.h"

@implementation SJBookURLRequest
+(void)apiLoadFirstBooksWithKeyWord:(NSString*)keyWorld pageId:(NSInteger)pageId  success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"http://api.easou.com/api/bookapp/search.m?word=%@&type=0&page_id=%ld&count=20&sort_type=0&cid=eef_easou_book&version=002&os=android&udid=%@&appverion=1015&ch=blp1298_10882_001",[keyWorld stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],(long)pageId,self.udid];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil cacheMethod:SJCacheMethodNone success:success failure:failure];
}

+(void)apiLoadBookDetailWithGid:(NSInteger)gid  cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"http://api.easou.com/api/bookapp/cover.m?gid=%ld&session_id=&cid=eef_easou_book&version=002&os=android&udid=%@&appverion=1015&ch=blp1298_10882_001",(long)gid,self.udid];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil cacheMethod:cacheMethod  success:success failure:failure];

}


+(void)apiLoadContentWithChapter:(SJBookChapter*)chapter  success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSLog(@"%@",chapter.chapterName);
    if (chapter) {
        SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager manager];
      
        //http://api.easou.com/api/bookapp/chapter.m?gid=16120847&nid=16205769&sort=7&gsort=0&chapter_name=%E7%AC%AC%E4%BA%94%E7%AB%A0%20%E6%9E%AA%E6%B3%95&cid=eef_&version=002&os=ipad&udid=b913e831daa7625f4dc2ee83d6ae6e1d714a3023&appverion=1001&ch=blf1298_12414_001
        //http://api.easou.com/api/bookapp/chapter.m?gid=16120847&nid=16205769&sort=7&gsort=0&chapter_name=第五章%20枪法&cid=eef_&version=002&os=ipad&udid=b913e831daa7625f4dc2ee83d6ae6e1d714a3023&appverion=1001&ch=blf1298_12414_001
        
        NSString *url = [NSString stringWithFormat:@"http://api.easou.com/api/bookapp/chapter.m?gid=%ld&nid=%ld&sort=%ld&gsort=%ld&chapter_name=%@&cid=eef_&version=002&os=android&udid=E16063156E45B1C2D972F8614DF5487E&appverion=1015&ch=blf1298_12414_001",(long)chapter.gid,(long)chapter.nid,(long)chapter.sort,(long)chapter.gsort,[chapter.chapterName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
        NSLog(@"%@",url);
        [manager GET:url parameters:nil  cacheMethod:SJCacheMethodCacheFirst success:success failure:failure];
    }else{
        if (failure) {
            failure(nil,nil);
        }
    }
}

+(void)apiLoadBookChapterWithBook:(SJBook*)book cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"http://api.easou.com/api/bookapp/chapter_list.m?gid=%ld&nid=%ld&page_id=1&size=2147483647&session_id=&cid=eef_easou_book&version=002&os=android&udid=%@&appverion=1015&ch=blp1298_10882_001",(long)book.gid,(long)book.nid,self.udid];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil cacheMethod:cacheMethod success:success failure:failure];

}

+(NSString *)udid{
    return  [[UIDevice currentDevice].identifierForVendor.UUIDString md5Encode];
}
@end

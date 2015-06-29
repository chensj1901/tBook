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
        [manager POST:@"http://api.easou.com/api/bookapp/batch_chapter.m?a=1&session_id=&cid=eef_easou_book&version=002&os=android&udid=E16063156E45B1C2D972F8614DF5487E&appverion=1015&ch=blp1298_10882_001" parameters:@{@"gid":@(chapter.gid),@"nid":@(chapter.nid),@"chapter_name":chapter.chapterName,@"sort":@(chapter.sort),@"gsort":@(chapter.gsort),@"sequence":@(chapter.sort)}  cacheMethod:SJCacheMethodCacheFirst success:success failure:failure];
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

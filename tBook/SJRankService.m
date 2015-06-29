//
//  SJRankService.m
//  tBook
//
//  Created by 陈少杰 on 15/2/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRankService.h"
#import "SJQidianBook.h"
#import "SJBook.h"

@interface SJRankService ()
@property(nonatomic)NSInteger pageIndex;
@end

@implementation SJRankService
@synthesize books=_books;

-(void)loadFirstQidianRankWithType:(SJQidianType)type success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    self.pageIndex=1;
    
    [SJRankURLRequest apiGetQidianTopBookWithType:type pageIndex:self.pageIndex success:^(AFHTTPRequestOperation *op, id responseObject){
        self.pageIndex++;
        [self.books removeAllObjects];
        if ([[responseObject objectForKey:@"Result"]integerValue] ==0) {
            for (NSDictionary *dic in [responseObject safeObjectForKey:@"Data"]) {
                SJQidianBook *qidianBook=[[SJQidianBook alloc]initWithRemoteDictionary:dic];
                SJBook *book=[[SJBook alloc]initWithQidianBook:qidianBook];
                
                NSMutableArray *books=[self.books safeObjectForKey:@(type)];
                if (!books) {
                    books=[[NSMutableArray alloc]init];
                    [self.books setObject:books forKey:@(type)];
                }
                [books addObject:book];
            }
            if (success) {
                success();
            }
        }else{
            if (fail) {
                NSError *error=[NSError errorWithDomain:[responseObject objectForKey:@"Message"] code:[[responseObject objectForKey:@"Result"]integerValue] userInfo:nil];
                fail(error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)loadMoreQidianRankWithType:(SJQidianType)type success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJRankURLRequest apiGetQidianTopBookWithType:type pageIndex:self.pageIndex success:^(AFHTTPRequestOperation *op, id responseObject){
        self.pageIndex++;
        if ([[responseObject objectForKey:@"Result"]integerValue] ==0) {
            for (NSDictionary *dic in [responseObject safeObjectForKey:@"Data"]) {
                SJQidianBook *qidianBook=[[SJQidianBook alloc]initWithRemoteDictionary:dic];
                SJBook *book=[[SJBook alloc]initWithQidianBook:qidianBook];
                
                NSMutableArray *books=[self.books safeObjectForKey:@(type)];
                if (!books) {
                    books=[[NSMutableArray alloc]init];
                    [self.books setObject:books forKey:@(type)];
                }
                [books addObject:book];

            }
            if (success) {
                success();
            }
        }else{
            if (fail) {
                NSError *error=[NSError errorWithDomain:[responseObject objectForKey:@"Message"] code:[[responseObject objectForKey:@"Result"]integerValue] userInfo:nil];
                fail(error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(NSMutableDictionary *)books{
    if (!_books) {
        _books=[[NSMutableDictionary alloc]init];
    }
    return _books;
}
@end



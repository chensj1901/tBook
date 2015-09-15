//
//  SJBookCacheQueue.m
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookCacheQueue.h"

static SJBookCacheQueue *_sharedQueue;

@implementation SJBookCacheQueue
+(SJBookCacheQueue *)queue{
    if (!_sharedQueue) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedQueue=[[SJBookCacheQueue alloc]init];
            _sharedQueue.maxConcurrentOperationCount=1;
        });
    }
    return _sharedQueue;
}

-(void)addOperation:(NSOperation *)op{
    if (![op isKindOfClass:[SJBookCacheOperation class]]) {
        @throw [NSException exceptionWithName:@"非法的传入类型" reason:nil userInfo:nil];
    }
    [super addOperation:op];
}

@end

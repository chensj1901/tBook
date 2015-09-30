//
//  SJBookCacheOperation.m
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookCacheOperation.h"
#import <MMProgressHUD.h>

//static NSRecursiveLock *lockMain = nil;



NSString *const SJBookCacheOperationDidCacheNotification=@"SJBookCacheOperationDidCacheNotification";

@implementation SJBookCacheOperation
{
    dispatch_semaphore_t semaphore;
}
-(id)initWithBook:(SJBook *)book{
    if (self=[super init]) {
        self.book=book;
    }
    return self;
}

-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

-(void)main{

    semaphore = dispatch_semaphore_create(3);
    
    dispatch_queue_t queue=dispatch_queue_create("TEST", DISPATCH_QUEUE_SERIAL);
    
    [self.bookService loadBookChapterWithBook:self.book cacheMethod:SJCacheMethodFail success:^{
        __block int i=0;
        int sum=[self.bookService.bookChapters count];
        for(SJBookChapter *chapter in self.bookService.bookChapters){
            dispatch_async(queue, ^{
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                
                dispatch_async(dispatch_get_main_queue(),^{
                    [self.bookService loadContentWithChapter:chapter book:self.book shouldFormatPage:NO success:^{
                        i++;
                        dispatch_semaphore_signal(semaphore);
                        
    
                        [[NSNotificationCenter defaultCenter]postNotificationName:SJBookCacheOperationDidCacheNotification object:self userInfo:@{@"book":self.book,@"sum":@(sum),@"current":@(i)}];
                     
                    
                    } fail:^(NSError *error) {
                        dispatch_semaphore_signal(semaphore);
                    }];
                });
            });
            
        }
    } fail:^(NSError *error) {
        
    }];
}

+(SJBookCacheOperation *)operationWithBook:(SJBook *)book{
    SJBookCacheOperation *operation=[[SJBookCacheOperation alloc]initWithBook:book];
    return operation;
}
@end

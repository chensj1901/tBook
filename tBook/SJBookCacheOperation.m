//
//  SJBookCacheOperation.m
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookCacheOperation.h"
#import <MMProgressHUD.h>

static NSRecursiveLock *lockMain = nil;

@implementation SJBookCacheOperation

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
    if (lockMain == nil) {
        lockMain = [[NSRecursiveLock alloc] init];
    }
    
    [self.bookService loadBookChapterWithBook:self.book cacheMethod:SJCacheMethodFail success:^{
        __block int i=0;
        int sum=[self.bookService.bookChapters count];
        for(SJBookChapter *chapter in self.bookService.bookChapters){
               [lockMain lock];
            [self.bookService loadContentWithChapter:chapter book:self.book shouldFormatPage:NO success:^{
                i++;
                [lockMain unlock];
                alert([NSString stringWithFormat:@"%d/%d",i,sum]);
                NSLog(@"%d/%d",i,sum);
//                [MMProgressHUD showWithStatus:[NSString stringWithFormat:@"%d/%d",i,sum]];
            } fail:^(NSError *error) {
                [lockMain unlock];
            }];
        }
    } fail:^(NSError *error) {
        
    }];
}

+(SJBookCacheOperation *)operationWithBook:(SJBook *)book{
    SJBookCacheOperation *operation=[[SJBookCacheOperation alloc]initWithBook:book];
    return operation;
}
@end

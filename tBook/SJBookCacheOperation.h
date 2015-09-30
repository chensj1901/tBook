//
//  SJBookCacheOperation.h
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJBookChapter.h"
#import "SJBookService.h"

NSString *const SJBookCacheOperationDidCacheNotification;

@interface SJBookCacheOperation : NSOperation
@property(nonatomic)id delegate;
@property(nonatomic)SJBook *book;
@property(nonatomic)NSError *error;
@property(nonatomic)SEL didFailWithError;
@property(nonatomic)SJBookService *bookService;
-(id)initWithBook:(SJBook *)book;
+(SJBookCacheOperation*)operationWithBook:(SJBook *)book;
@end

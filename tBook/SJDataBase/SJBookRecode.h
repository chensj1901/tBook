//
//  SJBookRecode.h
//  tBook
//
//  Created by 陈少杰 on 14/12/2.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "DataBaseIO.h"

@class SJBook;

@interface SJBookRecode : DataBaseIO
+(void)initDB;
+(BOOL)hasInstall;
+(void)insertBook:(SJBook*)book;
+(void)deleteBook:(NSInteger)nid;
+(NSArray *)getBooks;

@end

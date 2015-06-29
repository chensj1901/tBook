//
//  SJBookChapterRecode.h
//  tBook
//
//  Created by 陈少杰 on 15/1/23.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "DataBaseIO.h"
#import "SJBookChapter.h"

@interface SJBookChapterRecode : DataBaseIO
+(void)initDB;
+(void)insertBookChapter:(SJBookChapter*)obj;
+(NSArray *)getBookChaptersByNid:(NSInteger)nid;
+(void)deleteBookChapter:(NSInteger)nid chapterName:(NSString *)chapterName;
+(void)insertBookChapters:(NSArray *)bookChapters;

@end

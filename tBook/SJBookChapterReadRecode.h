//
//  SJBookChapterRecode.h
//  tBook
//
//  Created by 陈少杰 on 14/12/3.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "DataBaseIO.h"
@class SJBookChapter;

@interface SJBookChapterReadRecode : DataBaseIO
+(void)initDB;
+(void)insertBookChapter:(SJBookChapter*)obj;
+(void)insertBookChapters:(NSArray *)bookChapters;
+(NSDictionary *)getBookChapterByNid:(NSInteger)nid;
+(void)deleteBookChapter:(NSInteger)nid chapterName:(NSString *)chapterName;

@end

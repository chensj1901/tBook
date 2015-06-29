//
//  SJBookChapterRecode.m
//  tBook
//
//  Created by 陈少杰 on 14/12/3.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookChapterReadRecode.h"
#import "SJBookChapter.h"

@implementation SJBookChapterReadRecode
+(void)initDB{
    if (![self hasInstall]) {
        NSString *sql=@"CREATE TABLE `BOOK_CHAPTER_READ` (`time` integer,`sort` integer,`nid` integer,`site` varchar(0,255),`gsort` integer,`chapterName` varchar(0,255),`ctype` varchar(0,255),`paid` integer,`curl` varchar(0,255),`charge` integer,`gid` integer, `pageIndex` integer, PRIMARY KEY(`gid`))";
        [self executeUpdate:sql];
    }
    
}


+(BOOL)hasInstall{
    NSString *sql=@"select count(*) from `BOOK_CHAPTER_READ`";
    return [[self executeQuery:sql]count]>0;
}

+(void)insertBookChapter:(SJBookChapter*)obj{
    NSString *sql=[NSString stringWithFormat:@"replace into `BOOK_CHAPTER_READ` ( time,sort,nid,site,gsort,chapterName,ctype,paid,curl,charge,gid,pageIndex ) values (%ld,%ld,%ld,'%@',%ld,'%@','%@',%ld,'%@',%ld,%ld,%ld) ",(long)obj.time,(long)obj.sort,(long)obj.nid,obj.site,(long)obj.gsort,obj.chapterName,obj.ctype,(long)obj.paid,obj.curl,(long)obj.charge,(long)obj.gid,(long)obj.pageIndex];
    [self executeUpdate:sql];
}


+(NSDictionary *)getBookChapterByNid:(NSInteger)nid{
    NSString *sql=[NSString stringWithFormat:@"select * from `BOOK_CHAPTER_READ` where nid=%ld",(long)nid];
    NSDictionary *sqlResult=[[self executeQuery:sql]safeObjectAtIndex:0];
    return sqlResult;
}

+(void)deleteBookChapter:(NSInteger)nid chapterName:(NSString *)chapterName{
    NSString *sql=[NSString stringWithFormat:@"delete from `BOOK_CHAPTER_READ` where nid=%ld and chapterName=%@",(long)nid,chapterName];
    [self executeUpdate:sql];
}


@end

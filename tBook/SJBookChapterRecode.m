//
//  SJBookChapterRecode.m
//  tBook
//
//  Created by 陈少杰 on 15/1/23.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookChapterRecode.h"

@implementation SJBookChapterRecode
+(void)initDB{
    if (![self hasInstall]) {
        NSString *sql=@"CREATE TABLE `BOOK_CHAPTER` (`time` integer,`sort` integer,`nid` integer,`site` varchar(0,255),`gsort` integer,`chapterName` varchar(0,255),`ctype` varchar(0,255),`paid` integer,`curl` varchar(0,255),`charge` integer,`gid` integer, `index` integer, PRIMARY KEY(`chapterName`))";
        [self executeUpdate:sql];
    }
    
}


+(BOOL)hasInstall{
    NSString *sql=@"select count(*) from `BOOK_CHAPTER`";
    return [[self executeQuery:sql]count]>0;
}

+(void)insertBookChapter:(SJBookChapter*)obj{
    NSString *sql=[NSString stringWithFormat:@"replace into `BOOK_CHAPTER` ( time,sort,nid,site,gsort,chapterName,ctype,paid,curl,charge,gid,`index` ) values (%ld,%ld,%ld,'%@',%ld,'%@','%@',%ld,'%@',%ld,%ld,%ld) ",(long)obj.time,(long)obj.sort,(long)obj.nid,obj.site,(long)obj.gsort,obj.chapterName,obj.ctype,(long)obj.paid,obj.curl,(long)obj.charge,(long)obj.gid,(long)obj._id];
    [self executeUpdate:sql];
}


+(NSArray *)getBookChaptersByNid:(NSInteger)nid{
    NSString *sql=[NSString stringWithFormat:@"select * from `BOOK_CHAPTER` where nid=%ld",(long)nid];
    NSArray *sqlResult=[self executeQuery:sql];
    return sqlResult;
}

+(void)deleteBookChapter:(NSInteger)nid chapterName:(NSString *)chapterName{
    NSString *sql=[NSString stringWithFormat:@"delete from `BOOK_CHAPTER` where nid=%ld and chapterName=%@",(long)nid,chapterName];
    [self executeUpdate:sql];
}

+(void)insertBookChapters:(NSArray *)bookChapters{
    FMDatabase *db=[self getDB];
    [db open];
    [db beginTransaction];
    @try {
        for (SJBookChapter *obj in bookChapters) {
            NSString *sql=[NSString stringWithFormat:@"replace into `BOOK_CHAPTER` ( time,sort,nid,site,gsort,chapterName,ctype,paid,curl,charge,gid,`index` ) values (%ld,%ld,%ld,'%@',%ld,'%@','%@',%ld,'%@',%ld,%ld,%ld) ",(long)obj.time,(long)obj.sort,(long)obj.nid,obj.site,(long)obj.gsort,obj.chapterName,obj.ctype,(long)obj.paid,obj.curl,(long)obj.charge,(long)obj.gid,(long)obj._id];
            [db executeUpdate:sql];
        }
    }
    @catch (NSException *exception) {
        [db rollback];
    }
    @finally {
        [db commit];
    }
    
    [db close];
}
@end

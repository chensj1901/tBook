//
//  SJBookRecode.m
//  tBook
//
//  Created by 陈少杰 on 14/12/2.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookRecode.h"
#import "SJBook.h"

@implementation SJBookRecode
+(void)initDB{
    if (![self hasInstall]) {
        NSString *sql=@"CREATE TABLE `BOOK` (`name` varchar(0,255),`classes` varchar(0,255),`desc` varchar(0,255),`status` varchar(0,255),`gid` integer,`category` varchar(0,255),`nid` integer,`author` varchar(0,255),`site` varchar(0,255),`imgUrl` text,`lastChapterName` varchar(0,255),`chapterCount` integer,`lastTime` varchar(0,255),`subscribeCount` integer,`siteCount` integer,`charge` varchar(0,255) ,PRIMARY KEY(`nid`))";
        [self executeUpdate:sql];
    }
}


+(BOOL)hasInstall{
    NSString *sql=@"select count(*) from `BOOK`";
    return [[self executeQuery:sql]count]>0;
}

+(void)insertBook:(SJBook*)obj{
    NSString *sql=[NSString stringWithFormat:@"replace into `BOOK` ( name,classes,desc,status,gid,category,nid,author,site,imgUrl,lastChapterName,chapterCount,lastTime,subscribeCount,siteCount,charge ) values ('%@','%@','%@','%@',%ld,'%@',%ld,'%@','%@','%@','%@',%ld,'%ld',%ld,%ld,'%@') ",obj.name,obj.classes,obj.desc,obj.status,(long)obj.gid,obj.category,(long)obj.nid,obj.author,obj.site,obj.imgUrl,obj.lastChapterName,(long)obj.chapterCount,(long)obj.lastTime,(long)obj.subscribeCount,(long)obj.siteCount,obj.charge];
    [self executeUpdate:sql];
}


+(NSArray *)getBooks{
    NSString *sql=@"select * from `BOOK`";
    NSArray *sqlResult=[self executeQuery:sql];
    return sqlResult;
}

+(void)deleteBook:(NSInteger)nid{
    NSString *sql=[NSString stringWithFormat:@"delete from `BOOK` where nid=%ld",(long)nid];
    [self executeUpdate:sql];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

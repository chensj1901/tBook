//
//  SJBookChapter.m
//  tBook
//
//  Created by 陈少杰 on 14/11/25.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookChapter.h"

@implementation SJBookChapter

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        _time = [[dictionary objectForKey:@"time"]integerValue];
        _sort = [[dictionary objectForKey:@"sort"]integerValue];
        _nid = [[dictionary objectForKey:@"nid"]integerValue];
        _site = [dictionary objectForKey:@"site"];
        _gsort = [[dictionary objectForKey:@"gsort"]integerValue];
        _chapterName = [dictionary objectForKey:@"chapter_name"];
        _ctype = [dictionary objectForKey:@"ctype"];
        _paid = [[dictionary objectForKey:@"paid"]integerValue];
        _curl = [dictionary objectForKey:@"curl"];
        _charge = [[dictionary objectForKey:@"charge"]integerValue];
    }
    return self;
}

-(id)initWithLocalDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        _time = [[dictionary objectForKey:@"time"]integerValue];
        _sort = [[dictionary objectForKey:@"sort"]integerValue];
        _nid = [[dictionary objectForKey:@"nid"]integerValue];
        _site = [dictionary objectForKey:@"site"];
        _gsort = [[dictionary objectForKey:@"gsort"]integerValue];
        _chapterName = [dictionary objectForKey:@"chapterName"];
        _ctype = [dictionary objectForKey:@"ctype"];
        _paid = [[dictionary objectForKey:@"paid"]integerValue];
        _curl = [dictionary objectForKey:@"curl"];
        _charge = [[dictionary objectForKey:@"charge"]integerValue];
    }
    return self;
}

-(NSString *)filePathWithThisChapter{
   NSString *filePath=[NSFileManager getTempFilePath:[NSString stringWithFormat:@"%ld$$%@$$%@.txt",(long)self.nid,self.site,self.chapterName]];
    return filePath;
}

-(NSMutableArray *)pageArr{
    if(!_pageArr){
        _pageArr=[[NSMutableArray alloc]init];
    }
    return _pageArr;
}
@end

//
//  SJBook.m
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBook.h"

@implementation SJBook
-(id)initWithRemoteDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        _name = [dictionary objectForKey:@"name"];
        _classes = [dictionary objectForKey:@"classes"];
        _desc = [dictionary objectForKey:@"desc"];
        _status = [dictionary objectForKey:@"status"];
        _gid = [[dictionary objectForKey:@"gid"]integerValue];
        _category = [dictionary objectForKey:@"category"];
        _nid = [[dictionary objectForKey:@"nid"]integerValue];
        _author = [dictionary objectForKey:@"author"];
        _site = [dictionary objectForKey:@"site"];
        _imgUrl = [dictionary objectForKey:@"imgUrl"];
        _lastChapterName = [dictionary objectForKey:@"lastChapterName"];
        _chapterCount = [[dictionary objectForKey:@"chapterCount"]integerValue];
        _lastTime = [[dictionary objectForKey:@"lastTime"]integerValue];
        _subscribeCount = [[dictionary objectForKey:@"subscribeCount"]integerValue];
        _siteCount = [[dictionary objectForKey:@"siteCount"]integerValue];
        _charge = [dictionary objectForKey:@"charge"];
    }
    return self;
}

-(id)initWithQidianBook:(SJQidianBook *)qidianBook{
    if (self=[super init]) {
        _name=qidianBook.bookName;
        _author=qidianBook.AuthorName;
        _lastChapterName=qidianBook.isVip?qidianBook.lastVipUpdateChapterName:qidianBook.lastUpdateChapterName;
        _imgUrl=[NSString stringWithFormat:@"http://image.cmfu.com/books/%ld/%ld.jpg",(long)qidianBook.bookId,(long)qidianBook.bookId];
        
    }
    return self;

}
@end

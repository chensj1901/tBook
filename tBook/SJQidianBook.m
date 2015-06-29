//
//  SJQidianBook.m
//  tBook
//
//  Created by 陈少杰 on 15/3/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJQidianBook.h"

@implementation SJQidianBook
-(id)initWithRemoteDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        _extraValue = [[dictionary objectForKey:@"ExtraValue"]integerValue];
        _extraName = [dictionary objectForKey:@"ExtraName"];
        _bookId = [[dictionary objectForKey:@"BookId"]integerValue];
        _bookName = [dictionary objectForKey:@"BookName"];
        _AuthorId = [[dictionary objectForKey:@"AuthorId"]integerValue];
        _AuthorName = [dictionary objectForKey:@"AuthorName"];
        _imageStatus = [dictionary objectForKey:@"ImageStatus"];
        _lastUpdateChapterID = [dictionary objectForKey:@"LastUpdateChapterID"];
        _lastUpdateChapterName = [dictionary objectForKey:@"LastUpdateChapterName"];
        _lastChapterUpdateTime = [[dictionary objectForKey:@"LastChapterUpdateTime"]integerValue];
        _isVip = [[dictionary objectForKey:@"IsVip"]integerValue];
        _lastVipUpdateChapterId = [[dictionary objectForKey:@"LastVipUpdateChapterId"]integerValue];
        _lastVipUpdateChapterName = [dictionary objectForKey:@"LastVipUpdateChapterName"];
        _lastVipChapterUpdateTime = [[dictionary objectForKey:@"LastVipChapterUpdateTime"]integerValue];
        _bookStatus = [dictionary objectForKey:@"BookStatus"];
        _enableBookUnitLease = [dictionary objectForKey:@"EnableBookUnitLease"];
        _enableBookUnitBuy = [dictionary objectForKey:@"EnableBookUnitBuy"];
        _bssReadTotal = [dictionary objectForKey:@"BssReadTotal"];
        _bssRecomTotal = [[dictionary objectForKey:@"BssRecomTotal"]integerValue];
    }
    return self;
}
@end

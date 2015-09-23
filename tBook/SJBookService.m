//
//  SJBookService.m
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookService.h"
#import "SJBookChapter.h"
#import "SJBookRecode.h"
#import "SJBookChapterReadRecode.h"
//#import "SJReadCell.h"
#import "SJHTTPRequestOperationManager.h"
#import "SJBookURLRequest.h"
#import "SJBookChapterRecode.h"
#import "SJSettingRecode.h"

@interface SJBookService ()

@end

@implementation SJBookService
-(void)loadFirstBooksWithKeyWord:(NSString*)keyWorld success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    self.searchKeyPageId=1;
    [SJBookURLRequest apiLoadFirstBooksWithKeyWord:keyWorld pageId:self.searchKeyPageId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.searchResultBooks removeAllObjects];
        
        for (NSDictionary *dic in [responseObject objectForKey:@"items"]) {
            SJBook *book=[[SJBook alloc]initWithRemoteDictionary:dic];
            [self.searchResultBooks addObject:book];
        }
        
        if ([[responseObject objectForKey:@"items"]count]==0) {
            alert(@"没有更多了");
        }else{
            self.searchKeyPageId++;
        }
        
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            fail(error);
        }
    }];
}

-(void)loadMoreBooksWithKeyWord:(NSString*)keyWorld success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
       [SJBookURLRequest apiLoadFirstBooksWithKeyWord:keyWorld pageId:self.searchKeyPageId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.searchKeyTotal=[[responseObject objectForKey:@"total"]integerValue];
        
        for (NSDictionary *dic in [responseObject objectForKey:@"items"]) {
            SJBook *book=[[SJBook alloc]initWithRemoteDictionary:dic];
            [self.searchResultBooks addObject:book];
        }
        
        if ([[responseObject objectForKey:@"items"]count]==0) {
            alert(@"没有更多了");
        }else{
            
            self.searchKeyPageId++;
        }
        
        if (success) {
            success();
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            fail(error);
        }
    }];
}

-(void)loadSearchHintWithKey:(NSString *)keyWord success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJBookURLRequest apiLoadSearchHintBooksWithKeyWord:keyWord success:^(AFHTTPRequestOperation  *operation, id responseObject) {
        [self.searchHintBooks removeAllObjects];
        
        for (NSString *bookName in [responseObject safeObjectForKey:@"items"]) {
            SJBook *book=[[SJBook alloc]init];
            book.name=bookName;
            [self.searchHintBooks addObject:book];
        }
        if(success){
            success();
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (error) {
            fail(error);
        }
    }];
}

-(void)loadBookDetailWithGid:(NSInteger)gid  cacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJBookURLRequest apiLoadBookDetailWithGid:gid cacheMethod:cacheMethod success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.searchKeyTotal=[[responseObject objectForKey:@"total"]integerValue];
        
        for (NSDictionary *dic in [responseObject objectForKey:@"items"]) {
            SJBook *book=[[SJBook alloc]initWithRemoteDictionary:dic];
            [self.searchResultBooks addObject:book];
        }
        
        if ([[responseObject objectForKey:@"items"]count]==0) {
            alert(@"没有更多了");
        }else{
            
            self.searchKeyPageId++;
        }
        
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            fail(error);
        }
    }];
}

-(NSArray*)getPagesOfString:(NSString*)text withFont:(UIFont*)font inRect:(CGRect)r{
    NSMutableArray *arr=[NSMutableArray new];
    unsigned long long offset = 0;
    while (YES) {
        unsigned long long start = offset;
        unsigned long long fileSize = text.length;
        
        NSUInteger MaxWidth = r.size.width, MaxHeigth = r.size.height;
        
        BOOL isEndOfFile = NO;
        NSUInteger length = 1000;
        NSMutableString *labelStr = [[NSMutableString alloc] init];
        do{
                if (offset+length > fileSize&&offset<fileSize) {
                    length=(NSUInteger)(fileSize-offset);
                }else if ((offset+length) > fileSize) {
                    offset = fileSize;
                    length = 0;
                    isEndOfFile = YES;
                }
            
                NSString *iStr=[text substringWithRange:NSMakeRange(offset, length)];
                if (iStr.length) {
                    if (iStr ) {
                        NSString *oStr = [NSString stringWithFormat:@"%@%@",labelStr,iStr];
                        
                        CGSize labelSize=[oStr sizeWithFont:font
                                          constrainedToSize:CGSizeMake(MaxWidth,8888)
                                              lineBreakMode:NSLineBreakByWordWrapping];
                        //                    NSLog(@"%f",labelSize.height);
                        if (labelSize.height-MaxHeigth > 0 && length != 1) {
                            //						if (length <= 5) {
                            //							length = 1;
                            //						}else {
                            length = length/(2);
                            //						}
                        }else if (labelSize.height > MaxHeigth && length == 1) {
//                            offset = offset-length;
                            isEndOfFile = YES;
                        }else if(labelSize.height <= MaxHeigth ) {
                            [labelStr appendString:iStr];
                            offset = length+offset;
                        }
                    }
                }
            
            if (offset >= fileSize) {
                isEndOfFile = YES;
            }		
        }while (!isEndOfFile);
        
        NSRange range=NSMakeRange(start, offset-start);
        [arr addObject:[NSValue valueWithRange:range]];
        if (offset >= fileSize) {
            break;
        }
    }
    
    return arr;
}

-(void)loadContentWithChapter:(SJBookChapter *)chapter book:(SJBook *)book success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [self loadContentWithChapter:chapter book:book shouldFormatPage:YES success:success fail:fail];
}

-(void)loadContentWithChapter:(SJBookChapter *)chapter book:(SJBook *)book shouldFormatPage:(BOOL)shouldFormatPage success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    
    [SJBookChapterReadRecode insertBookChapter:chapter];
    [SJBookURLRequest apiLoadContentWithChapter:chapter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (shouldFormatPage) {
            NSString *text=[responseObject objectForKey:@"content"];
            NSArray *pages=[self getPagesOfString:text withFont:[UIFont systemFontOfSize:[[SJSettingRecode getSet:@"textFont"]intValue]] inRect:CGRectMake(0, 0, WIDTH-20, HEIGHT-60)];
            
            [[text dataUsingEncoding:NSUTF8StringEncoding]writeToFile:chapter.filePathWithThisChapter atomically:YES];
            [chapter.pageArr removeAllObjects];
            [chapter.pageArr addObjectsFromArray:pages];
        }
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];

}

-(void)loadBookChapterWithBook:(SJBook*)book cacheMethod:(SJCacheMethod)cacheMethod  success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJBookURLRequest apiLoadBookChapterWithBook:book cacheMethod:cacheMethod success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.bookChapters removeAllObjects];
        
        NSInteger index=0;
        for (NSDictionary *dic in [responseObject objectForKey:@"items"]) {
            SJBookChapter *bookChapter=[[SJBookChapter alloc]initWithRemoteDictionary:dic];
            bookChapter.gid=book.gid;
            bookChapter._id=index;
            [self.bookChapters addObject:bookChapter];
            index++;
        }
        
        if ([[responseObject objectForKey:@"items"]count]==0) {
            alert(@"没有更多了");
        }
        
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)loadLocalBooksWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [self.locaBooks removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *bookDicArr=[SJBookRecode getBooks];
        for (NSDictionary *bookDic in bookDicArr) {
            SJBook *book=[[SJBook alloc]initWithRemoteDictionary:bookDic];
            book.isLoadingLastChapterName=YES;
            [self.locaBooks addObject:book];
            
            NSDictionary *bookChapterDic=[SJBookChapterReadRecode getBookChapterByNid:book.nid];
            if (bookChapterDic) {
                book.readingChapter=[[SJBookChapter alloc]initWithLocalDictionary:bookChapterDic];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success();
            }
        });
    });
}

-(void)updateNextOrPreviousChapterWithChapter:(SJBookChapter *)chapter book:(SJBook*)book success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [self loadBookChapterWithBook:book cacheMethod:SJCacheMethodCacheFirst success:^{
        int thisIndex=-1;
        for (int i=0; i<[self.bookChapters count]; i++) {
            SJBookChapter *iChapter=self.bookChapters[i];
            if ([iChapter.chapterName isEqualToString:chapter.chapterName]) {
                thisIndex=i;
            }
        }
        if (thisIndex==-1) {
            if (fail) {
                fail(nil);
            }
        }else{
            self.previousChapter=[self.bookChapters safeObjectAtIndex:thisIndex-1];
            self.thisChapter=chapter;
            self.nextChapter=[self.bookChapters safeObjectAtIndex:thisIndex+1];
            if (success) {
                success();
            }
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];

}

-(NSMutableArray *)searchHintBooks{
    if (!_searchHintBooks) {
        _searchHintBooks=[NSMutableArray new];
    }
    return _searchHintBooks;
}

-(NSMutableArray *)locaBooks{
    if (!_locaBooks) {
        _locaBooks=[[NSMutableArray alloc]init];
    }
    return _locaBooks;
}


-(NSMutableArray *)searchResultBooks{
    if (!_searchResultBooks) {
        _searchResultBooks=[[NSMutableArray alloc]init];
    }
    return _searchResultBooks;
}

-(NSMutableArray *)bookChapters{
    if (!_bookChapters) {
        _bookChapters=[[NSMutableArray alloc]init];
    }
    return _bookChapters;
}

-(NSString *)udid{
   return  [[UIDevice currentDevice].identifierForVendor.UUIDString md5Encode];
}

-(void)deleteLocalBookWithBook:(SJBook *)book{
    [self.locaBooks removeObject:book];
    [SJBookRecode deleteBook:book.nid];
}

@end




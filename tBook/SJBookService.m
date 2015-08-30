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
#import "SJReadCell.h"
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
                            offset = offset-length;
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
    [SJBookURLRequest apiLoadContentWithChapter:chapter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *text=[responseObject objectForKey:@"content"];
        
        NSArray *pages=[self getPagesOfString:text withFont:[UIFont systemFontOfSize:[[SJSettingRecode getSet:@"textFont"]intValue]] inRect:CGRectMake(0, 0, WIDTH-20, HEIGHT-28)];
        
        [[text dataUsingEncoding:NSUTF8StringEncoding]writeToFile:chapter.filePathWithThisChapter atomically:YES];
        
        [chapter.pageArr removeAllObjects];
        [chapter.pageArr addObjectsFromArray:pages];
//        __weak SJBookService*__self=self;
        
        
//        self.book=[[KDBook alloc]initWithBook:chapter.filePathWithThisChapter successBlock:^{
//            chapter.kdBook=__self.book;
            if (success) {
                success();
            }
//        }];
//        self.book.bookChapterName=chapter.chapterName;
//        
//        SJReadCell *sizeTestCell=[[SJReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        self.book.pageSize =sizeTestCell.bookContentLabel.bounds.size; //bookLabel.frame.size;
//        self.book.textFont = sizeTestCell.bookContentLabel.font;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];

}

-(void)loadContentWithChapter:(SJBookChapter*)chapter book:(SJBook*)book  success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail nextSuccess:(SJServiceSuccessBlock)nextSuccess previousSuccess:(SJServiceSuccessBlock)preSuccess{
    
    [SJBookChapterReadRecode insertBookChapter:chapter];
    
    
    [SJBookURLRequest apiLoadContentWithChapter:chapter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *text=[[[responseObject objectForKey:@"items"]objectAtIndex:0] objectForKey:@"content"];
        
        [[text dataUsingEncoding:NSUTF8StringEncoding]writeToFile:chapter.filePathWithThisChapter atomically:YES];
        
        self.book=[[KDBook alloc]initWithBook:chapter.filePathWithThisChapter successBlock:^{
            if (success) {
                success();
            }
        }];
        self.book.bookChapterName=chapter.chapterName;
        
        SJReadCell *sizeTestCell=[[SJReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.book.pageSize =sizeTestCell.bookContentLabel.bounds.size; //bookLabel.frame.size;
        self.book.textFont = sizeTestCell.bookContentLabel.font;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
    
    
    // 更新附近两章缓存
    [self updateNextOrPreviousChapterWithChapter:chapter book:book success:^{
        [SJBookURLRequest apiLoadContentWithChapter:self.previousChapter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *text=[[[responseObject objectForKey:@"items"]objectAtIndex:0] objectForKey:@"content"];
            
            [[text dataUsingEncoding:NSUTF8StringEncoding]writeToFile:self.previousChapter.filePathWithThisChapter atomically:YES];
            
            self.previousBook=[[KDBook alloc]initWithBook:self.previousChapter.filePathWithThisChapter successBlock:^{
                if (preSuccess) {
                    preSuccess();
                }
            }];
            self.previousBook.bookChapterName=self.previousChapter.chapterName;
            SJReadCell *sizeTestCell=[[SJReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            self.previousBook.pageSize =sizeTestCell.bookContentLabel.bounds.size; //bookLabel.frame.size;
            self.previousBook.textFont = sizeTestCell.bookContentLabel.font;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
        [SJBookURLRequest apiLoadContentWithChapter:self.nextChapter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *text=[[[responseObject objectForKey:@"items"]objectAtIndex:0] objectForKey:@"content"];
            
            [[text dataUsingEncoding:NSUTF8StringEncoding]writeToFile:self.nextChapter.filePathWithThisChapter atomically:YES];
            
            self.nextBook=[[KDBook alloc]initWithBook:self.nextChapter.filePathWithThisChapter successBlock:^{
                if (nextSuccess) {
                    nextSuccess();
                }
            }];
            self.nextBook.bookChapterName=self.nextChapter.chapterName;
            
            SJReadCell *sizeTestCell=[[SJReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            self.nextBook.pageSize =sizeTestCell.bookContentLabel.bounds.size; //bookLabel.frame.size;
            self.nextBook.textFont = sizeTestCell.bookContentLabel.font;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    } fail:^(NSError *error) {
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *bookDicArr=[SJBookRecode getBooks];
        for (NSDictionary *bookDic in bookDicArr) {
            SJBook *book=[[SJBook alloc]initWithRemoteDictionary:bookDic];
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



@end




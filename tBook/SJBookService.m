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

-(NSArray*)getPagesOfString:(NSString*)cache withFont:(UIFont*)font inRect:(CGRect)r{
    //返回一个数组, 包含每一页的字符串开始点和长度(NSRange)
    NSMutableArray *ranges=[NSMutableArray array];
    //断行类型
    UILineBreakMode lineBreakMode=UILineBreakModeCharacterWrap;
    //显示字体的行高
    CGFloat lineHeight=[@"Sample样本" sizeWithFont:font].height;
    NSInteger maxLine=floor(r.size.height/lineHeight);
    NSInteger totalLines=0;
    NSLog(@"Max Line Per Page: %ld (%.2f/%.2f)",(long)maxLine,r.size.height,lineHeight);
    NSString *lastParaLeft=nil;
    NSRange range=NSMakeRange(0, 0);
    //把字符串按段落分开, 提高解析效率
    NSArray *paragraphs=[cache componentsSeparatedByString:@"n"];
    for (int p=0;p< [paragraphs count];p++) {
        NSString *para;
        if (lastParaLeft!=nil) {
            //上一页完成后剩下的内容继续计算
            para=lastParaLeft;
            lastParaLeft=nil;
        }else {
            para=[paragraphs objectAtIndex:p];
            if (p<[paragraphs count]-1)
                para=[para stringByAppendingString:@"n"]; //刚才分段去掉了一个换行,现在换给它
        }
        CGSize paraSize=[para sizeWithFont:font
                         constrainedToSize:r.size
                             lineBreakMode:lineBreakMode];
        NSInteger paraLines=floor(paraSize.height/lineHeight);
        if (totalLines+paraLines<maxLine) {
            totalLines+=paraLines;
            range.length+=[para length];
            if (p==[paragraphs count]-1) {
                //到了文章的结尾 这一页也算
                [ranges addObject:[NSValue valueWithRange:range]];
                //IMILog(@”===========Page Over=============”);
            }
        }else if (totalLines+paraLines==maxLine) {
            //很幸运, 刚好一段结束,本页也结束, 有这个判断会提高一定的效率
            range.length+=[para length];
            [ranges addObject:[NSValue valueWithRange:range]];
            range.location+=range.length;
            range.length=0;
            totalLines=0;
            //IMILog(@”===========Page Over=============”);
        }else{
            //重头戏, 页结束时候本段文字还有剩余
            NSInteger lineLeft=maxLine-totalLines;
            CGSize tmpSize;
            NSInteger i;
            for (i=1; i<[para length]; i++) {
                //逐字判断是否达到了本页最大容量
                NSString *tmp=[para substringToIndex:i];
                tmpSize=[tmp sizeWithFont:font  
                        constrainedToSize:r.size  
                            lineBreakMode:lineBreakMode];  
                int nowLine=floor(tmpSize.height/lineHeight);  
                if (lineLeft<nowLine) {  
                    //超出容量,跳出, 字符要回退一个, 应为当前字符已经超出范围了  
                    lastParaLeft=[para substringFromIndex:i-1];  
                    break;  
                }  
            }  
            range.length+=i-1;  
            [ranges addObject:[NSValue valueWithRange:range]];  
            range.location+=range.length;  
            range.length=0;  
            totalLines=0;  
            p--;
            //IMILog(@”===========Page Over=============”);  
        }  
        
    }  
    return [NSArray arrayWithArray:ranges];  
}

-(void)loadContentWithChapter:(SJBookChapter *)chapter book:(SJBook *)book success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJBookURLRequest apiLoadContentWithChapter:chapter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *text=[[[responseObject objectForKey:@"items"]objectAtIndex:0] objectForKey:@"content"];
        
        NSArray *pages=[self getPagesOfString:text withFont:[UIFont boldSystemFontOfSize:12] inRect:CGRectMake(0, 0, WIDTH, HEIGHT)];
        
        [[text dataUsingEncoding:NSUTF8StringEncoding]writeToFile:chapter.filePathWithThisChapter atomically:YES];
        __weak SJBookService*__self=self;
        
        
        self.book=[[KDBook alloc]initWithBook:chapter.filePathWithThisChapter successBlock:^{
            chapter.kdBook=__self.book;
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
            SJBookChapter *book=[[SJBookChapter alloc]initWithRemoteDictionary:dic];
            book._id=index;
            [self.bookChapters addObject:book];
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




//
//  SJBookService.h
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJService.h"
#import "SJBook.h"
#import "SJBookChapter.h"
#import "SJHTTPRequestOperationManager.h"

@interface SJBookService : SJService
@property(nonatomic)NSInteger searchKeyPageId;
@property(nonatomic)NSInteger searchKeyTotal;
@property(nonatomic)NSMutableArray *locaBooks;
@property(nonatomic)NSMutableArray *searchHintBooks;
@property(nonatomic)NSMutableArray *searchResultBooks;
@property(nonatomic)NSMutableArray *bookChapters;
@property(nonatomic)SJBookChapter *previousChapter;
@property(nonatomic)SJBookChapter *thisChapter;
@property(nonatomic)SJBookChapter *nextChapter;
@property(nonatomic)NSString *udid;

-(void)loadFirstBooksWithKeyWord:(NSString*)keyWorld success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)loadMoreBooksWithKeyWord:(NSString*)keyWorld success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)loadSearchHintWithKey:(NSString *)keyWord success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)loadBookDetailWithGid:(NSInteger)gid cacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;


-(void)loadBookChapterWithBook:(SJBook*)book cacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)loadLocalBooksWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)updateNextOrPreviousChapterWithChapter:(SJBookChapter*)chapter book:(SJBook*)book success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)loadContentWithChapter:(SJBookChapter*)chapter  book:(SJBook*)book success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;


-(void)loadContentWithChapter:(SJBookChapter*)chapter  book:(SJBook*)book shouldFormatPage:(BOOL)shouldFormatPage success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)deleteLocalBookWithBook:(SJBook *)book;
@end



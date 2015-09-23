//
//  SJBook.h
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJBookChapter.h"
#import "SJQidianBook.h"

@interface SJBook : NSObject

/**
 *	@brief "名字",
 */
@property(nonatomic)NSString *name;

/**
 *	@brief "类型",
 */
@property(nonatomic,readonly)NSString *classes;

/**
 *	@brief "描述",
 */
@property(nonatomic,readonly)NSString *desc;

/**
 *	@brief "状态",
 */
@property(nonatomic,readonly)NSString *status;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger gid;

/**
 *	@brief "分类",
 */
@property(nonatomic,readonly)NSString *category;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger nid;

/**
 *	@brief "作者",
 */
@property(nonatomic,readonly)NSString *author;

/**
 *	@brief "来源网站",
 */
@property(nonatomic,readonly)NSString *site;

/**
 *	@brief "封面图片",
 */
@property(nonatomic,readonly)NSString *imgUrl;

/**
 *	@brief "最新章节",
 */
@property(nonatomic)NSString *lastChapterName;

/**
 *	@brief "章节统计",
 */
@property(nonatomic,readonly)NSInteger chapterCount;

/**
 *	@brief "更新时间",
 */
@property(nonatomic,readonly)NSInteger lastTime;

/**
 *	@brief "关注人数",
 */
@property(nonatomic,readonly)NSInteger subscribeCount;

/**
 *	@brief "来源统计",
 */
@property(nonatomic,readonly)NSInteger siteCount;

/**
 *	@brief "价格"
 */
@property(nonatomic,readonly)NSString *charge;

/**
 *	@brief	当前阅读章节
 */
@property(nonatomic)SJBookChapter *readingChapter;


@property(nonatomic)BOOL isLoadingLastChapterName;

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary;
-(id)initWithQidianBook:(SJQidianBook*)qidianBook;

@end

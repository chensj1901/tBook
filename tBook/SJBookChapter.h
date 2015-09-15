//
//  SJBookChapter.h
//  tBook
//
//  Created by 陈少杰 on 14/11/25.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJBookChapter : NSObject

/**
 *	@brief 时间
 */
@property(nonatomic,readonly)NSInteger time;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger sort;

/**
 *	@brief 小说ID
 */
@property(nonatomic,readonly)NSInteger nid;

/**
 *	@brief 来源网址
 */
@property(nonatomic,readonly)NSString *site;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger gsort;

/**
 *	@brief 章节名字
 */
@property(nonatomic,readonly)NSString *chapterName;

/**
 *	@brief 类型
 */
@property(nonatomic,readonly)NSString *ctype;

/**
 *	@brief 价格
 */
@property(nonatomic,readonly)NSInteger paid;

/**
 *	@brief 章节网址
 */
@property(nonatomic,readonly)NSString *curl;

/**
 *	@brief 价格
 */
@property(nonatomic,readonly)NSInteger charge;

/**
 *	@brief 
 */
@property(nonatomic)NSInteger gid;

@property(nonatomic)NSInteger _id;

@property(nonatomic)NSInteger pageIndex;

@property(nonatomic)NSMutableArray *pageArr;

@property(nonatomic)BOOL isSelected;

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary;
-(id)initWithLocalDictionary:(NSDictionary *)dictionary;
-(NSString *)filePathWithThisChapter;
@end

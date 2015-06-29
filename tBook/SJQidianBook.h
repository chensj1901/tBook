//
//  SJQidianBook.h
//  tBook
//
//  Created by 陈少杰 on 15/3/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJQidianBook : NSObject

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger extraValue;

/**
 *	@brief "月票数："
 */
@property(nonatomic,readonly)NSString *extraName;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger bookId;

/**
 *	@brief "天醒之路"
 */
@property(nonatomic,readonly)NSString *bookName;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger AuthorId;

/**
 *	@brief "蝴蝶蓝"
 */
@property(nonatomic,readonly)NSString *AuthorName;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *imageStatus;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *lastUpdateChapterID;

/**
 *	@brief ""
 */
@property(nonatomic,readonly)NSString *lastUpdateChapterName;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger lastChapterUpdateTime;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger isVip;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger lastVipUpdateChapterId;

/**
 *	@brief "第二百七十七章  偷袭"
 */
@property(nonatomic,readonly)NSString *lastVipUpdateChapterName;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger lastVipChapterUpdateTime;

/**
 *	@brief "新书上传"
 */
@property(nonatomic,readonly)NSString *bookStatus;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *enableBookUnitLease;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *enableBookUnitBuy;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *bssReadTotal;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger bssRecomTotal;

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary;
@end

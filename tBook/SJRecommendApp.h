//
//  SJRecommendApp.h
//  zhitu
//
//  Created by 陈少杰 on 13-12-1.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJRecommendApp : NSObject
/**
 *	@brief	id
 */
@property(nonatomic)NSInteger _id;

/**
 *	@brief	应用名称
 */
@property(nonatomic)NSString *appName;
/**
 *	@brief	应用图标
 */
@property(nonatomic)NSString *appIcon;

/**
 *	@brief	应用描述
 */
@property(nonatomic)NSString *appDesc;

/**
 *	@brief	应用市场链接
 */
@property(nonatomic)NSString *url;

/**
 *	@brief	初始化
 *
 *	@param 	dictionary 	<#dictionary description#>
 *
 *	@return	<#return value description#>
 */
-(id)initWithDictionary:(NSDictionary*)dictionary;

-(id)initWithAdwoDictionary:(NSDictionary *)dictionary;
@end

//
//  SJPushRecode.h
//  zhitu
//
//  Created by 陈少杰 on 13-9-12.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseIO.h"

enum EditFromWhich {
    EditFromWhich_Tab = 0,
    EditFromWhich_Draft = 1,
    EditFromWhich_Activity = 2,
    };

typedef enum EditFromWhich EditFromWhich;

/**
 *	@brief	保存本地永久设置的专用类
 */
@interface SJSettingRecode : DataBaseIO

+(void)initDB;
+(BOOL)hasInstall;
/**
 *	@brief	设置
 *
 *	@param 	settingName 	设置名称
 *	@param 	value 	值
 */
+(void)set:(NSString*)settingName value:(NSString*)value;

/**
 *	@brief	获取设置
 *
 *	@param 	settingName 	设置名称
 *
 *	@return	值
 */
+(NSString*)getSet:(NSString*)settingName;
@end

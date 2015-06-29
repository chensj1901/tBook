//
//  SJService.h
//  zhitu
//
//  Created by 陈少杰 on 14/7/11.
//  Copyright (c) 2014年 聆创科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJURLRequestMethodDefined.h"

typedef void(^SJServiceSuccessBlock)(void);
typedef void(^SJServiceFailBlock)(NSError *error);

@interface SJService : NSObject

@end

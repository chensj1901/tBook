//
//  SJBookCacheQueue.h
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJBookCacheOperation.h"

@interface SJBookCacheQueue : NSOperationQueue
+(SJBookCacheQueue *)queue;
@end

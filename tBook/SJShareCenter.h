//
//  SJShareCenter.h
//  Yunpan
//
//  Created by 陈少杰 on 15/8/4.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface SJShareCenter : NSObject
+(void)shareTo:(ShareType)shareType url:(NSString *)url content:(NSString *)content;
+(void)shareTo:(ShareType)shareType content:(NSString *)content;
@end

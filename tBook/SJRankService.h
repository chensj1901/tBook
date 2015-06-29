//
//  SJRankService.h
//  tBook
//
//  Created by 陈少杰 on 15/2/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJService.h"
#import "SJRankURLRequest.h"

@interface SJRankService : SJService
@property(nonatomic,readonly)NSMutableDictionary *books;

-(void)loadFirstQidianRankWithType:(SJQidianType)type success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;
-(void)loadMoreQidianRankWithType:(SJQidianType)type success:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;
@end

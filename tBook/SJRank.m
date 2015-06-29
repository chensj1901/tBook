
//
//  SJRank.m
//  tBook
//
//  Created by 陈少杰 on 15/3/31.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRank.h"

@implementation SJRank
+(SJRank *)rankWithName:(NSString *)rankName type:(SJQidianType)type rankImageName:(NSString *)rankImageName{
    SJRank *rank=[[SJRank alloc]init];
    rank.rankName=rankName;
    rank.rankType=type;
    rank.rankImageName=rankImageName;
    return rank;
}
@end

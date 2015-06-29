//
//  SJRankCell.h
//  tBook
//
//  Created by 陈少杰 on 15/5/12.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJRank.h"

@interface SJRankCell : SJCell
@property(nonatomic,readonly)UIImageView *iconImageView;
@property(nonatomic,readonly)UILabel *rankNameLabel;
@property(nonatomic,readonly)UIView *lineView;
+(CGFloat)cellHeight;
-(void)loadRank:(SJRank *)rank;
@end

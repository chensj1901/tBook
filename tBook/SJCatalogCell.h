//
//  SJCatalogCell.h
//  tBook
//
//  Created by 陈少杰 on 15/2/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJBookChapter.h"

@interface SJCatalogCell : SJCell
@property(nonatomic,readonly)UIImageView *tagImageView;
@property(nonatomic,readonly)UILabel *titleLabel;
@property(nonatomic,readonly)UIView *lineView;

+(CGFloat)cellHeight;
-(void)loadChapter:(SJBookChapter*)chapter;
@end

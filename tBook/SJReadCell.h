//
//  SJReaddingCell.h
//  tBook
//
//  Created by 陈少杰 on 14/12/4.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJCell.h"

@interface SJReadCell : SJCell
@property(nonatomic,readonly)UILabel *bookTitleLabel;
@property(nonatomic,readonly)UILabel *bookContentLabel;

-(void)setText:(NSString *)text;

+(CGFloat)cellHeight;

@end

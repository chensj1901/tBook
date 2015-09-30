//
//  SJSettingCell.h
//  Yunpan
//
//  Created by 陈少杰 on 15/8/5.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"

@interface SJSettingCell : SJCell
@property(nonatomic,readonly)UILabel *titleLabel;
@property(nonatomic,readonly)UIView *lineView;
+(CGFloat)cellHeight;
@end

//
//  SJSettingTextColorCell.h
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import <STColorPicker.h>

@interface SJSettingTextColorCell : SJCell
@property(nonatomic,readonly)UILabel *backgroundColorLabel;
@property(nonatomic,readonly)STColorPicker *backgroundColorSelectView;
+(CGFloat)cellHeight;
@end

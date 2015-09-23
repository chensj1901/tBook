//
//  SJSettingBackgroundCell.h
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import <STColorPicker.h>

@interface SJSettingBackgroundCell : SJCell
@property(nonatomic,readonly)UILabel *backgroundColorLabel;
@property(nonatomic,readonly)STColorPicker *backgroundColorSelectView;
@property(nonatomic,readonly)UIImageView *backgroundStyle1ImageView;
@property(nonatomic,readonly)UIImageView *backgroundStyle2ImageView;

+(CGFloat)cellHeight;
@end

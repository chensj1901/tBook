//
//  SJSettingFontCell.h
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"

@interface SJSettingFontCell : SJCell
@property(nonatomic,readonly)UILabel *fontSizeLabel;
@property(nonatomic,readonly)UISlider *fontSizeSlider;
@property(nonatomic,readonly)UILabel *fontPreviewLabel;
+(CGFloat)cellHeight;
@end

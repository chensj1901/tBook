//
//  SJSettingPreviewCell.h
//  tBook
//
//  Created by 陈少杰 on 15/9/22.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"

@interface SJSettingPreviewCell : SJCell
@property(nonatomic,readonly)UILabel *previewLabel;
@property(nonatomic,readonly)UIImageView *previewBackgroundImageView;
+(CGFloat)cellHeight;
-(void)refreshUI;
@end

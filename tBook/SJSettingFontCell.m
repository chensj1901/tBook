//
//  SJSettingFontCell.m
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJSettingFontCell.h"
#import "SJSettingRecode.h"

@implementation SJSettingFontCell
{
    CGRect _fontSizeLabelRect;
    CGRect _fontSizeSliderRect;
    CGRect _fontPreviewLabelRect;
}


@synthesize fontSizeLabel=_fontSizeLabel;
@synthesize fontSizeSlider=_fontSizeSlider;
@synthesize fontPreviewLabel=_fontPreviewLabel;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _fontSizeLabelRect= CGRectMake(10, 20,60, 15);
    _fontSizeSliderRect= CGRectMake(80, 20, WIDTH-100, 20);
    _fontPreviewLabelRect= CGRectMake(0, 0, 0, 0);
}

-(void)loadUI{
    [self addSubview:self.fontSizeLabel];
    [self addSubview:self.fontSizeSlider];
    [self addSubview:self.fontPreviewLabel];
}

#pragma mark - 属性定义

-(UILabel *)fontSizeLabel{
    if (!_fontSizeLabel) {
        _fontSizeLabel=[[UILabel alloc]initWithFrame:_fontSizeLabelRect];
        [_fontSizeLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter text:[NSString stringWithFormat:@"字体 : %ld",(long)[[SJSettingRecode getSet:@"textFont"]integerValue]]];
    }
    return _fontSizeLabel;
}

-(UISlider *)fontSizeSlider{
    if (!_fontSizeSlider) {
        _fontSizeSlider=[[UISlider alloc]initWithFrame:_fontSizeSliderRect];
        
        NSInteger fontPoint=[[SJSettingRecode getSet:@"textFont"]integerValue];
        _fontSizeSlider.value=(fontPoint-12)/24.;
    }
    return _fontSizeSlider;
}

-(UILabel *)fontPreviewLabel{
    if (!_fontPreviewLabel) {
        _fontPreviewLabel=[[UILabel alloc]initWithFrame:_fontPreviewLabelRect];
        [_fontPreviewLabel quicklySetFontPoint:12 textColorHex:@"000000" textAlignment:NSTextAlignmentCenter];
    }
    return _fontPreviewLabel;
}



#pragma mark - 其他方法
+(CGFloat)cellHeight{
    return 70;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

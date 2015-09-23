//
//  SJSettingTextColorCell.m
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJSettingTextColorCell.h"

@implementation SJSettingTextColorCell
{
    CGRect _backgroundColorLabelRect;
    CGRect _backgroundColorSelectViewRect;
}


@synthesize backgroundColorLabel=_backgroundColorLabel;
@synthesize backgroundColorSelectView=_backgroundColorSelectView;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundColorLabelRect= CGRectMake(8, 0, 60, 100);
    _backgroundColorSelectViewRect= CGRectMake(70, 0, 100, 100);
}

-(void)loadUI{
    [self addSubview:self.backgroundColorLabel];
    [self addSubview:self.backgroundColorSelectView];
}

#pragma mark - 属性定义

-(UILabel *)backgroundColorLabel{
    if (!_backgroundColorLabel) {
        _backgroundColorLabel=[[UILabel alloc]initWithFrame:_backgroundColorLabelRect];
        [_backgroundColorLabel quicklySetFontPoint:14 textColorHex:@"313742" textAlignment:NSTextAlignmentLeft text:@"字体颜色"];
    }
    return _backgroundColorLabel;
}

-(STColorPicker *)backgroundColorSelectView{
    if (!_backgroundColorSelectView) {
        _backgroundColorSelectView=[[STColorPicker alloc]initWithFrame:_backgroundColorSelectViewRect];
        [self addSubview:_backgroundColorSelectView];
    }
    return _backgroundColorSelectView;
}



#pragma mark - 其他方法
+(CGFloat)cellHeight{
    return 100;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

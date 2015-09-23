//
//  SJSettingBackgroundCell.m
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJSettingBackgroundCell.h"

@implementation SJSettingBackgroundCell
{
    CGRect _backgroundColorLabelRect;
    CGRect _backgroundColorSelectViewRect;
    CGRect _backgroundStyle1ImageViewRect;
    CGRect _backgroundStyle2ImageViewRect;

}


@synthesize backgroundColorLabel=_backgroundColorLabel;
@synthesize backgroundColorSelectView=_backgroundColorSelectView;
@synthesize backgroundStyle1ImageView=_backgroundStyle1ImageView;
@synthesize backgroundStyle2ImageView=_backgroundStyle2ImageView;



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
    _backgroundStyle1ImageViewRect= CGRectMake(180, 0, 50, 100);
    _backgroundStyle2ImageViewRect= CGRectMake(240, 0, 50, 100);
}

-(void)loadUI{
    [self addSubview:self.backgroundColorLabel];
    [self addSubview:self.backgroundColorSelectView];
    [self addSubview:self.backgroundStyle1ImageView];
    [self addSubview:self.backgroundStyle2ImageView];
}

#pragma mark - 属性定义

-(UILabel *)backgroundColorLabel{
    if (!_backgroundColorLabel) {
        _backgroundColorLabel=[[UILabel alloc]initWithFrame:_backgroundColorLabelRect];
        [_backgroundColorLabel quicklySetFontPoint:14 textColorHex:@"313742" textAlignment:NSTextAlignmentLeft text:@"背景颜色"];
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


-(UIImageView *)backgroundStyle1ImageView{
    if (!_backgroundStyle1ImageView) {
        _backgroundStyle1ImageView=[[UIImageView alloc]initWithFrame:_backgroundStyle1ImageViewRect];
        _backgroundStyle1ImageView.userInteractionEnabled=YES;
        _backgroundStyle1ImageView.image=[UIImage imageNamed:@"reading_background.jpg"];
    }
    return _backgroundStyle1ImageView;
}

-(UIImageView *)backgroundStyle2ImageView{
    if (!_backgroundStyle2ImageView) {
        _backgroundStyle2ImageView=[[UIImageView alloc]initWithFrame:_backgroundStyle2ImageViewRect];
        _backgroundStyle2ImageView.userInteractionEnabled=YES;
        _backgroundStyle2ImageView.image=[UIImage imageNamed:@"reading_background2.jpg"];
    }
    return _backgroundStyle2ImageView;
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

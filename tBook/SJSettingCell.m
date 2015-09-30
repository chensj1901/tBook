//
//  SJSettingCell.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/5.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSettingCell.h"

@implementation SJSettingCell
{
    CGRect _titleLabelRect;
    CGRect _lineViewRect;
}


@synthesize titleLabel=_titleLabel;
@synthesize lineView=_lineView;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _titleLabelRect= CGRectMake(7, 0, WIDTH-14, 44);
    _lineViewRect= CGRectMake(7, 43, WIDTH-14, 1);
}

-(void)loadUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - 属性定义

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:_titleLabelRect];
        [_titleLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"eeeeee";
    }
    return _lineView;
}

+(CGFloat)cellHeight{
    return 44;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

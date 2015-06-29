//
//  SJCatalogView.m
//  tBook
//
//  Created by 陈少杰 on 15/2/10.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCatalogView.h"

@implementation SJCatalogView
{
    CGRect _titleLabelRect;
    CGRect _changeSouceBtnRect;
    CGRect _detailTableViewRect;
    CGRect _progressSliderRect;
}


@synthesize titleLabel=_titleLabel;
@synthesize changeSouceBtn=_changeSouceBtn;
@synthesize detailTableView=_detailTableView;
@synthesize progressSlider=_progressSlider;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _titleLabelRect= CGRectMake(70, 0, SELF_WIDTH-70, 40);
    _changeSouceBtnRect= CGRectMake(SELF_WIDTH-60, 5, 50, 30);
    _detailTableViewRect= CGRectMake(0, 40, SELF_WIDTH-40, SELF_HEIGHT-40);
    _progressSliderRect= CGRectMake(SELF_WIDTH-40, 40, 40, SELF_HEIGHT-40);
}

-(void)loadUI{
    self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.changeSouceBtn];
    [self addSubview:self.detailTableView];
    [self addSubview:self.progressSlider];
}

#pragma mark - 属性定义

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:_titleLabelRect];
        [_titleLabel quicklySetFontPoint:12 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIButton *)changeSouceBtn{
    if (!_changeSouceBtn) {
        _changeSouceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _changeSouceBtn.frame=_changeSouceBtnRect;
        [_changeSouceBtn quicklySetFontPoint:12 textColorHex:@"3731cc" textAlignment:NSTextAlignmentCenter title:@"换源"];
    }
    return _changeSouceBtn;
}

-(PullTableView *)detailTableView{
    if (!_detailTableView) {
        _detailTableView=[[PullTableView alloc]initWithFrame:_detailTableViewRect loadMoreSwitch:NO refreshSwitch:NO];
    }
    return _detailTableView;
}

-(UISlider *)progressSlider{
    if (!_progressSlider) {
        _progressSlider=[[UISlider alloc]initWithFrame:_progressSliderRect];
        _progressSlider.transform=CGAffineTransformMakeRotation(M_PI/2);
        _progressSlider.frame=_progressSliderRect;
    }
    return _progressSlider;
}



#pragma mark - 其他方法
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

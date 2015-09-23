//
//  SJReadingStatusBarView.m
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJReadingStatusBarView.h"
#import "SJSettingRecode.h"

@implementation SJReadingStatusBarView
{
    CGRect _chapterNameLabelRect;
    CGRect _timeLabelRect;
}


@synthesize chapterNameLabel=_chapterNameLabel;
@synthesize timeLabel=_timeLabel;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _chapterNameLabelRect= CGRectMake(10, 0, WIDTH-80, 25);
    _timeLabelRect= CGRectMake(WIDTH-60, 0, 50, 25);
}

-(void)loadUI{
    [self addSubview:self.chapterNameLabel];
    [self addSubview:self.timeLabel];
}

#pragma mark - 属性定义

-(UILabel *)chapterNameLabel{
    if (!_chapterNameLabel) {
        _chapterNameLabel=[[UILabel alloc]initWithFrame:_chapterNameLabelRect];
        [_chapterNameLabel quicklySetFontPoint:12 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _chapterNameLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]initWithFrame:_timeLabelRect];
        [_timeLabel quicklySetFontPoint:12 textColorHex:@"313746" textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}



#pragma mark - 其他方法
-(void)loadChapter:(SJBookChapter *)chapter{
    _chapterNameLabel.text=[NSString stringWithFormat:@"%@   (%ld/%lu)",chapter.chapterName,(long)chapter.pageIndex+1,(unsigned long)[chapter.pageArr count]];
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    _timeLabel.text=[format stringFromDate:[NSDate date]];
}

-(void)refreshUI{
    self.chapterNameLabel.textColor=[UIColor colorWithHex:[SJSettingRecode getSet:@"textColor"]];
    self.timeLabel.textColor=[UIColor colorWithHex:[SJSettingRecode getSet:@"textColor"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

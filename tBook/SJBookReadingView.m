//
//  SJBookReadingView.m
//  tBook
//
//  Created by 陈少杰 on 15-1-24.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookReadingView.h"
#import "SJSettingRecode.h"

@implementation SJBookReadingView
{
    CGRect _bookTitleLabelRect;
    CGRect _bookContentLabelRect;
    CGRect _backgroundViewRect;
    CGRect _readingStatusBarViewRect;
    CGRect _operationViewRect;
    CGRect _batteryImageViewRect;
}


@synthesize bookTitleLabel=_bookTitleLabel;
@synthesize bookContentLabel=_bookContentLabel;
@synthesize backgroundView=_backgroundView;
@synthesize readingStatusBarView=_readingStatusBarView;
@synthesize operationView=_operationView;
@synthesize batteryImageView=_batteryImageView;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self loadSetting];
        [self loadUI];
        [self.bookContentLabel addObserver:self forKeyPath:@"text" options:0 context:nil];
    }
    return self;
}



-(void)loadSetting{
    _backgroundViewRect=CGRectMake(0, 0, WIDTH, HEIGHT);
    _bookTitleLabelRect= CGRectMake(0, 0, WIDTH, 12);
    _bookContentLabelRect= CGRectMake(10, 30, WIDTH-20, HEIGHT-60);
    _readingStatusBarViewRect= CGRectMake(0, 0, WIDTH, 30);
    _operationViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
    _batteryImageViewRect= CGRectMake((WIDTH-39)/2, HEIGHT-27.5, 39, 25);
}

-(void)loadUI{
    
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.bookTitleLabel];
    [self.backgroundView addSubview:self.bookContentLabel];
    [self.backgroundView addSubview:self.readingStatusBarView];
    [self.backgroundView addSubview:self.batteryImageView];
    [self addSubview:self.operationView];
}

#pragma mark - 属性定义

-(UILabel *)bookTitleLabel{
    if (!_bookTitleLabel) {
        _bookTitleLabel=[[UILabel alloc]initWithFrame:_bookTitleLabelRect];
        [_bookTitleLabel quicklySetFontPoint:12 textColorHex:@"ffffff" textAlignment:NSTextAlignmentCenter];
        _bookTitleLabel.userInteractionEnabled=NO;
    }
    return _bookTitleLabel;
}

-(UILabel *)bookContentLabel{
    if (!_bookContentLabel) {
        _bookContentLabel=[[UILabel alloc]initWithFrame:_bookContentLabelRect];
        _bookContentLabel.numberOfLines=0;
        _bookContentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        _bookContentLabel.userInteractionEnabled=NO;
    }
    return _bookContentLabel;
}


-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIImageView alloc]initWithFrame:_backgroundViewRect];
        _backgroundView.userInteractionEnabled=YES;
//        _backgroundView.backgroundColor=[UIColor blackColor];
//        _backgroundView.backgroundColor=[UIColor blackColor];
    }
    return _backgroundView;
}


-(SJBookReadingOperationView *)operationView{
    if (!_operationView) {
        _operationView=[[SJBookReadingOperationView alloc]initWithFrame:_operationViewRect];
        _operationView.alpha=0;
    }
    return _operationView;
}

-(SJReadingStatusBarView *)readingStatusBarView{
    if (!_readingStatusBarView) {
        _readingStatusBarView=[[SJReadingStatusBarView alloc]initWithFrame:_readingStatusBarViewRect];
    }
    return _readingStatusBarView;
}


-(SJBatteryImageView *)batteryImageView{
    if (!_batteryImageView) {
        _batteryImageView=[[SJBatteryImageView alloc]initWithFrame:_batteryImageViewRect];
        _batteryImageView.transform=CGAffineTransformMakeScale(0.5, 0.5);
    }
    return _batteryImageView;
}



#pragma mark - 其他方法

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object==self.bookContentLabel&&[keyPath isEqualToString:@"text"]) {
        CGFloat textHeight=[self.bookContentLabel.text sizeWithFont:self.bookContentLabel.font constrainedToSize:CGSizeMake(WIDTH-20, 9999)].height;
        [self.bookContentLabel quicklySetHeight:textHeight];
    }
}

-(void)dealloc{
    [self.bookContentLabel removeObserver:self forKeyPath:@"text"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

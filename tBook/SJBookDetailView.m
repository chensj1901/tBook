//
//  SJBookDetailView.m
//  tBook
//
//  Created by 陈少杰 on 14/11/27.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookDetailView.h"

@implementation SJBookDetailView

{
    
    CGRect _backgroundScrollViewRect;
    CGRect _coverImageViewRect;
    CGRect _nameLabelRect;
    CGRect _stateLabelRect;
    CGRect _lastUpdateDateLabelRect;
    CGRect _lineViewRect;
    CGRect _readNowBtnRect;
    CGRect _cacheAllBtnRect;
    CGRect _descLabelRect;
}

@synthesize backgroundScrollView=_backgroundScrollView;
@synthesize coverImageView=_coverImageView;
@synthesize nameLabel=_nameLabel;
@synthesize stateLabel=_stateLabel;
@synthesize lastUpdateDateLabel=_lastUpdateDateLabel;
@synthesize lineView=_lineView;
@synthesize readNowBtn=_readNowBtn;
@synthesize cacheAllBtn=_cacheAllBtn;
@synthesize descLabel=_descLabel;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundScrollViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
    _coverImageViewRect= CGRectMake(10, 10, 60, 75);
    _nameLabelRect= CGRectMake(80, 12, WIDTH-90, 14);
    _stateLabelRect= CGRectMake(80, CGRectGetMaxY(_nameLabelRect)+12, WIDTH-90, 13);
    _lastUpdateDateLabelRect= CGRectMake(80, CGRectGetMaxY(_stateLabelRect)+12, WIDTH-90, 13);
    _readNowBtnRect= CGRectMake((WIDTH-260)/2, 100, 120, 30);
    _cacheAllBtnRect= CGRectMake((WIDTH-260)/2+140, 100, 120, 30);
    _lineViewRect= CGRectMake(10, 150, WIDTH-20, 1);
    _descLabelRect= CGRectMake(10, 170, WIDTH-20, 0);
}
-(void)loadUI{
    self.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.backgroundScrollView];
    [self.backgroundScrollView addSubview:self.coverImageView];
    [self.backgroundScrollView addSubview:self.nameLabel];
    [self.backgroundScrollView addSubview:self.stateLabel];
    [self.backgroundScrollView addSubview:self.lastUpdateDateLabel];
    [self.backgroundScrollView addSubview:self.readNowBtn];
    [self.backgroundScrollView addSubview:self.cacheAllBtn];
    [self.backgroundScrollView addSubview:self.lineView];
    [self.backgroundScrollView addSubview:self.descLabel];
}

#pragma mark - 属性定义

-(UIScrollView *)backgroundScrollView{
    if (!_backgroundScrollView) {
        _backgroundScrollView=[[UIScrollView alloc]initWithFrame:_backgroundScrollViewRect];
    }
    return _backgroundScrollView;
}



-(EGOImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView=[[EGOImageView alloc]initWithFrame:_coverImageViewRect];
    }
    return _coverImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:_nameLabelRect];
        [_nameLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel=[[UILabel alloc]initWithFrame:_stateLabelRect];
        [_stateLabel quicklySetFontPoint:11 textColorHex:@"757574" textAlignment:NSTextAlignmentLeft];
    }
    return _stateLabel;
}

-(UILabel *)lastUpdateDateLabel{
    if (!_lastUpdateDateLabel) {
        _lastUpdateDateLabel=[[UILabel alloc]initWithFrame:_lastUpdateDateLabelRect];
        [_lastUpdateDateLabel quicklySetFontPoint:12 textColorHex:@"757574" textAlignment:NSTextAlignmentLeft];
    }
    return _lastUpdateDateLabel;
}

-(UIButton *)readNowBtn{
    if (!_readNowBtn) {
        _readNowBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _readNowBtn.frame=_readNowBtnRect;
        _readNowBtn.backgroundColorHex=@"f8f8f8";
        [_readNowBtn quicklySetFontPoint:14 textColorHex:@"757574" textAlignment:NSTextAlignmentCenter title:@"立即阅读"];
    }
    return _readNowBtn;
}

-(UIButton *)cacheAllBtn{
    if (!_cacheAllBtn) {
        _cacheAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cacheAllBtn.frame=_cacheAllBtnRect;
        _cacheAllBtn.backgroundColorHex=@"f8f8f8";
        [_cacheAllBtn quicklySetFontPoint:14 textColorHex:@"757574" textAlignment:NSTextAlignmentCenter title:@"全书缓存"];
    }
    return _cacheAllBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"e0e0e0";
    }
    return _lineView;
}

-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel=[[UILabel alloc]initWithFrame:_descLabelRect];
        [_descLabel quicklySetFontPoint:12 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
    }
    return _descLabel;
}

-(void)loadBook:(SJBook *)book{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"YYYY-mm-dd"];
    
    self.coverImageView.imageURL=[NSURL URLWithString:book.imgUrl];
    self.nameLabel.text=book.name;
    self.stateLabel.text=[NSString stringWithFormat:@"%@ | %@ | %@",book.author,book.category,book.status];
    self.lastUpdateDateLabel.text=[NSString stringWithFormat:@"%@ %@",book.lastChapterName,[dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:book.lastTime]]];
    self.descLabel.text=[NSString stringWithFormat:@"简介：%@\n",book.desc];
    
    CGFloat descHeight=[self.descLabel.text sizeWithFont:self.descLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(_backgroundScrollViewRect), 999)].height;
    [self.descLabel quicklySetHeight:descHeight];
    self.backgroundScrollView.contentSize=CGSizeMake(CGRectGetWidth(_backgroundScrollViewRect), descHeight+CGRectGetMinY(self.descLabel.frame));
    
}


@end

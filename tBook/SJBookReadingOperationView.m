//
//  SJBookReadingOperationView.m
//  tBook
//
//  Created by 陈少杰 on 15/2/9.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookReadingOperationView.h"

@implementation SJBookReadingOperationView
{
    CGRect _navigationBarViewRect;
    CGRect _backBtnRect;
    CGRect _moreBtnRect;
    CGRect _toolbarViewRect;
    CGRect _catalogBtnRect;
    CGRect _listenBtnRect;
    CGRect _blackModeSwitchBtnRect;
    CGRect _progressBtnRect;
    CGRect _commentBtnRect;
    CGRect _sourceWebsiteBtnRect;
}


@synthesize navigationBarView=_navigationBarView;
@synthesize backBtn=_backBtn;
@synthesize moreBtn=_moreBtn;
@synthesize toolbarView=_toolbarView;
@synthesize catalogBtn=_catalogBtn;
@synthesize listenBtn=_listenBtn;
@synthesize blackModeSwitchBtn=_blackModeSwitchBtn;
@synthesize progressBtn=_progressBtn;
@synthesize commentBtn=_commentBtn;
@synthesize sourceWebsiteBtn=_sourceWebsiteBtn;



#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    NSInteger btnCount=5;
    CGFloat ios7Offset=20.;
    
    _navigationBarViewRect= CGRectMake(0, 0, WIDTH, 44+ios7Offset);
    _backBtnRect= CGRectMake(0, ios7Offset, 44, 44);
    _moreBtnRect= CGRectMake(WIDTH-44, ios7Offset, 44, 44);
    _toolbarViewRect= CGRectMake(0, HEIGHT-50, WIDTH, 50);
    _catalogBtnRect= CGRectMake(0, 0, WIDTH/btnCount, 50);
    _listenBtnRect= CGRectMake(WIDTH/btnCount, 0, WIDTH/btnCount, 50);
    _blackModeSwitchBtnRect= CGRectMake(WIDTH/btnCount*2, 0, WIDTH/btnCount, 50);
    _progressBtnRect= CGRectMake(WIDTH/btnCount*3, 0, WIDTH/btnCount, 50);
    _commentBtnRect= CGRectMake(WIDTH/btnCount*3, 0, WIDTH/btnCount, 50);
    _sourceWebsiteBtnRect= CGRectMake(WIDTH/btnCount*4, 0, WIDTH/btnCount, 50);
}

-(void)loadUI{
    [self addSubview:self.navigationBarView];
    [self.navigationBarView addSubview:self.backBtn];
    [self.navigationBarView addSubview:self.moreBtn];
    [self addSubview:self.toolbarView];
    [self.toolbarView addSubview:self.catalogBtn];
    [self.toolbarView addSubview:self.listenBtn];
    [self.toolbarView addSubview:self.blackModeSwitchBtn];
//    [self.toolbarView addSubview:self.progressBtn];
    [self.toolbarView addSubview:self.commentBtn];
    [self.toolbarView addSubview:self.sourceWebsiteBtn];
}

#pragma mark - 属性定义

-(FXBlurView *)navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView=[[FXBlurView alloc]initWithFrame:_navigationBarViewRect];
        _navigationBarView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.9];
        _navigationBarView.tintColor=[UIColor whiteColor];
        _navigationBarView.blurRadius=30;
        _navigationBarView.blurEnabled=YES;
    }
    return _navigationBarView;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame=_backBtnRect;
        [_backBtn quicklySetNormalImageNamed:@"back.png" highlightImageNamed:nil selectedImageNamed:nil];
    }
    return _backBtn;
}

-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame=_moreBtnRect;
        [_moreBtn quicklySetNormalImageNamed:@"read_more.png" highlightImageNamed:nil selectedImageNamed:nil];
    }
    return _moreBtn;
}

-(FXBlurView *)toolbarView{
    if (!_toolbarView) {
        _toolbarView=[[FXBlurView alloc]initWithFrame:_toolbarViewRect];
        _toolbarView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.9];
        _toolbarView.tintColor=[UIColor whiteColor];
        _toolbarView.blurRadius=0.1;
        _toolbarView.blurEnabled=YES;
    }
    return _toolbarView;
}

-(UIButton *)catalogBtn{
    if (!_catalogBtn) {
        _catalogBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _catalogBtn.frame=_catalogBtnRect;
        [_catalogBtn quicklySetFontPoint:11 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter title:@"目录"];
        [_catalogBtn quicklySetNormalImageNamed:@"read_catelog.png" highlightImageNamed:nil selectedImageNamed:nil];
        [_catalogBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:5 topY:5];
    }
    return _catalogBtn;
}

-(UIButton *)listenBtn{
    if (!_listenBtn) {
        _listenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _listenBtn.frame=_listenBtnRect;
        [_listenBtn quicklySetFontPoint:11 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter title:@"朗读"];
        [_listenBtn quicklySetNormalImageNamed:@"read_listen.png" highlightImageNamed:nil selectedImageNamed:nil];
        [_listenBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:5 topY:5];
    }
    return _listenBtn;
}

-(UIButton *)blackModeSwitchBtn{
    if (!_blackModeSwitchBtn) {
        _blackModeSwitchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _blackModeSwitchBtn.frame=_blackModeSwitchBtnRect;
        [_blackModeSwitchBtn quicklySetFontPoint:11 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter title:@"夜间模式"];
        [_blackModeSwitchBtn quicklySetNormalImageNamed:@"read_darkMode.png" highlightImageNamed:nil selectedImageNamed:nil];
        [_blackModeSwitchBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:5 topY:5];
    }
    return _blackModeSwitchBtn;
}

-(UIButton *)progressBtn{
    if (!_progressBtn) {
        _progressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _progressBtn.frame=_progressBtnRect;
        [_progressBtn quicklySetFontPoint:11 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter title:@"进度"];
        [_progressBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:5 topY:5];
    }
    return _progressBtn;
}

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.frame=_commentBtnRect;
        [_commentBtn quicklySetFontPoint:11 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter title:@"书评"];
        [_commentBtn quicklySetNormalImageNamed:@"read_msg.png" highlightImageNamed:nil selectedImageNamed:nil];
        [_commentBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:5 topY:5];
    }
    return _commentBtn;
}

-(UIButton *)sourceWebsiteBtn{
    if (!_sourceWebsiteBtn) {
        _sourceWebsiteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sourceWebsiteBtn.frame=_sourceWebsiteBtnRect;
//        [_sourceWebsiteBtn quicklySetNormalImageNamed:<#(NSString *)#> highlightImageNamed:<#(NSString *)#> selectedImageNamed:<#(NSString *)#>];
        [_sourceWebsiteBtn quicklySetFontPoint:11 textColorHex:@"373146" textAlignment:NSTextAlignmentCenter title:@"源网站"];
        [_sourceWebsiteBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:5 topY:5];
    }
    return _sourceWebsiteBtn;
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

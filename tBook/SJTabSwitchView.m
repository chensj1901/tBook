//
//  SJTabSwitchView.m
//  tBook
//
//  Created by 陈少杰 on 15/2/7.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJTabSwitchView.h"

@implementation SJTabSwitchView
{
    CGRect _bookBtnRect;
    CGRect _squareBtnRect;
    CGRect _messageBtnRect;
    CGRect _profileBtnRect;
    CGRect _backgroundViewRect;
    CGRect _lineViewRect;
}


@synthesize bookBtn=_bookBtn;
@synthesize squareBtn=_squareBtn;
@synthesize messageBtn=_messageBtn;
@synthesize profileBtn=_profileBtn;
@synthesize backgroundView=_backgroundView;
@synthesize lineView=_lineView;



#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundViewRect= CGRectMake((WIDTH-120)/2, 7, 120, 30);
    _lineViewRect= CGRectMake(60, 0, 0.5, CGRectGetHeight(_backgroundViewRect));
    _bookBtnRect= CGRectMake(0, 0, 60, CGRectGetHeight(_backgroundViewRect));
    _squareBtnRect= CGRectMake(60, 0, 60, CGRectGetHeight(_backgroundViewRect));
//    _messageBtnRect= CGRectMake(SELF_WIDTH/4*2, 0, SELF_WIDTH/4, 50);
//    _profileBtnRect= CGRectMake(SELF_WIDTH/4*3, 0, SELF_WIDTH/4, 50);
}

-(void)loadUI{
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.lineView];
    [self.backgroundView addSubview:self.bookBtn];
    [self.backgroundView addSubview:self.squareBtn];
//    [self.backgroundView addSubview:self.messageBtn];
//    [self.backgroundView addSubview:self.profileBtn];
}

#pragma mark - 属性定义

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColor=[UIColor colorWithHex:@"cccccc"];
    }
    return _lineView;
}

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:_backgroundViewRect];
        _backgroundView.backgroundColorHex=@"F8F8F8";
        _backgroundView.layer.borderWidth=1;
        _backgroundView.layer.borderColor=[[UIColor colorWithHex:@"cccccc"]CGColor];
        _backgroundView.layer.cornerRadius=4;
//        _backgroundView.blurRadius=5;
//        _backgroundView.blurEnabled=YES;
    }
    return _backgroundView;
}


-(UIButton *)bookBtn{
    if (!_bookBtn) {
        _bookBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _bookBtn.frame=_bookBtnRect;
//        [_bookBtn quicklySetNormalImageNamed:@"book.png" highlightImageNamed:@"book_h.png" selectedImageNamed:@"book_h.png"];
        [_bookBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"书架"];
        [_bookBtn quicklySetNormalTextColorHex:@"cccccc" highlightedTextColorHex:@"313746" selectedTextColorHex:@"313746"];
//        [_bookBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:3 topY:6];
    }
    return _bookBtn;
}

-(UIButton *)squareBtn{
    if (!_squareBtn) {
        _squareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _squareBtn.frame=_squareBtnRect;
//        [_squareBtn quicklySetNormalImageNamed:@"square.png" highlightImageNamed:@"square_h.png" selectedImageNamed:@"square_h.png"];
        [_squareBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"发现"];
        [_squareBtn quicklySetNormalTextColorHex:@"cccccc" highlightedTextColorHex:@"313746" selectedTextColorHex:@"313746"];
//        [_squareBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:3 topY:6];
    }
    return _squareBtn;
}

-(UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.frame=_messageBtnRect;
        [_messageBtn quicklySetNormalImageNamed:@"msg.png" highlightImageNamed:@"msg_h.png" selectedImageNamed:@"msg_h.png"];
        [_messageBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"消息"];
        [_messageBtn quicklySetNormalTextColorHex:@"cccccc" highlightedTextColorHex:@"0096FA" selectedTextColorHex:@"0096FA"];
        [_messageBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:3 topY:6];
    }
    return _messageBtn;
}

-(UIButton *)profileBtn{
    if (!_profileBtn) {
        _profileBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _profileBtn.frame=_profileBtnRect;
        [_profileBtn quicklySetNormalImageNamed:@"profile.png" highlightImageNamed:@"profile_h.png" selectedImageNamed:@"profile_h.png"];
        [_profileBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"个人"];
        [_profileBtn quicklySetNormalTextColorHex:@"cccccc" highlightedTextColorHex:@"0096FA" selectedTextColorHex:@"0096FA"];
        [_profileBtn quicklyTopImageBottomTitleType:SJButtonImagePositionTypeTop padding:3 topY:6];
    }
    return _profileBtn;
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

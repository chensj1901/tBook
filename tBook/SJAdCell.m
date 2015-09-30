//
//  SJAdCell.m
//  tBook
//
//  Created by 陈少杰 on 15/9/24.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJAdCell.h"

@implementation SJAdCell
{
    CGRect _bookCoverImageViewRect;
    CGRect _bookTitleLabelRect;
    CGRect _bookDescLabelRect;
    CGRect _readBtnRect;
    CGRect _msgBtnRect;
    CGRect _lineViewRect;
}


@synthesize bookCoverImageView=_bookCoverImageView;
@synthesize bookTitleLabel=_bookTitleLabel;
@synthesize bookDescLabel=_bookDescLabel;
@synthesize readBtn=_readBtn;
@synthesize msgBtn=_msgBtn;
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
    _bookCoverImageViewRect= CGRectMake(10, 17.5, 60, 60);
    _bookTitleLabelRect= CGRectMake(80, 18, WIDTH-170, 16);
    _bookDescLabelRect= CGRectMake(80, 64, WIDTH-90, 12);
    _readBtnRect= CGRectMake(WIDTH-80, 10, 30, 30);
    _msgBtnRect= CGRectMake(WIDTH-40, 10, 30, 30);
    _lineViewRect= CGRectMake(80, [SJAdCell cellHeight]-1, WIDTH-90, 1);
}

-(void)loadUI{
    [self addSubview:self.bookCoverImageView];
    [self addSubview:self.bookTitleLabel];
    [self addSubview:self.bookDescLabel];
    //    [self addSubview:self.readBtn];
        [self addSubview:self.msgBtn];
    [self addSubview:self.lineView];
}

#pragma mark - 属性定义

-(EGOImageView *)bookCoverImageView{
    if (!_bookCoverImageView) {
        _bookCoverImageView=[[EGOImageView alloc]initWithFrame:_bookCoverImageViewRect];
    }
    return _bookCoverImageView;
}

-(UILabel *)bookTitleLabel{
    if (!_bookTitleLabel) {
        _bookTitleLabel=[[UILabel alloc]initWithFrame:_bookTitleLabelRect];
        [_bookTitleLabel quicklySetFontPoint:16 textColorHex:@"747475" textAlignment:NSTextAlignmentLeft];
    }
    return _bookTitleLabel;
}

-(UILabel *)bookDescLabel{
    if (!_bookDescLabel) {
        _bookDescLabel=[[UILabel alloc]initWithFrame:_bookDescLabelRect];
        [_bookDescLabel quicklySetFontPoint:12 textColorHex:@"acb0b2" textAlignment:NSTextAlignmentLeft];
    }
    return _bookDescLabel;
}

-(UIButton *)readBtn{
    if (!_readBtn) {
        _readBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _readBtn.frame=_readBtnRect;
        [_readBtn quicklySetNormalImageNamed:@"index_listen.png" highlightImageNamed:nil selectedImageNamed:nil];
    }
    return _readBtn;
}

-(UIButton *)msgBtn{
    if (!_msgBtn) {
        _msgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _msgBtn.frame=_msgBtnRect;
//        [_msgBtn quicklySetNormalImageNamed:@"index_msg.png" highlightImageNamed:nil selectedImageNamed:nil];
        [_msgBtn quicklySetFontPoint:12 textColorHex:@"acacac" textAlignment:NSTextAlignmentCenter];
    }
    return _msgBtn;
}



-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"eeeeee";
    }
    return _lineView;
}
#pragma mark - 其他方法

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)loadApp:(SJRecommendApp *)app{
    self.bookCoverImageView.imageURL=[NSURL URLWithString:app.appIcon];
    self.bookTitleLabel.text=app.appName;
    self.bookDescLabel.text=app.appDesc;
    [self.msgBtn setTitle:@"推广" forState:UIControlStateNormal];
}

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

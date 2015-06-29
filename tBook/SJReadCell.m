//
//  SJReaddingCell.m
//  tBook
//
//  Created by 陈少杰 on 14/12/4.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJReadCell.h"
#import "SJFrame.h"

@implementation SJReadCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    CGRect _bookTitleLabelRect;
    CGRect _bookContentLabelRect;
    CGRect _backgroundViewRect;
}


@synthesize bookTitleLabel=_bookTitleLabel;
@synthesize bookContentLabel=_bookContentLabel;
@synthesize backgroundView=_backgroundView;



#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}


-(void)loadSetting{
    _bookTitleLabelRect= CGRectMake(0, 0, WIDTH, 12);
    _bookContentLabelRect= CGRectMake(10, 20, WIDTH-20, HEIGHT-28);
    _backgroundViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
}

-(void)loadUI{
//    self.transform=CGAffineTransformMakeRotation(M_PI/2);
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.bookTitleLabel];
    [self.backgroundView addSubview:self.bookContentLabel];
}

#pragma mark - 属性定义

-(UILabel *)bookTitleLabel{
    if (!_bookTitleLabel) {
        _bookTitleLabel=[[UILabel alloc]initWithFrame:_bookTitleLabelRect];
        [_bookTitleLabel quicklySetFontPoint:12 textColorHex:@"ffffff" textAlignment:NSTextAlignmentCenter];
    }
    return _bookTitleLabel;
}

-(UILabel *)bookContentLabel{
    if (!_bookContentLabel) {
        _bookContentLabel=[[UILabel alloc]initWithFrame:_bookContentLabelRect];
        [_bookContentLabel quicklySetFontPoint:14 textColorHex:@"ffffff" textAlignment:NSTextAlignmentLeft];
        _bookContentLabel.numberOfLines=0;
        _bookContentLabel.lineBreakMode=NSLineBreakByWordWrapping;
    }
    return _bookContentLabel;
}


-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:_backgroundViewRect];
//        _backgroundView.backgroundColor=[UIColor blackColor];
    }
    return _backgroundView;
}



#pragma mark - 其他方法

-(void)setText:(NSString *)text{
    self.bookContentLabel.text=text;
    
    CGRect bcRect=self.bookContentLabel.frame;
    bcRect.size.height=[text sizeWithFont:self.bookContentLabel.font constrainedToSize:_bookContentLabelRect.size].height;
    self.bookContentLabel.frame=bcRect;
    
}
+(CGFloat)cellHeight{
    return WIDTH;
}
@end

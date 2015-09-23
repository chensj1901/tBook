//
//  SJSearchHitCell.m
//  tBook
//
//  Created by 陈少杰 on 15/9/19.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJSearchHitCell.h"

@implementation SJSearchHitCell
{
    CGRect _bookNameLabelRect;
    CGRect _lineViewRect;
}


@synthesize bookNameLabel=_bookNameLabel;
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
    _bookNameLabelRect= CGRectMake(0, 0, WIDTH-65, [SJSearchHitCell cellHeight]-1);
    _lineViewRect= CGRectMake(0, [SJSearchHitCell cellHeight]-1, WIDTH-65, 1);
}

-(void)loadUI{
    [self addSubview:self.bookNameLabel];
    [self addSubview:self.lineView];
}

#pragma mark - 属性定义

-(UILabel *)bookNameLabel{
    if (!_bookNameLabel) {
        _bookNameLabel=[[UILabel alloc]initWithFrame:_bookNameLabelRect];
        [_bookNameLabel quicklySetFontPoint:12 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _bookNameLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"ececec";
    }
    return _lineView;
}



#pragma mark - 其他方法
+(CGFloat)cellHeight{
    return 44;
}

-(void)loadBook:(SJBook *)book{
    self.bookNameLabel.text=[NSString stringWithFormat:@" %@",book.name];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

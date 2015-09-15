//
//  SJSearchBookCell.m
//  tBook
//
//  Created by 陈少杰 on 15/2/9.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSearchBookCell.h"

@implementation SJSearchBookCell
{
    CGRect _bookCoverImageViewRect;
    CGRect _bookTitleLabelRect;
    CGRect _bookAuthorLabelRect;
    CGRect _bookLastUpdateDateLabelRect;
    CGRect _bookDescLabelRect;
    CGRect _lineViewRect;
}


@synthesize bookCoverImageView=_bookCoverImageView;
@synthesize bookTitleLabel=_bookTitleLabel;
@synthesize bookAuthorLabel=_bookAuthorLabel;
@synthesize bookLastUpdateDateLabel=_bookLastUpdateDateLabel;
@synthesize bookDescLabel=_bookDescLabel;
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
    _bookCoverImageViewRect= CGRectMake(10, 10, 60, 75);
    _bookTitleLabelRect= CGRectMake(80, 10, WIDTH-80, 14);
    _bookAuthorLabelRect= CGRectMake(80, 34, WIDTH-80, 12);
    _bookLastUpdateDateLabelRect= CGRectMake(80, 56, WIDTH-80, 12);
    _bookDescLabelRect= CGRectMake(10, 95, WIDTH-20, 0);
    _lineViewRect= CGRectMake(0, 0, WIDTH, 0.5);
}

-(void)loadUI{
    [self addSubview:self.bookCoverImageView];
    [self addSubview:self.bookTitleLabel];
    [self addSubview:self.bookAuthorLabel];
    [self addSubview:self.bookLastUpdateDateLabel];
    [self addSubview:self.bookDescLabel];
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
        [_bookTitleLabel quicklySetFontPoint:14 textColorHex:@"747576" textAlignment:NSTextAlignmentLeft];
    }
    return _bookTitleLabel;
}

-(UILabel *)bookAuthorLabel{
    if (!_bookAuthorLabel) {
        _bookAuthorLabel=[[UILabel alloc]initWithFrame:_bookAuthorLabelRect];
        [_bookAuthorLabel quicklySetFontPoint:12 textColorHex:@"acb0b6" textAlignment:NSTextAlignmentLeft];
    }
    return _bookAuthorLabel;
}

-(UILabel *)bookLastUpdateDateLabel{
    if (!_bookLastUpdateDateLabel) {
        _bookLastUpdateDateLabel=[[UILabel alloc]initWithFrame:_bookLastUpdateDateLabelRect];
        [_bookLastUpdateDateLabel quicklySetFontPoint:12 textColorHex:@"acb0b6" textAlignment:NSTextAlignmentLeft];
    }
    return _bookLastUpdateDateLabel;
}

-(UILabel *)bookDescLabel{
    if (!_bookDescLabel) {
        _bookDescLabel=[[UILabel alloc]initWithFrame:_bookDescLabelRect];
        [_bookDescLabel quicklySetFontPoint:12 textColorHex:@"acb0b6" textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
    }
    return _bookDescLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"cccccc";
    }
    return _lineView;
}



#pragma mark - 其他方法

-(void)loadBook:(SJBook *)book{
    NSString *desc=book.desc.length>150?[[book.desc substringWithRange:NSMakeRange(0, 150)]stringByAppendingString:@"…"]:book.desc;
    
    self.bookCoverImageView.imageURL=[NSURL URLWithString:book.imgUrl];
    self.bookTitleLabel.text=book.name;
    self.bookAuthorLabel.text=book.author;
    self.bookLastUpdateDateLabel.text=book.lastChapterName;
    self.bookDescLabel.text=desc;
    
    CGFloat height=[desc sizeWithFont:self.bookDescLabel.font constrainedToSize:CGSizeMake(WIDTH-20, 999)].height;
    [self.bookDescLabel quicklySetHeight:height];
    [self.lineView quicklySetOriginY:height+95+9];
}

+(CGFloat)cellHeightWithBook:(SJBook*)book{
    SJSearchBookCell *t=[[SJSearchBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString *desc=book.desc.length>150?[[book.desc substringWithRange:NSMakeRange(0, 150)]stringByAppendingString:@"…"]:book.desc;
    
    CGFloat height=[desc sizeWithFont:t.bookDescLabel.font constrainedToSize:CGSizeMake(WIDTH-20, 999)].height;
    
    return height+95+10;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SJCatalogCell.m
//  tBook
//
//  Created by 陈少杰 on 15/2/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCatalogCell.h"

@implementation SJCatalogCell
{
    CGRect _tagImageViewRect;
    CGRect _titleLabelRect;
    CGRect _lineViewRect;
}


@synthesize tagImageView=_tagImageView;
@synthesize titleLabel=_titleLabel;
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
    _tagImageViewRect= CGRectMake(5,11, 11, 11);
    _titleLabelRect= CGRectMake(21, 11, WIDTH-31, 11);
    _lineViewRect= CGRectMake(0, [SJCatalogCell cellHeight], WIDTH, 1);
}

-(void)loadUI{
    [self addSubview:self.tagImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}

#pragma mark - 属性定义

-(UIImageView *)tagImageView{
    if (!_tagImageView) {
        _tagImageView=[[UIImageView alloc]initWithFrame:_tagImageViewRect];
    }
    return _tagImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:_titleLabelRect];
        [_titleLabel quicklySetFontPoint:12 textColorHex:@"373146" textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
    }
    return _lineView;
}



#pragma mark - 其他方法
+(CGFloat)cellHeight{
    return 33;
}

-(void)loadChapter:(SJBookChapter *)chapter{
    self.titleLabel.text=chapter.chapterName;
    
    if(chapter.isSelected){
        self.titleLabel.textColor=[UIColor colorWithHex:@"db6978"];
    }
    else{
        self.titleLabel.textColor=[UIColor colorWithHex:@"373146"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

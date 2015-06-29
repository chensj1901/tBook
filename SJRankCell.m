//
//  SJRankCell.m
//  tBook
//
//  Created by 陈少杰 on 15/5/12.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRankCell.h"

@implementation SJRankCell

{
    CGRect _iconImageViewRect;
    CGRect _RankNameLabelRect;
    CGRect _lineViewRect;
}


@synthesize iconImageView=_iconImageView;
@synthesize rankNameLabel=_rankNameLabel;
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
    _iconImageViewRect= CGRectMake(5, ([SJRankCell cellHeight]-17)/2, 17, 17);
    _RankNameLabelRect= CGRectMake(27, 0, WIDTH-37, [SJRankCell cellHeight]);
    _lineViewRect= CGRectMake(0, [SJRankCell cellHeight]-1, WIDTH, 1);
}

-(void)loadUI{
    [self addSubview:self.iconImageView];
    [self addSubview:self.rankNameLabel];
    [self addSubview:self.lineView];
}

#pragma mark - 属性定义

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc]initWithFrame:_iconImageViewRect];
    }
    return _iconImageView;
}

-(UILabel *)rankNameLabel{
    if (!_rankNameLabel) {
        _rankNameLabel=[[UILabel alloc]initWithFrame:_RankNameLabelRect];
        [_rankNameLabel quicklySetFontPoint:16 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _rankNameLabel;
}


-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"eeeeee";
    }
    return _lineView;
}



+(CGFloat)cellHeight{
    return 44;
}

-(void)loadRank:(SJRank *)rank{
    self.rankNameLabel.text=rank.rankName;
    self.iconImageView.image=[UIImage imageNamed:rank.rankImageName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SJRankDetailView.m
//  tBook
//
//  Created by 陈少杰 on 15/3/31.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRankDetailView.h"

@implementation SJRankDetailView
{
    CGRect _detailTableViewRect;
}


@synthesize detailTableView=_detailTableView;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    self.backgroundColorHex=@"ffffff";
    _detailTableViewRect= CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
}

-(void)loadUI{
    [self addSubview:self.detailTableView];
}

#pragma mark - 属性定义

-(PullTableView *)detailTableView{
    if (!_detailTableView) {
        _detailTableView=[[PullTableView alloc]initWithFrame:_detailTableViewRect loadMoreSwitch:NO refreshSwitch:NO];
    }
    return _detailTableView;
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

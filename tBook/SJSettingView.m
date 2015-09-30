//
//  SJSettingView.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/4.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSettingView.h"

@implementation SJSettingView
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
    _detailTableViewRect= CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
}

-(void)loadUI{
    [self addSubview:self.detailTableView];
}

#pragma mark - 属性定义

-(PullTableView *)detailTableView{
    if (!_detailTableView) {
        _detailTableView=[[PullTableView alloc]initWithFrame:_detailTableViewRect loadMoreSwitch:NO refreshSwitch:NO];
        _detailTableView.contentInset=UIEdgeInsetsMake(IS_IOS7()?32:0, 0, 0, 0);
    }
    return _detailTableView;
}



#pragma mark - 其他方法
@end

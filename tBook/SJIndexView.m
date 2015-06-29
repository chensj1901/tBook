//
//  SJIndexView.m
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJIndexView.h"

@implementation SJIndexView
{
    CGRect _backgroundViewRect;
    CGRect _searchbarViewRect;
    CGRect _searchBtnRect;
    CGRect _searchTextFieldRect;
    CGRect _resultTableViewRect;
}


@synthesize backgroundView=_backgroundView;
@synthesize searchbarView=_searchbarView;
@synthesize searchBtn=_searchBtn;
@synthesize searchTextField=_searchTextField;
@synthesize resultTableView=_resultTableView;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundViewRect= CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    _searchbarViewRect= CGRectMake(0, 0, SELF_WIDTH, 40);
    _searchTextFieldRect= CGRectMake(5, 5, SELF_WIDTH-65, 30);
    _searchBtnRect= CGRectMake(SELF_WIDTH-55, 5, 50, 30);
    _resultTableViewRect= CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
}

-(void)loadUI{
    [self addSubview:self.backgroundView];
    [self.searchbarView addSubview:self.searchBtn];
    [self.searchbarView addSubview:self.searchTextField];
    [self.backgroundView addSubview:self.resultTableView];
}

#pragma mark - 属性定义

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:_backgroundViewRect];
        _backgroundView.backgroundColor=[UIColor colorWithHex:@"ffffff"];
    }
    return _backgroundView;
}

-(UIView *)searchbarView{
    if (!_searchbarView) {
        _searchbarView=[[UIView alloc]initWithFrame:_searchbarViewRect];
        _searchbarView.backgroundColor=[UIColor colorWithHex:@"cccccc"];
    }
    return _searchbarView;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame=_searchBtnRect;
        [_searchBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"搜索"];
    }
    return _searchBtn;
}

-(UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField=[[UITextField alloc]initWithFrame:_searchTextFieldRect];
        _searchTextField.backgroundColor=[UIColor colorWithHex:@"ffffff"];
    }
    return _searchTextField;
}

-(PullTableView *)resultTableView{
    if (!_resultTableView) {
        _resultTableView=[[PullTableView alloc]initWithFrame:_resultTableViewRect loadMoreSwitch:YES refreshSwitch:YES];
    }
    return _resultTableView;
}



#pragma mark - 其他方法

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

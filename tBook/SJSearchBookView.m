//
//  SJSearchBookView.m
//  tBook
//
//  Created by 陈少杰 on 15/2/7.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSearchBookView.h"

@implementation SJSearchBookView
{
    CGRect _backgroundViewRect;
    CGRect _searchbarViewRect;
    CGRect _searchBtnRect;
    CGRect _searchBarRect;
    CGRect _resultTableViewRect;
}


@synthesize backgroundView=_backgroundView;
@synthesize searchbarView=_searchbarView;
@synthesize searchBtn=_searchBtn;
@synthesize searchBar=_searchBar;
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
    CGFloat ios7Offset=IS_IOS7()? 20:0;
    _backgroundViewRect= CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    _searchbarViewRect= CGRectMake(0, 0, SELF_WIDTH, 40+ios7Offset);
    _searchBarRect= CGRectMake(5, 5+ios7Offset, SELF_WIDTH-65, 30);
    _searchBtnRect= CGRectMake(SELF_WIDTH-55, 5+ios7Offset, 50, 30);
    _resultTableViewRect= CGRectMake(0,44+ios7Offset, SELF_WIDTH, SELF_HEIGHT-64);
}

-(void)loadUI{
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.searchbarView];
    [self.searchbarView addSubview:self.searchBtn];
    [self.searchbarView addSubview:self.searchBar];
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
        _searchbarView.backgroundColor=[UIColor colorWithHex:@"F8F8F8"];
    }
    return _searchbarView;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame=_searchBtnRect;
        [_searchBtn quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter title:@"取消"];
    }
    return _searchBtn;
}

-(SJSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar=[[SJSearchBar alloc]initWithFrame:_searchBarRect];
//        _searchTextField.backgroundColor=[UIColor colorWithHex:@"ffffff"];
    }
    return _searchBar;
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
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

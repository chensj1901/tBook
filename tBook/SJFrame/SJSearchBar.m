//
//  SJSearchBar2.m
//  zhitu
//
//  Created by 陈少杰 on 14-3-13.
//  Copyright (c) 2014年 聆创科技有限公司. All rights reserved.
//

#import "SJSearchBar.h"

@implementation SJSearchBar
@synthesize searchIcon=_searchIcon;
@synthesize deleteIcon=_deleteIcon;

- (id)initWithFrame:(CGRect)frame
{//
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.background=[[UIImage imageNamed:@"聊天框.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
//        self.backgroundColor = [UIColor colorWithHex:@"EDF0F1"];
        self.textColor = [UIColor colorWithHex:@"62707d"];
        self.leftViewMode=UITextFieldViewModeAlways;
        self.leftView=self.searchIcon;
        self.rightView=self.deleteIcon;
        self.rightViewMode=UITextFieldViewModeAlways;
//        self.layer.borderWidth=1;
//        self.layer.cornerRadius=2;
        self.placeholderFont=[UIFont boldSystemFontOfSize:12];
        self.font=[UIFont boldSystemFontOfSize:12];
        self.returnKeyType=UIReturnKeySearch;
//        self.layer.borderColor=[[UIColor colorWithHex:@"f0f0f0"]CGColor];
        self.placeholderColor=[UIColor colorWithHex:@"b6bec6"];
    }
    return self;
}

-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 5;
    return iconRect;
}

-(UIImageView *)searchIcon{
    if (!_searchIcon) {
        _searchIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"右侧推荐_搜索icon.png"]];
        _searchIcon.frame=CGRectMake(5, 5, 30, 30);
        _searchIcon.contentMode=UIViewContentModeCenter;
    }
    return _searchIcon;
}

-(UIButton *)deleteIcon{
    if (!_deleteIcon) {
        _deleteIcon=[UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteIcon setImage:[UIImage imageNamed:@"搜索页_撤销键.png"] forState:UIControlStateNormal];
        [_deleteIcon setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        _deleteIcon.frame=CGRectMake(5, 5, 30, 30);
        [_deleteIcon addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteIcon;
}

-(void)clearText{
    self.text=@"";
    [[NSNotificationCenter defaultCenter]postNotificationName:UITextFieldTextDidChangeNotification object:self userInfo:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

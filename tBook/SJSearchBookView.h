//
//  SJSearchBookView.h
//  tBook
//
//  Created by 陈少杰 on 15/2/7.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "SJSearchBar.h"

@interface SJSearchBookView : UIView
@property(nonatomic,readonly)UIView *backgroundView;
@property(nonatomic,readonly)UIView *searchbarView;
@property(nonatomic,readonly)UIButton *searchBtn;
@property(nonatomic,readonly)SJSearchBar *searchBar;
@property(nonatomic,readonly)PullTableView *resultTableView;

@end

//
//  SJIndexView.h
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface SJIndexView : UIView
@property(nonatomic,readonly)UIView *backgroundView;
@property(nonatomic,readonly)UIView *searchbarView;
@property(nonatomic,readonly)UIButton *searchBtn;
@property(nonatomic,readonly)UITextField *searchTextField;
@property(nonatomic,readonly)PullTableView *resultTableView;
@end

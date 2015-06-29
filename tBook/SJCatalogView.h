//
//  SJCatalogView.h
//  tBook
//
//  Created by 陈少杰 on 15/2/10.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface SJCatalogView : UIView
@property(nonatomic,readonly)UILabel *titleLabel;
@property(nonatomic,readonly)UIButton *changeSouceBtn;
@property(nonatomic,readonly)PullTableView *detailTableView;
@property(nonatomic,readonly)UISlider *progressSlider;
@end

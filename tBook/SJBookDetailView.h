//
//  SJBookDetailView.h
//  tBook
//
//  Created by 陈少杰 on 14/11/27.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EGOImageView.h>
#import "SJBook.h"

@interface SJBookDetailView : UIView
@property(nonatomic,readonly)UIScrollView *backgroundScrollView;
@property(nonatomic,readonly)EGOImageView *coverImageView;
@property(nonatomic,readonly)UILabel *nameLabel;
@property(nonatomic,readonly)UILabel *stateLabel;
@property(nonatomic,readonly)UILabel *lastUpdateDateLabel;
@property(nonatomic,readonly)UIButton *readNowBtn;
@property(nonatomic,readonly)UIButton *cacheAllBtn;
@property(nonatomic,readonly)UIView *lineView;
@property(nonatomic,readonly)UILabel *descLabel;

-(void)loadBook:(SJBook *)book;
@end

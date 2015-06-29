//
//  SJBookReadingOperationView.h
//  tBook
//
//  Created by 陈少杰 on 15/2/9.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXBlurView/FXBlurView.h>

@interface SJBookReadingOperationView : UIView
@property(nonatomic,readonly)FXBlurView *navigationBarView;
@property(nonatomic,readonly)UIButton *backBtn;
@property(nonatomic,readonly)UIButton *moreBtn;
@property(nonatomic,readonly)FXBlurView *toolbarView;
@property(nonatomic,readonly)UIButton *catalogBtn;
@property(nonatomic,readonly)UIButton *listenBtn;
@property(nonatomic,readonly)UIButton *blackModeSwitchBtn;
@property(nonatomic,readonly)UIButton *progressBtn;
@property(nonatomic,readonly)UIButton *commentBtn;
@property(nonatomic,readonly)UIButton *sourceWebsiteBtn;

@end

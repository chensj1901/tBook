//
//  SJReadingStatusBarView.h
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJBookChapter.h"

@interface SJReadingStatusBarView : UIView
@property(nonatomic,readonly)UILabel *chapterNameLabel;
@property(nonatomic,readonly)UILabel *timeLabel;
-(void)loadChapter:(SJBookChapter *)bookChapter;
@end

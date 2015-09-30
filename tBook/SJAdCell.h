//
//  SJAdCell.h
//  tBook
//
//  Created by 陈少杰 on 15/9/24.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJRecommendApp.h"
#import <EGOImageView.h>

@interface SJAdCell : SJCell
@property(nonatomic,readonly)EGOImageView *bookCoverImageView;
@property(nonatomic,readonly)UILabel *bookTitleLabel;
@property(nonatomic,readonly)UILabel *bookDescLabel;
@property(nonatomic,readonly)UIButton *readBtn;
@property(nonatomic,readonly)UIButton *msgBtn;
@property(nonatomic,readonly)UIView *lineView;

-(void)loadApp:(SJRecommendApp *)app;

+(CGFloat)cellHeight;
@end

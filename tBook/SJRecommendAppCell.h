//
//  SJRecommendAppCell.h
//  zhitu
//
//  Created by 陈少杰 on 13-11-29.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "SJRecommendApp.h"

@interface SJRecommendAppCell : UITableViewCell
{
    CGRect _appDescLabelRect;
}
@property(nonatomic)EGOImageView *appIcon;
@property(nonatomic)UILabel *appNameLabel;
@property(nonatomic)UILabel *appSizeLabel;
@property(nonatomic)UILabel *appDescLabel;
@property(nonatomic)UIButton *downloadButton;
-(void)setAppName:(NSString *)appName;
-(void)setAppSize:(CGFloat)size;
-(void)setAppDesc:(NSString*)desc;
-(void)setAppIconURL:(NSString*)string;
-(void)loadApp:(SJRecommendApp *)app;
+(CGFloat)cellHeight;
@end

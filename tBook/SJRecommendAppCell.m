//
//  SJRecommendAppCell.m
//  zhitu
//
//  Created by 陈少杰 on 13-11-29.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "SJRecommendAppCell.h"

@implementation SJRecommendAppCell
{
    UIView *_line;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self loadUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self addSubview:self.appIcon];
    [self addSubview:self.appNameLabel];
    [self addSubview:self.appSizeLabel];
    [self addSubview:self.appDescLabel];
    [self addSubview:self.downloadButton];
    [self addSubview:[self line]];
}

-(EGOImageView *)appIcon{
    if (!_appIcon) {
        _appIcon=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"camera_bg_2.png"]];
        _appIcon.frame=CGRectMake(10, 13, 44, 44);
        UIImageView *avatarLayer=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4号圆角屏蔽.png"]];
        avatarLayer.frame=_appIcon.bounds;
        [_appIcon addSubview:avatarLayer];

    }
    return _appIcon;
}

-(UILabel *)appNameLabel{
    if (!_appNameLabel) {
        _appNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(64, 13, [UIScreen mainScreen].bounds.size.width-70-64, 14)];
        _appNameLabel.backgroundColor=[UIColor clearColor];
        _appNameLabel.font=[UIFont boldSystemFontOfSize:14];
        _appNameLabel.textColor=[UIColor colorWithHex:@"595856"];
    }
    return _appNameLabel;
}

-(UILabel *)appSizeLabel{
    return nil;
}

-(UILabel *)appDescLabel{
    if (!_appDescLabel) {
        _appDescLabelRect=CGRectMake(64, 37, [UIScreen mainScreen].bounds.size.width-70-64, 12);
        _appDescLabel=[[UILabel alloc]initWithFrame:_appDescLabelRect];
        
        _appDescLabel.backgroundColor=[UIColor clearColor];
        _appDescLabel.font=[UIFont systemFontOfSize:12];
        _appDescLabel.textColor=[UIColor colorWithHex:@"acb0b2"];
        _appDescLabel.numberOfLines=2;
        _appDescLabel.lineBreakMode=NSLineBreakByWordWrapping;
    }
    return _appDescLabel;
}

-(UIButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _downloadButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 20, 50, 30);
        [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadButton setBackgroundImage:[[UIImage imageNamed:@"button1.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [_downloadButton setBackgroundImage:[[UIImage imageNamed:@"button1_h.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
        _downloadButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [_downloadButton setTitleColor:[UIColor colorWithHex:@"f2f2f2"] forState:UIControlStateNormal];
    }
    return _downloadButton;
}

-(UIView*)line{
    if (!_line) {
        _line=[[UIView alloc]initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
        _line.backgroundColor=[UIColor colorWithRed:0.85 green:0.86 blue:0.87 alpha:1.00];
    }
    return _line;
}

-(void)setAppName:(NSString *)appName{
    self.appNameLabel.text=appName;
}

-(void)setAppSize:(CGFloat)size{
    self.appSizeLabel.text=[NSString stringWithFormat:@"%fMB",size];
}

-(void)setAppDesc:(NSString *)desc{
    self.appDescLabel.text=desc;
    CGSize descSize=[self.appDescLabel.text sizeWithFont:self.appDescLabel.font constrainedToSize:CGSizeMake(self.appDescLabel.frame.size.width, 35) lineBreakMode:NSLineBreakByWordWrapping];
    _appDescLabelRect.origin.y=descSize.height>20?31:37;
    _appDescLabelRect.size.height=descSize.height;
    self.appDescLabel.frame=_appDescLabelRect;
}

-(void)setAppIconURL:(NSString *)string{
    self.appIcon.imageURL=[NSURL URLWithString:string];
}

-(void)loadApp:(SJRecommendApp *)app{
    [self setAppDesc:app.appDesc];
    [self setAppName:app.appName];
    [self setAppIconURL:app.appIcon];
}
+(CGFloat)cellHeight{
    return 70;
}
@end

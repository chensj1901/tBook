//
//  SJSettingPreviewCell.m
//  tBook
//
//  Created by 陈少杰 on 15/9/22.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJSettingPreviewCell.h"
#import "SJSettingRecode.h"


@implementation SJSettingPreviewCell
{
    CGRect _previewLabelRect;
    CGRect _previewBackgroundImageViewRect;
}


@synthesize previewLabel=_previewLabel;
@synthesize previewBackgroundImageView=_previewBackgroundImageView;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _previewBackgroundImageViewRect= CGRectMake(6, 6, WIDTH-12, [SJSettingPreviewCell cellHeight]-12);
    _previewLabelRect= CGRectMake(12,12, WIDTH-24, [SJSettingPreviewCell cellHeight]-24);
}

-(void)loadUI{
    [self addSubview:self.previewBackgroundImageView];
    [self addSubview:self.previewLabel];
}

#pragma mark - 属性定义
-(UIImageView *)previewBackgroundImageView{
    if (!_previewBackgroundImageView) {
        _previewBackgroundImageView=[[UIImageView alloc]initWithFrame:_previewBackgroundImageViewRect];
    }
    return _previewBackgroundImageView;
}

-(UILabel *)previewLabel{
    if (!_previewLabel) {
        _previewLabel=[[UILabel alloc]initWithFrame:_previewLabelRect];
        _previewLabel.text=@"老板是个坏人，老让我们加班加班加班！这句话是我偷偷的写的，我相信他看不到。好吧，你们拿来阅读看看效果怎样吧！";
    }
    return _previewLabel;
}


#pragma mark - 其他方法
-(void)refreshUI{
    [self.previewLabel quicklySetFontPoint:[[SJSettingRecode getSet:@"textFont"]floatValue] textColorHex:[SJSettingRecode getSet:@"textColor"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
    
    NSString *backgroundStr=[SJSettingRecode getSet:@"backgroundStr"];
    NSString *type=[[backgroundStr componentsSeparatedByString:@":"]safeObjectAtIndex:0];
    NSString *value=[[backgroundStr componentsSeparatedByString:@":"]safeObjectAtIndex:1];
    
    if ([type rangeOfString:@"image"].length>0) {
        self.previewBackgroundImageView.image=[UIImage imageNamed:value];
        self.previewBackgroundImageView.backgroundColor=[UIColor clearColor];
    }else if ([type rangeOfString:@"color"].length>0){
        self.previewBackgroundImageView.image=nil;
        self.previewBackgroundImageView.backgroundColorHex=value;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(CGFloat)cellHeight{
    return 100;
}
@end

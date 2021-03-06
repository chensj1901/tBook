//
//  SJBatteryImageView.m
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBatteryImageView.h"
#import "SJSettingRecode.h"

@implementation SJBatteryImageView

{
    CGRect _electricityValueViewRect;
    NSString *_imageNamed;
}


@synthesize electricityValueView=_electricityValueView;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _electricityValueViewRect= CGRectMake(4.5, 4.5, 28, 18);
}

-(void)loadUI{
    _imageNamed=@"read_battery.png";
    self.image=[UIImage imageNamed:_imageNamed];
    [self addSubview:self.electricityValueView];
}

#pragma mark - 属性定义

-(UIView *)electricityValueView{
    if (!_electricityValueView) {
        _electricityValueView=[[UIView alloc]initWithFrame:_electricityValueViewRect];
        _electricityValueView.backgroundColorHex=@"313746";
    }
    return _electricityValueView;
}



#pragma mark - 其他方法
-(void)setElectricityValue:(CGFloat)electricityValue{
    if (electricityValue>0) {
        [self.electricityValueView quicklySetWidth:28*electricityValue];
    }
    NSString *colorHex=[SJSettingRecode getSet:@"textColor"];
    UIImage *image=[[UIImage imageNamed:_imageNamed]imageWithTintColor:[UIColor colorWithHex:colorHex]];
    self.electricityValueView.backgroundColorHex=colorHex;
    self.image=image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

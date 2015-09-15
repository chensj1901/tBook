//
//  SJBatteryImageView.h
//  tBook
//
//  Created by 陈少杰 on 15/9/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBatteryImageView : UIImageView
@property(nonatomic,readonly)UIView *electricityValueView;
-(void)setElectricityValue:(CGFloat )electricityValue;
@end

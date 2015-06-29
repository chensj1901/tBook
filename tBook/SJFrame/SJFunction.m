//
//  SJFunction.m
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJFunction.h"

@implementation SJFunction

void alert(NSString* string)
{
    @autoreleasepool {
        __weak  UIWindow *view;
        if (!view) {
            view=(UIWindow*)[[[UIApplication sharedApplication]windows]objectAtIndex:0];
        }
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:13];
        CGSize labelsize = [string sizeWithFont:font constrainedToSize:view.frame.size lineBreakMode:NSLineBreakByWordWrapping];
        CGRect frame=CGRectMake(90, 35, 140, 30);
        CGSize screensize=[UIScreen mainScreen].bounds.size;
        frame.size=CGSizeMake(labelsize.width+20, labelsize.height+20);
        frame.origin=CGPointMake((screensize.width-frame.size.width)/2, screensize.height/2-40);
        UILabel *alertLabel=[[UILabel alloc]initWithFrame:frame];
        alertLabel.text=string;
        alertLabel.font=font;
        alertLabel.numberOfLines=0;
        alertLabel.lineBreakMode=NSLineBreakByWordWrapping;
        alertLabel.textAlignment=NSTextAlignmentCenter;
        alertLabel.layer.cornerRadius=5;
        alertLabel.backgroundColor=[UIColor colorWithWhite:0.2 alpha:1];
        alertLabel.textColor=[UIColor whiteColor];
        alertLabel.clipsToBounds=YES;
        alertLabel.layer.cornerRadius=5;
        [view addSubview:alertLabel];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:3.0 animations:^{alertLabel.alpha=0;} completion:^(BOOL finish){
            [alertLabel removeFromSuperview];
        }];
    }
}

@end

//
//  SJBookReadingView.h
//  tBook
//
//  Created by 陈少杰 on 15-1-24.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJBookReadingOperationView.h"

@interface SJBookReadingView : UIView
@property(nonatomic,readonly)UIView *backgroundView;
@property(nonatomic,readonly)UILabel *bookTitleLabel;
@property(nonatomic,readonly)UILabel *bookContentLabel;
@property(nonatomic,readonly)SJBookReadingOperationView *operationView;
@end

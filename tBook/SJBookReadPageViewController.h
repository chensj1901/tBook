//
//  SJBookReadPageViewController.h
//  tBook
//
//  Created by 陈少杰 on 15-1-24.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJBookService.h"
#import "SJCatalogViewController.h"

@interface SJBookReadPageViewController : UIPageViewController
@property(nonatomic)SJBookService *bookService;
@property(nonatomic)SJBookChapter *bookChapter;
@property(nonatomic,readonly)SJBookChapter *previousBookChapter;
@property(nonatomic,readonly)SJBookChapter *nextBookChapter;
@property(nonatomic)SJBook *book;
@property(nonatomic)UIButton *readBtn;
@property(nonatomic)SJCatalogViewController *catalogVC;
@property(nonatomic)UIView *readMaskView;
@end

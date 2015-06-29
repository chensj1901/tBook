//
//  SJBookReadingViewController.h
//  tBook
//
//  Created by 陈少杰 on 15-1-24.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBaseViewController.h"
#import "SJBookService.h"
#import "SJBookChapter.h"

@class SJBookReadingView;
@class SJBookReadingViewController;

@protocol SJBookReadingViewControllerDelegate <NSObject>
@property(nonatomic)SJBookService *bookService;
@property(nonatomic)SJBook *book;
@property(nonatomic)SJBookChapter *bookChapter;
@optional
-(void)bookReadingViewControllerDidRefreshBookContent:(SJBookReadingViewController*)vc;
-(void)bookReadingViewControllerDidNeedReadBook:(SJBookReadingViewController *)vc;
-(void)bookReadingViewControllerDidShowCatalog:(SJBookReadingViewController *)vc;
-(void)bookReadingViewControllerDidShowSourceWebsite:(SJBookReadingViewController *)vc;
-(void)bookReadingViewControllerDidShowComment:(SJBookReadingViewController *)vc;
-(void)bookReadingViewControllerDidHiddenToolbar:(SJBookReadingViewController *)vc;
-(void)bookReadingViewControllerDidShowToolbar:(SJBookReadingViewController *)vc;
@end

@interface SJBookReadingViewController : SJBaseViewController
@property(nonatomic,weak)id<SJBookReadingViewControllerDelegate>delegate;
@property(nonatomic)BOOL isPrevious;
@property(nonatomic)SJBookReadingView *mainView;
@end


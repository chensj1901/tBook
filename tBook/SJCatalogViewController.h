//
//  SJCatalogViewController.h
//  tBook
//
//  Created by 陈少杰 on 15/2/10.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBaseViewController.h"
#import "SJBookService.h"

@protocol SJCatalogViewControllerDelegate <NSObject>
-(void)catalogViewControllerDidSelectChapter:(SJBookChapter*)chapter;
@end

@interface SJCatalogViewController : UIViewController
@property(nonatomic,weak)SJBookService *bookService;
@property(nonatomic,weak)id<SJCatalogViewControllerDelegate>delegate;
-(void)reloadData;
@end

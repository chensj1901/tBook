//
//  SJBookDetailViewController.m
//  tBook
//
//  Created by 陈少杰 on 14/11/27.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJBookDetailViewController.h"
#import "SJBookDetailView.h"
#import "SJBookRecode.h"
#import "SJBookReadPageViewController.h"
#import <MMProgressHUD.h>
#import "SJBookService.h"
#import "SJBookCacheQueue.h"

@interface SJBookDetailViewController ()
@property(nonatomic)SJBookDetailView *mainView;

@end

@implementation SJBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.mainView loadBook:self.book];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTarget{
    [self.mainView.readNowBtn addTarget:self action:@selector(readNow) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.cacheAllBtn addTarget:self action:@selector(cacheAll) forControlEvents:UIControlEventTouchUpInside];
}

-(void)readNow{
    [SJBookRecode insertBook:self.book];
    
    SJBookReadPageViewController *charterVC=[[SJBookReadPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    charterVC.book=self.book;
    
//    self.navigationController.viewControllers=[[NSArray new]mutableCopy];
    [self.navigationController pushViewController:charterVC animated:YES];
}

-(void)cacheAll{
//    [MMProgressHUD showWithStatus:@"正在读取章节"];
    
    [[SJBookCacheQueue queue]addOperation:[SJBookCacheOperation operationWithBook:self.book]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

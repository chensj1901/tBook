//
//  SJViewController.m
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJIndexViewController.h"
#import "SJIndexView.h"
#import <AFNetworking.h>
#import "SJRegex.h"
#import "SJBook.h"
#import "SJBookDetailViewController.h"
#import "SJBookReadPageViewController.h"
#import "SJBookCell.h"
#import "SJSearchBookViewController.h"
#import "SJRankService.h"
#import "SJTipCell.h"

@interface SJIndexViewController ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate,UITextFieldDelegate>
@property(nonatomic)SJIndexView *mainView;
@end

@implementation SJIndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   [self.bookService loadLocalBooksWithSuccess:^{
       [self.mainView.resultTableView reloadData];
   } fail:^(NSError *error) {
       
   }];
    
}





-(void)loadTarget{
    self.mainView.resultTableView.dataSource=self;
    self.mainView.resultTableView.delegate=self;
    self.mainView.resultTableView.pullDelegate=self;
    
    self.mainView.searchTextField.delegate=self;
    
    if (IS_IOS7()) {
        self.mainView.resultTableView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    }
    
}

-(void)loadUI{
    
    self.view.backgroundColor=[UIColor yellowColor];
//    self.navigationItem.titleView=self.mainView.searchbarView;
    
    
}

-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.mainView.searchTextField resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MAX([self.bookService.locaBooks count],1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[self.bookService.locaBooks safeObjectAtIndex:indexPath.row];
    if (!book) {
        
        static NSString *cellId=@"SJTipCell";
        SJTipCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJTipCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell loadTip:@"书架为空，点击搜索添加几本吧！"];
        return cell;
    }else{
        static NSString *cellId=@"SJBOOKCELL";
        SJBookCell *bookCell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!bookCell) {
            bookCell=[[SJBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [bookCell loadBook:book];
        return bookCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[self.bookService.locaBooks safeObjectAtIndex:indexPath.row];
    if (!book) {
        SJSearchBookViewController *searchBookVC=[[SJSearchBookViewController alloc]init];
        [self.navigationController pushViewController:searchBookVC animated:YES];
    }else{
        if (!book.readingChapter) {
            SJBookDetailViewController *bookDetailVC=[[SJBookDetailViewController alloc]init];
            bookDetailVC.book=book;
            [self.navigationController pushViewController:bookDetailVC animated:YES];
        }else{
            SJBookReadPageViewController *readVC=[[SJBookReadPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            readVC.book=book;
            readVC.bookChapter=book.readingChapter;
            [self.navigationController pushViewController:readVC animated:YES];
        }

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SJBookCell cellHeight];
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        pullTableView.pullTableIsRefreshing=NO;
    });

}

-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        pullTableView.pullTableIsLoadingMore=NO;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end

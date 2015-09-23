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
//@synthesize mainView=_mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
}

//-(SJIndexView *)mainView{
//    if (!_mainView) {
//        _mainView=[[SJIndexView alloc]initWithFrame:MAINVIEW_HEIGHT_HASNAVBAR_NOTABBAR_RECT];
//    }
//    return _mainView;
//}


-(void)loadTarget{
    self.mainView.resultTableView.dataSource=self;
    self.mainView.resultTableView.delegate=self;
    self.mainView.resultTableView.pullDelegate=self;
    
    self.mainView.searchTextField.delegate=self;
    

    
}

-(void)loadUI{
    
    self.view.backgroundColor=[UIColor yellowColor];
//    self.navigationItem.titleView=self.mainView.searchbarView;
    
    
}

-(void)reloadLocationBooks{
    [self.bookService loadLocalBooksWithSuccess:^{
        [self.mainView.resultTableView reloadData];
        SJBook *book=[self.bookService.locaBooks safeObjectAtIndex:0];
        
        if(book&&book.isLoadingLastChapterName){
            [self reloadLastChapters];
        }
    } fail:^(NSError *error) {
        
    }];
    
}

-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

-(void)deleteWithIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[self.bookService.locaBooks safeObjectAtIndex:indexPath.row];
    [self.bookService deleteLocalBookWithBook:book];
    
    if ([self.bookService.locaBooks count]==0) {
        [self.mainView.resultTableView reloadData];
    }else{
        [self.mainView.resultTableView beginUpdates];
        [self.mainView.resultTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.mainView.resultTableView endUpdates];
    }
}

-(void)reloadLastChapters{
    for (SJBook *book in self.bookService.locaBooks) {
        [self.bookService loadBookChapterWithBook:book cacheMethod:SJCacheMethodFail success:^{
            SJBookChapter *lastChapter=[self.bookService.bookChapters lastObject];
            book.lastChapterName=lastChapter.chapterName;
            book.isLoadingLastChapterName=NO;
            
            NSInteger index=[self.bookService.locaBooks indexOfObject:book];
            @try {
                [self.mainView.resultTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        } fail:^(NSError *error) {
            
        }];
        NSLog(@"%@",book);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.mainView.searchTextField resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MAX([self.bookService.locaBooks count],1);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self deleteWithIndexPath:indexPath];
    }
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadLocationBooks];
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
    [self reloadLocationBooks];
}

@end

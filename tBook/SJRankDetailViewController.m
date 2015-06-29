//
//  SJRankDetailViewController.m
//  tBook
//
//  Created by 陈少杰 on 15/3/31.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRankDetailViewController.h"
#import "SJRankDetailView.h"
#import "SJBookDetailViewController.h"
#import "SJBookCell.h"
#import "SJBookService.h"
#import "SJBookDetailViewController.h"

@interface SJRankDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SJBookService *bookService;
@property(nonatomic)SJRankService *rankService;
@property(nonatomic)SJRankDetailView *mainView;
@end

@implementation SJRankDetailViewController

-(void)loadRank{
    [self.rankService loadFirstQidianRankWithType:self.rankType success:^{
        [self.mainView.detailTableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

-(void)loadMoreRank{
    [self.rankService loadMoreQidianRankWithType:self.rankType success:^{
        [self.mainView.detailTableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}


-(void)loadUI{
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.rankService.books safeObjectForKey:@(self.rankType)]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[[self.rankService.books safeObjectForKey:@(self.rankType)]safeObjectAtIndex:indexPath.row];
    static NSString *cellId=@"SJBOOKCELL";
    SJBookCell *bookCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!bookCell) {
        bookCell=[[SJBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [bookCell loadBook:book];
    return bookCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SJBookCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SJBook *book=[[self.rankService.books safeObjectForKey:@(self.rankType)]safeObjectAtIndex:indexPath.row];
    
    [self.bookService loadFirstBooksWithKeyWord:book.name success:^{
        SJBook *book=[self.bookService.searchResultBooks safeObjectAtIndex:0];
        SJBookDetailViewController *bookDetailVC=[[SJBookDetailViewController alloc]init];
        bookDetailVC.book=book;
        [self.navigationController pushViewController:bookDetailVC animated:YES];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadRank];
}

-(SJRankService *)rankService{
    if (!_rankService) {
        _rankService=[[SJRankService alloc]init];
    }
    return _rankService;
}

-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

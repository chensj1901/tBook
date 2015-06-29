//
//  SJSearchBookViewController.m
//  tBook
//
//  Created by 陈少杰 on 15/2/7.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSearchBookViewController.h"
#import "SJSearchBookView.h"
#import "SJBookService.h"
#import "SJSearchBookCell.h"
#import "SJBookDetailViewController.h"

@interface SJSearchBookViewController ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate,UITextFieldDelegate>

@property(nonatomic)SJBookService *bookService;
@property(nonatomic)SJSearchBookView *mainView;
@end

@implementation SJSearchBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSetting{
    IOS7_NOEXTENDED_LAYOUT();
}

-(void)loadTarget{
    [self.mainView.searchBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainView.resultTableView.delegate=self;
    self.mainView.resultTableView.dataSource=self;
    self.mainView.resultTableView.pullDelegate=self;
    self.mainView.searchBar.delegate=self;
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBook{
    [self loadFirstBooks];
}


-(void)loadFirstBooks{
    [self.bookService loadFirstBooksWithKeyWord:self.mainView.searchBar.text success:^{
        [self.mainView.resultTableView reloadData];
        self.mainView.resultTableView.pullTableIsRefreshing=NO;
    } fail:^(NSError *error) {
        
    }];
}

-(void)loadMoreBooks{
    [self.bookService loadMoreBooksWithKeyWord:self.mainView.searchBar.text success:^{
        [self.mainView.resultTableView reloadData];
        self.mainView.resultTableView.pullTableIsLoadingMore=NO;
    } fail:^(NSError *error) {
        
    }];
}

-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchBook];
    [self.mainView.searchBar resignFirstResponder];
    
    return YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bookService.searchResultBooks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[self.bookService.searchResultBooks objectAtIndex:indexPath.row];
    static NSString *cellId=@"SJBOOKCELL";
    SJSearchBookCell *bookCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!bookCell) {
        bookCell=[[SJSearchBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [bookCell loadBook:book];
    return bookCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[self.bookService.searchResultBooks objectAtIndex:indexPath.row];
    SJBookDetailViewController *bookDetailVC=[[SJBookDetailViewController alloc]init];
    bookDetailVC.book=book;
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJBook *book=[self.bookService.searchResultBooks objectAtIndex:indexPath.row];
    return [SJSearchBookCell cellHeightWithBook:book];
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self loadFirstBooks];
}

-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [self loadMoreBooks];
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

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
#import "SJSearchHitCell.h"

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

-(void)loadUI{
    
    self.mainView.resultTableView.delegate=self;
    self.mainView.resultTableView.dataSource=self;
    self.mainView.resultTableView.pullDelegate=self;
    
    self.mainView.searchHintTableView.delegate=self;
    self.mainView.searchHintTableView.dataSource=self;
    
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchBook];
    [self.mainView.searchBar resignFirstResponder];
    
    return YES;
}


-(void)textFieldChange:(NSNotification *)notification{
    UITextField *textField=notification.object;
    if (textField.selectedRange.length==0) {
        [self.bookService loadSearchHintWithKey:textField.text success:^{
            self.mainView.searchHintTableView.hidden=NO;
            [self.mainView.searchHintTableView reloadData];
        } fail:^(NSError *error) {
            
        }];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.mainView.searchHintTableView) {
        [self.mainView.searchHintTableView quicklySetHeight:[self.bookService.searchHintBooks count]*[SJSearchHitCell cellHeight]];
        return [self.bookService.searchHintBooks count];
    }else{
        return [self.bookService.searchResultBooks count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.mainView.searchHintTableView){
        SJBook *book=[self.bookService.searchHintBooks objectAtIndex:indexPath.row];
        static NSString *cellId=@"SJSearchHitCell";
        SJSearchHitCell *cell=[self.mainView.searchHintTableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJSearchHitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell loadBook:book];
        return cell;
        
    }else{
        SJBook *book=[self.bookService.searchResultBooks objectAtIndex:indexPath.row];
        static NSString *cellId=@"SJBOOKCELL";
        SJSearchBookCell *bookCell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!bookCell) {
            bookCell=[[SJSearchBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [bookCell loadBook:book];
        return bookCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.mainView.searchHintTableView) {
        SJBook *book=[self.bookService.searchHintBooks objectAtIndex:indexPath.row];
        self.mainView.searchBar.text=book.name;
        self.mainView.searchHintTableView.hidden=YES;
        [self searchBook];
    }else{
        SJBook *book=[self.bookService.searchResultBooks objectAtIndex:indexPath.row];
        SJBookDetailViewController *bookDetailVC=[[SJBookDetailViewController alloc]init];
        bookDetailVC.book=book;
        [self.navigationController pushViewController:bookDetailVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.mainView.searchHintTableView) {
        return [SJSearchHitCell cellHeight];
    }else{
        SJBook *book=[self.bookService.searchResultBooks objectAtIndex:indexPath.row];
        return [SJSearchBookCell cellHeightWithBook:book];
    }
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self loadFirstBooks];
}

-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [self loadMoreBooks];
}



-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.mainView.searchBar becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

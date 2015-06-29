//
//  SJCatalogViewController.m
//  tBook
//
//  Created by 陈少杰 on 15/2/10.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCatalogViewController.h"
#import "SJCatalogView.h"
#import "SJCatalogCell.h"

@interface SJCatalogViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SJCatalogView *mainView;
@end

@implementation SJCatalogViewController
@synthesize mainView=_mainView;


-(void)loadTarget{
    [self.mainView.progressSlider addTarget:self action:@selector(scrollDetailTableView) forControlEvents:UIControlEventValueChanged];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(nothing)];
    [self.mainView addGestureRecognizer:pan];
}

-(void)nothing{

}

-(void)loadView{
    self.view=self.mainView;
}

-(void)reloadData{
    [self.mainView.detailTableView reloadData];
    
    SJBookChapter *bookChapter=[self.bookService.bookChapters getObjectWithBlock:^BOOL(SJBookChapter* obj){
        return obj.isSelected;
    }];
    
    self.mainView.progressSlider.value=bookChapter._id/(CGFloat)[self.bookService.bookChapters count];
    [self scrollDetailTableView];
}

-(SJCatalogView *)mainView{
    if (!_mainView) {
        CGFloat width=250/320.*WIDTH;
        CGFloat height=350/480.*HEIGHT;
        _mainView=[[SJCatalogView alloc]initWithFrame:CGRectMake((WIDTH-width)/2, (HEIGHT-height)/2, width, height)];
        _mainView.detailTableView.dataSource=self;
        _mainView.detailTableView.delegate=self;
        _mainView.detailTableView.showsVerticalScrollIndicator=NO;
        _mainView.detailTableView.showsHorizontalScrollIndicator=NO;
    }
    return _mainView;
}

-(void)scrollDetailTableView{
    self.mainView.detailTableView.contentOffset=CGPointMake(0, (self.mainView.detailTableView.contentSize.height-self.mainView.detailTableView.bounds.size.height)*self.mainView.progressSlider.value);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.mainView.progressSlider.value=self.mainView.detailTableView.contentOffset.y/(self.mainView.detailTableView.contentSize.height-self.mainView.detailTableView.bounds.size.height);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bookService.bookChapters count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SJCatalogCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"SJCatalogCell";
    SJCatalogCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    SJBookChapter *chapter=[self.bookService.bookChapters safeObjectAtIndex:indexPath.row];
    if (!cell) {
        cell=[[SJCatalogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell loadChapter:chapter];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(catalogViewControllerDidSelectChapter:)]) {
        SJBookChapter *chapter=[self.bookService.bookChapters safeObjectAtIndex:indexPath.row];
        [self.delegate catalogViewControllerDidSelectChapter:chapter];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTarget];
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

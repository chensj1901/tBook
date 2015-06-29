//
//  SJRankViewController.m
//  tBook
//
//  Created by 陈少杰 on 15/2/11.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRankViewController.h"
#import "SJRankView.h"
#import "SJRankService.h"
#import "SJRankDetailViewController.h"
#import "SJRankCell.h"

@interface SJRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SJRankView *mainView;
@property(nonatomic)NSArray *ranks;
@end

@implementation SJRankViewController
-(NSArray *)ranks{
    if (!_ranks) {
        _ranks=@[@{@"name":@"男生榜",@"ranks":@[[SJRank rankWithName:@"起点月票榜" type:SJQidianTypeMonthRank rankImageName:@"n-y"],[SJRank rankWithName:@"起点推荐榜" type:SJQidianTypeRecommendRank rankImageName:@"n-t"],[SJRank rankWithName:@"起点点击榜" type:SJQidianTypeClickRank rankImageName:@"n-d"]]},@{@"name":@"女生榜",@"ranks":@[[SJRank rankWithName:@"起点粉红月票榜" type:SJQidianTypeGirlMonthRank rankImageName:@"g-y"],[SJRank rankWithName:@"起点女频推荐榜" type:SJQidianTypeGirlRecommendRank rankImageName:@"g-t"],[SJRank rankWithName:@"起点女频点击榜" type:SJQidianTypeGirlClickRank rankImageName:@"g-d"]]}];
    }
    return _ranks;
}

-(void)loadUI{
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.ranks count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.ranks safeObjectAtIndex:section]objectForKey:@"ranks"]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellId=@"SJRankCell";
    SJRankCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[SJRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    SJRank *rank=[[[self.ranks safeObjectAtIndex:indexPath.section]objectForKey:@"ranks"]safeObjectAtIndex:indexPath.row];
    [cell loadRank:rank];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SJRank *rank=[[[self.ranks safeObjectAtIndex:indexPath.section]objectForKey:@"ranks"]safeObjectAtIndex:indexPath.row];
    SJRankDetailViewController *detailVC=[[SJRankDetailViewController alloc]init];
    detailVC.rankType=rank.rankType;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

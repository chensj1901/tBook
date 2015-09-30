//
//  SJSettingViewController.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/4.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSettingViewController.h"
#import "SJSettingView.h"
#import "SJSettingCell.h"
#import "SJShareCenter.h"
#import "SJButtonActionSheet.h"
#import "SJWebViewController.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>
#import "SJRecommendAppCell.h"
#import "SJRecommendApp.h"
#import "SJRecommendAppService.h"
#import <MMProgressHUD.h>

@interface SJSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)SJSettingView *mainView;
@property(nonatomic)NSArray *titles;
@property(nonatomic)SJRecommendAppService *appService;
@end

@implementation SJSettingViewController

-(SJRecommendAppService *)appService{
    if (!_appService) {
        _appService=[[SJRecommendAppService alloc]init];
    }
    return _appService;
}

-(void)loadAppList{
    [self.appService loadAppListWithSuccess:^{
        [self.mainView.detailTableView reloadData];
    } fail:^(NSError *error) {

    }];
}

-(void)loadSetting{
    self.titles=@[@[@"免责声明",@"给我们打个分",@"把我们分享给好友"]];
}

-(void)loadUI{
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
}

-(void)download:(UIButton*)button{
    [MobClick event:@"01-03"];
    NSIndexPath*indexPath=[self.mainView.detailTableView indexPathForCellElement:button];
    SJRecommendApp *app=[self.appService.apps objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:app.url]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==[self.titles count]) {
        static NSString *str=@"cellId";
        SJRecommendApp *app=[self.appService.apps objectAtIndex:indexPath.row];
        SJRecommendAppCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell=[[SJRecommendAppCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            [[cell downloadButton]addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        }
        [cell setAppDesc:app.appDesc];
        [cell setAppName:app.appName];
        [cell setAppIconURL:app.appIcon];
        return cell;
    }else{
        static NSString *cellId=@"SJSettingCell";
        SJSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.titleLabel.text=[[self.titles safeObjectAtIndex:indexPath.section]safeObjectAtIndex:indexPath.row];
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.titles count]+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==[self.titles count]) {
        return [self.appService.apps count];
    }else{
        return [[self.titles safeObjectAtIndex:section]count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==[self.titles count]) {
        return 70;
    }else{
        return [SJSettingCell cellHeight];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *appIndexURL;
    

    NSString *appleID = @"1027240019";

    
    
    NSString *title=[[self.titles safeObjectAtIndex:indexPath.section]safeObjectAtIndex:indexPath.row];
    if ([title isEqualToString:@"免责声明"]){
        NSString *aboutStr=[[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"about" ofType:@"html"]]absoluteString];
        SJWebViewController *webVC=[[SJWebViewController alloc]init];
        webVC.isLocationFile=YES;
        webVC.webURL=aboutStr;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if ([title isEqualToString:@"给我们打个分"]){
        if (([[[UIDevice currentDevice]systemVersion]doubleValue])>=7.0) {
            appIndexURL=[NSString stringWithFormat: @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8", appleID];
        }else{
            appIndexURL = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appleID];
        }

        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appIndexURL]];
    }else if ([title isEqualToString:@"把我们分享给好友"]){
        if (([[[UIDevice currentDevice]systemVersion]doubleValue])>=7.0) {
            appIndexURL = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8", appleID];
        }
        SJButtonActionSheet *actionSheet=[[SJButtonActionSheet alloc]initWithTitle:@""];
        
        [actionSheet addButtonWithTitle:@"复制链接" image:[UIImage imageNamed:@"更多_复制链接"] block:^{
            [MobClick event:@"02-03"];
            UIPasteboard *pb=[UIPasteboard generalPasteboard];
            [pb setString:appIndexURL];
        }];
        
        if ([WXApi isWXAppInstalled]) {
        [actionSheet addButtonWithTitle:@"微信好友" image:[UIImage imageNamed:@"更多_icon_微信"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiSession url:appIndexURL content:@"好东西，网盘搜索神器，强烈推荐！"];
        }];
        
        [actionSheet addButtonWithTitle:@"朋友圈" image:[UIImage imageNamed:@"更多_icon_朋友圈"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiTimeline url:appIndexURL content:@"好东西，网盘搜索神器，强烈推荐！"];
        }];
        }
        
        if ([QQApi isQQInstalled]) {
        [actionSheet addButtonWithTitle:@"QQ" image:[UIImage imageNamed:@"更多_icon_QQ"] block:^{
            [SJShareCenter shareTo:ShareTypeQQ url:appIndexURL content:@"好东西，网盘搜索神器，强烈推荐！"];
        }];
        }
        
        [actionSheet showInView:nil];
        
    }else if (indexPath.section==[self.titles count]){
//        SJRecommendApp *app=[self.appService.apps objectAtIndex:indexPath.row];
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:app.url]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==[self.titles count]?40:0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==[self.titles count]?80:0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    [titleLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter text:@"应用精选"];
    titleLabel.backgroundColorHex=@"EEF0F3";
    return titleLabel;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadAppList];
}

-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"设置页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"设置页"];
}
@end

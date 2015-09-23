//
//  SJBookReadSettingViewController.m
//  tBook
//
//  Created by 陈少杰 on 15/9/21.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJBookReadSettingViewController.h"
#import "SJBookReadSettingView.h"
#import "SJSettingFontCell.h"
#import "SJSettingRecode.h"
#import "SJSettingBackgroundCell.h"
#import "SJSettingTextColorCell.h"
#import "SJSettingPreviewCell.h"

@interface SJBookReadSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SJBookReadSettingView *mainView;
@end

@implementation SJBookReadSettingViewController



-(void)loadUI{
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
    
    [self quicklyCreateRightItemWithTitle:@"恢复默认" titleColorHex:@"314746" titleHighlightedColorHex:nil selector:@selector(restore)];
}

-(void)loadTarget{
    
}

-(void)restore{
    BOOL isBlackModeNow=[[SJSettingRecode getSet:@"usingBlackMode"]boolValue];
    if (!isBlackModeNow) {
        [SJSettingRecode set:@"textColor" value:@"313746"];
        [SJSettingRecode set:@"backgroundStr" value:@"image:reading_background.jpg"];
    }else{
        [SJSettingRecode set:@"textColor" value:@"acacac"];
        [SJSettingRecode set:@"backgroundStr" value:@"color:000000"];
    }
    [self reloadPreview];
}

-(void)fontSizeChange:(UISlider *)slider{
    NSInteger fontPoint=12+24*slider.value;
    SJSettingFontCell *fontCell=[self.mainView.detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    fontCell.fontSizeLabel.text=[NSString stringWithFormat:@"字体 : %ld",(long)fontPoint];
    
    [SJSettingRecode set:@"textFont" value:[NSString stringWithFormat:@"%ld",(long)fontPoint]];
    [self reloadPreview];
    
}

-(void)setStyleOne{
    [SJSettingRecode set:@"backgroundStr" value:@"image:reading_background.jpg"];
    [self reloadPreview];
}

-(void)setStyleTwo{
    [SJSettingRecode set:@"backgroundStr" value:@"image:reading_background2.jpg"];
    [self reloadPreview];
    
}

-(void)reloadPreview{
    @try {
        [self.mainView.detailTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [self.mainView.detailTableView reloadData];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        static NSString *cellId=@"SJSettingFontCell";
        SJSettingFontCell *cell=[self.mainView.detailTableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJSettingFontCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            [cell.fontSizeSlider addTarget:self action:@selector(fontSizeChange:) forControlEvents:UIControlEventValueChanged];
        }
        return cell;
    }else if(indexPath.row==1){
        static NSString *cellId=@"SJSettingTextColorCell";
        SJSettingTextColorCell *cell=[self.mainView.detailTableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJSettingTextColorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColorSelectView.colorHasChanged=^(UIColor *color, CGPoint location){
                [SJSettingRecode set:@"textColor" value:[NSString stringWithFormat:@"%@",[color colorHex]]];
                
                [self reloadPreview];
            };
            
        }
        return cell;
    }else if(indexPath.row==2){
        static NSString *cellId=@"SJSettingBackgroundCell";
        SJSettingBackgroundCell *cell=[self.mainView.detailTableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJSettingBackgroundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColorSelectView.colorHasChanged=^(UIColor *color, CGPoint location){
                [SJSettingRecode set:@"backgroundStr" value:[NSString stringWithFormat:@"color:%@",[color colorHex]]];
                [self reloadPreview];
            };
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setStyleOne)];
            [cell.backgroundStyle1ImageView addGestureRecognizer:tap];
            
            UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setStyleTwo)];
            [cell.backgroundStyle2ImageView addGestureRecognizer:tap2];
        }
        return cell;
    }else{
        static NSString *cellId=@"SJSettingPreviewCell";
        SJSettingPreviewCell *cell=[self.mainView.detailTableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[SJSettingPreviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

        }
        [cell refreshUI];
        return cell;
        
    }
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    switch (indexPath.row) {
        case 0:
            height=[SJSettingFontCell cellHeight];
            break;
        case 1:
            height=[SJSettingBackgroundCell cellHeight];
            break;
        case 2:
            height=[SJSettingTextColorCell cellHeight];
            break;
        case 3:
            height=[SJSettingPreviewCell cellHeight];
            break;
        default:
            break;
    }
    return height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

//
//  SJTabSwitchViewController.m
//  tBook
//
//  Created by 陈少杰 on 15/2/7.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJTabSwitchViewController.h"
#import "SJTabSwitchView.h"
#import "SJIndexViewController.h"
#import "SJSearchBookViewController.h"
#import "SJRankViewController.h"

@interface SJTabSwitchViewController ()<SJSwitchViewControllerDelegate>
@property(nonatomic)SJTabSwitchView *mainView;
@end

@implementation SJTabSwitchViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        IOS7_LAYOUT();
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.mainView];
    self.navigationItem.titleView=self.mainView;
    
    self.navigationItem.title=@"书城";
    
    [self quicklyCreateRightButtonWithImageName:@"右侧推荐_搜索icon.png" highlightedImageName:nil selector:@selector(searchBook)];
    
    [self loadTarget];
}

-(void)searchBook{
    SJSearchBookViewController *searchBookVC=[[SJSearchBookViewController alloc]init];
    [self.navigationController pushViewController:searchBookVC animated:YES];
}

-(void)loadTarget{
    self.mainView.bookBtn.selected=YES;
    
    [self.mainView.bookBtn addTarget:self action:@selector(selectBook) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.squareBtn addTarget:self action:@selector(square) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.messageBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.profileBtn addTarget:self action:@selector(profile) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectBook{
    [self setShowingIndex:0 animate:YES];
}

-(void)square{
    [self setShowingIndex:1 animate:YES];
}

-(void)message{
    [self setShowingIndex:2 animate:YES];
    
}

-(void)profile{
    [self setShowingIndex:3 animate:YES];
}

-(SJTabSwitchView *)mainView{
    if (!_mainView) {
        CGFloat ios7Offset=IS_IOS7()?0:44;
        _mainView=[[SJTabSwitchView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-50-ios7Offset, WIDTH, 50)];
    }
    return _mainView;
}

-(NSInteger)numberOfSwitchViewController{
    return 2;
}

-(CGRect)rectOfView{
    return CGRectMake(0, 0, WIDTH, HEIGHT-50);
}

-(void)switchViewControllerDidStopAtIndex:(NSInteger)index{
    self.mainView.bookBtn.selected=index==0;
    self.mainView.squareBtn.selected=index==1;
    self.mainView.messageBtn.selected=index==2;
    self.mainView.profileBtn.selected=index==3;
}

-(UIViewController *)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index{
    UIViewController *vc;
    switch (index) {
        case 0:
        {
            SJIndexViewController *indexVC=[[SJIndexViewController alloc]init];
            vc=indexVC;
        }
            break;
            
        default:
        {
            SJRankViewController *rankVC=[[SJRankViewController alloc]init];
            vc=rankVC;
        }
            break;
    }
    return vc;
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

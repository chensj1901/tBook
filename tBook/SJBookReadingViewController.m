//
//  SJBookReadingViewController.m
//  tBook
//
//  Created by 陈少杰 on 15-1-24.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookReadingViewController.h"
#import "SJBookReadingView.h"
#import "SJBookChapterReadRecode.h"
#import <MMProgressHUD.h>
#import "SJSettingRecode.h"
#import "SJBookChapterReadRecode.h"


@interface SJBookReadingViewController ()<UIGestureRecognizerDelegate>
@end

@implementation SJBookReadingViewController
@synthesize mainView=_mainView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
   
}



-(void)loadTarget{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showToolBar)];
    [self.mainView.backgroundView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *hideTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideToolBar)];
    [self.mainView.operationView addGestureRecognizer:hideTap];
    UIPanGestureRecognizer *hidePan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hideToolBar)];
    [self.mainView.operationView addGestureRecognizer:hidePan];
    
    [self.mainView.operationView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.operationView.listenBtn addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.operationView.catalogBtn addTarget:self action:@selector(showCatalog) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.operationView.blackOrDayModeSwitchBtn addTarget:self action:@selector(blackOrDayModeSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.operationView.sourceWebsiteBtn addTarget:self action:@selector(showSourceWebsite) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.operationView.moreBtn addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadUI{
//    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
//    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
//    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [self.navigationController setToolbarItems:[NSArray arrayWithObjects:flexItem, one, flexItem, two, flexItem, nil]];
    
}

-(void)showToolBar{
    CGFloat nHeight=self.mainView.operationView.navigationBarView.frame.size.height;
    CGFloat tHeight=self.mainView.operationView.toolbarView.frame.size.height;
    
    [self.mainView.operationView.navigationBarView quicklySetOriginY:-nHeight];
    [self.mainView.operationView.toolbarView quicklySetOriginY:HEIGHT];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.operationView.alpha=1;
        [self.mainView.operationView.navigationBarView quicklySetOriginY:0];
        [self.mainView.operationView.toolbarView quicklySetOriginY:HEIGHT-tHeight];
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidShowToolbar:)]) {
            [self.delegate bookReadingViewControllerDidShowToolbar:self];
        }
    }];
}


-(void)hideToolBar{
    CGFloat nHeight=self.mainView.operationView.navigationBarView.frame.size.height;
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.operationView.alpha=0;
        [self.mainView.operationView.navigationBarView quicklySetOriginY:-nHeight];
        [self.mainView.operationView.toolbarView quicklySetOriginY:HEIGHT];
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidHiddenToolbar:)]) {
            [self.delegate bookReadingViewControllerDidHiddenToolbar:self];
        }
    }];
}

-(SJBookReadingView *)mainView{
    if (!_mainView) {
        _mainView=[[SJBookReadingView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [_mainView.operationView.sourceWebsiteBtn setTitle:[NSString stringWithFormat:@"源网站阅读\n%@",self.book.site] forState:UIControlStateNormal];
    }
    return _mainView;
}

-(void)loadData{
    [self.bookService loadContentWithChapter:self.bookChapter book:self.book success:^{
        
        NSString *string=[NSString stringWithContentsOfFile:self.bookChapter.filePathWithThisChapter encoding:NSUTF8StringEncoding error:nil];
        NSInteger i=0;
        if (self.readingText.length>0) {
            BOOL find=NO;
            while (!find&&self.readingText.length>0) {
                NSString *thisContent=[string substringWithRange:[[self.bookChapter.pageArr safeObjectAtIndex:i]rangeValue]];
                if ([thisContent rangeOfString:self.readingText].length>0) {
                    find=YES;
                    self.readingText=@"";
                    self.bookChapter.pageIndex=i;
                }else{
                    if (i<[self.bookChapter.pageArr count]-1) {
                        i++;
                    }else{
                        i=0;
                        if (self.readingText.length/2-1>0) {
                            self.readingText=[self.readingText substringToIndex:self.readingText.length/2-1];
                        }else{
                            self.readingText=@"";
                        }
                    }
                }
            }
            
        }
        [self reloadContent];
    }fail:^(NSError *error) {
        
    }];
}

-(void)reloadContent{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;

    NSString *string=[NSString stringWithContentsOfFile:self.bookChapter.filePathWithThisChapter encoding:NSUTF8StringEncoding error:nil];
    NSString *thisContent=[string substringWithRange:[[self.bookChapter.pageArr safeObjectAtIndex:self.bookChapter.pageIndex]rangeValue]];
    [self.mainView.readingStatusBarView loadChapter:self.bookChapter];
    [self.mainView.batteryImageView setElectricityValue:deviceLevel];
    
    NSString *backgroundStr=[SJSettingRecode getSet:@"backgroundStr"];
    NSString *type=[[backgroundStr componentsSeparatedByString:@":"]safeObjectAtIndex:0];
    NSString *value=[[backgroundStr componentsSeparatedByString:@":"]safeObjectAtIndex:1];
    
    if ([type rangeOfString:@"image"].length>0) {
        self.mainView.backgroundView.image=[UIImage imageNamed:value];
        self.mainView.backgroundView.backgroundColor=[UIColor clearColor];
    }else if ([type rangeOfString:@"color"].length>0){
        self.mainView.backgroundView.image=nil;
        self.mainView.backgroundView.backgroundColorHex=value;
    }
    
    [self.mainView.bookContentLabel quicklySetFontPoint:[[SJSettingRecode getSet:@"textFont"]intValue] textColorHex:[SJSettingRecode getSet:@"textColor"] textAlignment:NSTextAlignmentLeft];
    self.mainView.bookContentLabel.text=thisContent;
    self.mainView.operationView.blackOrDayModeSwitchBtn.selected=[[SJSettingRecode getSet:@"usingBlackMode"]boolValue];
    [self.mainView.readingStatusBarView refreshUI];
    
    
    [SJBookChapterReadRecode insertBookChapter:self.bookChapter];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return NO;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)read{
    [self hideToolBar];
    if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidNeedReadBook:)]) {
        [self.delegate bookReadingViewControllerDidNeedReadBook:self];
    }
}

-(void)blackOrDayModeSwitch:(UIButton*)btn{
    BOOL isBlackModeNow=btn.isSelected;
    
    if (isBlackModeNow) {
        
        [SJSettingRecode set:@"textColor" value:@"313746"];
        [SJSettingRecode set:@"backgroundStr" value:@"image:reading_background.jpg"];
    }else{
        
        [SJSettingRecode set:@"textColor" value:@"acacac"];
        [SJSettingRecode set:@"backgroundStr" value:@"color:000000"];
    }
    
    btn.selected=!isBlackModeNow;
    [SJSettingRecode set:@"usingBlackMode" value:btn.selected?@"1":@"0"];
    [self reloadContent];
}

-(void)showCatalog{
    if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidShowCatalog:)]) {
        [self.delegate bookReadingViewControllerDidShowCatalog:self];
    }
}

-(void)showSourceWebsite{
    if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidShowSourceWebsite:)]) {
        [self.delegate bookReadingViewControllerDidShowSourceWebsite:self];
    }

}

-(void)showComment{
    if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidShowComment:)]) {
        [self.delegate bookReadingViewControllerDidShowComment:self];
    }
}

-(void)set{
    if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidShowSetVC:)]) {
        [self.delegate bookReadingViewControllerDidShowSetVC:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SJBookReadPageViewController.m
//  tBook
//
//  Created by 陈少杰 on 15-1-24.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJBookReadPageViewController.h"
#import "SJBookReadingViewController.h"
#import "IFlyFlowerCollector.h"
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import "SJBookReadingView.h"
#import "SJBookChapterRecode.h"

@interface SJBookReadPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,SJBookReadingViewControllerDelegate,IFlySpeechSynthesizerDelegate,SJCatalogViewControllerDelegate>
@property(nonatomic)NSArray *bookContentSeparates;
@property(nonatomic)NSUInteger readIndex;
@property(nonatomic)IFlySpeechSynthesizer *speechSynthesizer;
@property(nonatomic)CGFloat nextPagePercent;
@property(nonatomic)NSString *readingText;
@property(nonatomic)BOOL shouldBeginRead;
@property(nonatomic)BOOL hasInit;
@end

@implementation SJBookReadPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hasInit=NO;
        
    }
    return self;
}

#pragma mark - 属性
-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

-(UIView *)readMaskView{
    if (!_readMaskView) {
        _readMaskView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopReading)];
        [_readMaskView addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(stopReading)];
        [_readMaskView addGestureRecognizer:pan];
    }
    return _readMaskView;
}

-(NSString*)thisBookContentPath{
    NSString *string=[NSString stringWithContentsOfFile:self.bookChapter.filePathWithThisChapter encoding:NSUTF8StringEncoding error:nil];
    return string;
}

-(NSString *)thisPageContent{
    return  [[self thisBookContentPath]substringWithRange:[[self.bookChapter.pageArr safeObjectAtIndex:self.bookChapter.pageIndex]rangeValue]];
}

-(IFlySpeechSynthesizer *)speechSynthesizer{
    if (!_speechSynthesizer) {
        _speechSynthesizer=[[IFlySpeechSynthesizer alloc]init];
        _speechSynthesizer.delegate=self;
        [_speechSynthesizer setParameter:@"100" forKey:@"speed"];
    }
    return _speechSynthesizer;
}

-(SJCatalogViewController *)catalogVC{
    if (!_catalogVC) {
        _catalogVC=[[SJCatalogViewController alloc]init];
        _catalogVC.delegate=self;
        _catalogVC.bookService=self.bookService;
    }
    return _catalogVC;
}

#pragma mark - 方法

-(void)loadChapterListWithMethod:(SJCacheMethod)cacheMethod{
    [self.bookService loadBookChapterWithBook:self.book cacheMethod:cacheMethod success:^{
        
        if (self.bookChapter) {
            [self.bookService.bookChapters enumerateObjectsUsingBlock:^(SJBookChapter* chapter, NSUInteger idx, BOOL *stop) {
                if ([self.bookChapter.chapterName isEqualToString:chapter.chapterName]) {
                    self.bookChapter.isSelected=YES;
                    self.bookChapter.gid=chapter.gid;
                    self.bookChapter._id=chapter._id;
                    [self.bookService.bookChapters replaceObjectAtIndex:idx withObject:self.bookChapter];
                    chapter.isSelected=YES;
                }
            }];
        }else{
            SJBookChapter *chapter=[self.bookService.bookChapters safeObjectAtIndex:0];
            if (chapter) {
                chapter.isSelected=YES;
                self.bookChapter=chapter;
            }
        }
        

        
        if (!self.hasInit) {
            self.hasInit=YES;
            SJBookReadingViewController *bookReadingVC=[[SJBookReadingViewController alloc]init];
            bookReadingVC.delegate=self;
            bookReadingVC.book=self.book;
            bookReadingVC.bookChapter=self.bookChapter;
            bookReadingVC.bookService=self.bookService;
            
            [self setViewControllers:@[bookReadingVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
        
    } fail:^(NSError *error) {
        
    }];
}

-(void)readIndex:(NSUInteger)index{
    NSRange curRange=[self.bookContentSeparates[self.readIndex]rangeValue];
    NSString* readText=[self.thisBookContentPath substringWithRange:curRange];
    [self.speechSynthesizer stopSpeaking];
    [self.speechSynthesizer startSpeaking:readText];
    
    self.readingText=readText;
    
    NSRange yellowRange=[[self thisPageContent]rangeOfString:readText];
    if (yellowRange.length>0) {
        [self setTextHightAtRange:yellowRange];
        self.nextPagePercent=0;
    }else{//翻页
        NSInteger lenght=readText.length;
        NSInteger location=readText.length-1;
        NSRange resultRange;
        while (lenght>0) {
            lenght/=2;
            NSString *subReadText=[readText substringWithRange:NSMakeRange(0, location)];
            if ([[self thisPageContent]rangeOfString:subReadText].length>0) {
                location+=lenght;
                resultRange=[[self thisPageContent]rangeOfString:subReadText];
            }else{
                location-=lenght;
            }
        }
        self.nextPagePercent=(float)location/readText.length;
        [self setTextHightAtRange:resultRange];
    }
    
    
    //    AVSpeechSynthesizer *av=[[AVSpeechSynthesizer alloc]init];
    //
    //    AVSpeechUtterance *ut=[[AVSpeechUtterance alloc]initWithString:self.thisKDBookContent];
    //    ut.rate=AVSpeechUtteranceMaximumSpeechRate;
    //
    //    [av speakUtterance:ut];
}

-(void)setTextHightAtRange:(NSRange)range{
    SJBookReadingViewController *pageVC=[self.viewControllers objectAtIndex:0];
    [pageVC.mainView.bookContentLabel quicklyHighlightedTextWithRange:range];
}

-(void)onSpeakProgress:(int)progress{
    if (self.nextPagePercent) {
        if (progress>self.nextPagePercent*100) {
            CGFloat nextPagePercent=self.nextPagePercent;
            [self nextPageWithComplete:^(BOOL finished) {
                NSInteger readedTextLenght=self.readingText.length*nextPagePercent;
                NSInteger nextTextLenght=self.readingText.length-readedTextLenght;
                if (nextTextLenght>3) {
                    NSRange nextRange=NSMakeRange(readedTextLenght+3, nextTextLenght-3);
                    NSString *subText=[self.readingText substringWithRange:nextRange];
                    NSRange highLightRange=[[self thisPageContent]rangeOfString:subText];
                    [self setTextHightAtRange:highLightRange];
                }
            }];
            self.nextPagePercent=0;
        }
    }
}

-(void)nextPageWithComplete:(void (^)(BOOL finished))finishBlock{
    UIViewController *nextVC=[self pageViewController:self viewControllerAfterViewController:nil];
    [self setViewControllers:@[nextVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished){
    }];


}

-(void)onCompleted:(IFlySpeechError *)error{
    NSLog(@"%@",error.errorDesc);
    [self dealWithCompleteWithCancel:NO isBegan:NO error:error];
}

-(void)onSpeakCancel{
    [self dealWithCompleteWithCancel:YES isBegan:NO error:nil];
}

-(void)onSpeakBegin{
    [self dealWithCompleteWithCancel:NO isBegan:YES error:nil];
}

-(void)dealWithCompleteWithCancel:(BOOL)isCancel isBegan:(BOOL)isBegan error:(IFlySpeechError*)error{
    static BOOL cancelTag=NO;
    if (isCancel) {
        cancelTag=YES;
    }else if(isBegan){
        cancelTag=NO;
    }else{
        if (error.errorCode==0&&!cancelTag)
        {

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.readIndex++;
                if (self.readIndex<[self.bookContentSeparates count]) {
                    [self readIndex:self.readIndex];
                }else{
                    self.shouldBeginRead=YES;
                    [self nextPageWithComplete:^(BOOL finished) {
                    }];
                }
            });
        }else{
            self.shouldBeginRead=NO;
            
        }
    }
}


-(void)stopReading{
    self.shouldBeginRead=NO;
    [self.speechSynthesizer stopSpeaking];
    self.readIndex=[self.bookContentSeparates count];
    [self setTextHightAtRange:NSMakeRange(0, 0)];
    [self.readMaskView removeFromSuperview];
}

-(void)read{
    NSRange contentRange=[self.thisBookContentPath rangeOfString:[self thisPageContent]];
    
    self.bookContentSeparates=[self.thisBookContentPath intelligentWordRangeWithBeginLocation:contentRange.length>0?contentRange.location:0];
    
    self.readIndex=0;
    [self readIndex:self.readIndex];
    
    [[[[UIApplication sharedApplication]windows]objectAtIndex:0]addSubview:self.readMaskView];
    
}


#pragma mark - 代理

-(void)bookReadingViewControllerDidRefreshBookContent:(SJBookReadingViewController *)vc{
    if (self.shouldBeginRead) {
        self.shouldBeginRead=NO;
        [self read];
    }
}

-(void)bookReadingViewControllerDidNeedReadBook:(SJBookReadingViewController *)vc{
    [self read];
}

-(void)bookReadingViewControllerDidShowCatalog:(SJBookReadingViewController *)vc{
    [self.catalogVC reloadData];
    [self.view addSubview:self.catalogVC.view];
}

-(void)bookReadingViewControllerDidShowSourceWebsite:(SJBookReadingViewController *)vc{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[self.bookChapter.curl hasPrefix:@"http"]?self.bookChapter.curl:[NSString stringWithFormat:@"http://%@",self.bookChapter.curl]]];
}

-(void)bookReadingViewControllerDidHiddenToolbar:(SJBookReadingViewController *)vc{
    [self.catalogVC.view removeFromSuperview];
}

-(void)bookReadingViewControllerDidShowToolbar:(SJBookReadingViewController *)vc{
    [self stopReading];
}

-(void)catalogViewControllerDidSelectChapter:(SJBookChapter *)chapter{
    [self.catalogVC.view removeFromSuperview];
    
    if(chapter!=self.bookChapter){
        chapter.pageIndex=0;
        chapter.isSelected=YES;
        self.bookChapter.isSelected=NO;
        self.bookChapter=chapter;
    }
        
    SJBookReadingViewController *bookReadingVC=[[SJBookReadingViewController alloc]init];
    bookReadingVC.delegate=self;
    bookReadingVC.book=self.book;
    bookReadingVC.bookChapter=self.bookChapter;
    bookReadingVC.bookService=self.bookService;
    
    [self setViewControllers:@[bookReadingVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}

-(SJBookChapter *)nextBookChapter{
    NSInteger index=[self.bookService.bookChapters getObjectIndexWithBlock:^BOOL(id obj) {
        return obj==self.bookChapter;
    }];
    
    SJBookChapter *chapter=[self.bookService.bookChapters safeObjectAtIndex:++index];
    return chapter;
}

-(SJBookChapter *)previousBookChapter{
    NSInteger index=[self.bookService.bookChapters getObjectIndexWithBlock:^BOOL(id obj) {
        return obj==self.bookChapter;
    }];
    
    SJBookChapter *chapter=[self.bookService.bookChapters safeObjectAtIndex:--index];
    return chapter;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (self.bookChapter._id==[self.bookService.bookChapters count]-1&&self.bookChapter.pageIndex==[self.bookChapter.pageArr count]-1) {
        return nil;
    }else{
        if (self.bookChapter.pageIndex<[self.bookChapter.pageArr count]-1) {
            self.bookChapter.pageIndex++;
        }else{
            self.bookChapter=self.nextBookChapter;
        }
        
        SJBookReadingViewController *bookReadingVC=[[SJBookReadingViewController alloc]init];
        bookReadingVC.delegate=self;
        bookReadingVC.book=self.book;
        bookReadingVC.bookChapter=self.bookChapter;
        bookReadingVC.bookService=self.bookService;
        return bookReadingVC;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (self.bookChapter._id==0&&self.bookChapter.pageIndex==0) {
        return nil;
    }else{
        if (self.bookChapter.pageIndex>0) {
            self.bookChapter.pageIndex--;
        }else{
            self.bookChapter=self.previousBookChapter;
        }
        
        SJBookReadingViewController *bookReadingVC=[[SJBookReadingViewController alloc]init];
        bookReadingVC.delegate=self;
        bookReadingVC.isPrevious=YES;
        bookReadingVC.book=self.book;
        bookReadingVC.bookChapter=self.bookChapter;
        bookReadingVC.bookService=self.bookService;
        return bookReadingVC;
    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    
    self.dataSource=self;
    self.delegate=self;
    
    [self loadChapterListWithMethod:SJCacheMethodOnlyCache];
    [self loadChapterListWithMethod:SJCacheMethodNone];
}

-(void)viewWillAppear:(BOOL)animated{
//    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

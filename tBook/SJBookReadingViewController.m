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
    [self.mainView.operationView.sourceWebsiteBtn addTarget:self action:@selector(showSourceWebsite) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadUI{
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.navigationController setToolbarItems:[NSArray arrayWithObjects:flexItem, one, flexItem, two, flexItem, nil]];
}

-(void)showToolBar{
    CGFloat nHeight=self.mainView.operationView.navigationBarView.frame.size.height;
    CGFloat tHeight=self.mainView.operationView.toolbarView.frame.size.height;
    
    [self.mainView.operationView.navigationBarView quicklySetOriginY:-nHeight];
    [self.mainView.operationView.toolbarView quicklySetOriginY:HEIGHT];
    
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
    }
    return _mainView;
}

-(void)loadData{
    KDBook *kdBook=self.delegate.bookChapter.kdBook;
    NSLog(@"%@-%@",self.delegate.bookChapter,self.delegate);
    if (!kdBook) {
        [MMProgressHUD showWithTitle:@"努力搬书中..."];
        [self.delegate.bookService loadContentWithChapter:self.delegate.bookChapter book:self.delegate.book success:^{
            [MMProgressHUD dismiss];
            KDBook *kdBook=self.delegate.bookChapter.kdBook;
            NSLog(@"%@-%@",self.delegate.bookChapter,self.delegate);
            if (self.isPrevious) {
                self.delegate.bookChapter.pageIndex=kdBook.pageTotal-1;
            }else{
                self.delegate.bookChapter.pageIndex=0;
            }
            [self loadContentWithKDBook:kdBook];
            if ([self.delegate respondsToSelector:@selector(bookReadingViewControllerDidRefreshBookContent:)]) {
                [self.delegate bookReadingViewControllerDidRefreshBookContent:self];
            }
        } fail:^(NSError *error) {
            [MMProgressHUD dismissWithError:error.domain];
        }];
    }else{
        if (self.isPrevious) {
            if (self.delegate.bookChapter.pageIndex==0) {
                if (self.delegate.bookChapter._id>0) {
                    self.delegate.bookChapter.isSelected=NO;
                    self.delegate.bookChapter=[self.delegate.bookService.bookChapters objectAtIndex:self.delegate.bookChapter._id-1];
                    self.delegate.bookChapter.isSelected=YES;
                    if (self.delegate.bookChapter) {
                        self.delegate.bookChapter.kdBook=nil;
                        [self loadData];
                    }
                }
            }else{
                self.delegate.bookChapter.pageIndex--;
                [self loadContentWithKDBook:kdBook];
            
            }
        }else{
            if (self.delegate.bookChapter.pageIndex==kdBook.pageTotal-1) {
                if (self.delegate.bookChapter._id<[self.delegate.bookService.bookChapters count]-1) {
                    self.delegate.bookChapter.isSelected=NO;
                    self.delegate.bookChapter=[self.delegate.bookService.bookChapters objectAtIndex:self.delegate.bookChapter._id+1];
                    self.delegate.bookChapter.isSelected=YES;
                    if (self.delegate.bookChapter) {
                        self.delegate.bookChapter.kdBook=nil;
                        [self loadData];
                    }
                }else{
                    self.delegate.bookChapter.pageIndex--;
                    [self loadContentWithKDBook:kdBook];
                    
                }
            }else{
                self.delegate.bookChapter.pageIndex++;
                [self loadContentWithKDBook:kdBook];
                
            }
        
        }
        
//        [self loadContentWithKDBook:kdBook];
    }

}

-(void)loadContentWithKDBook:(KDBook*)kdBook{
    self.mainView.bookContentLabel.text=[kdBook stringWithPage:self.delegate.bookChapter.pageIndex];
    [SJBookChapterReadRecode insertBookChapter:self.delegate.bookChapter];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

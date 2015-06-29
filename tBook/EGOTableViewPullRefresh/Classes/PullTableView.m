//
//  PullTableView.m
//  TableViewPull
//
//  Created by Emre Berge Ergenekon on 2011-07-30.
//  Copyright 2011 Emre Berge Ergenekon. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "PullTableView.h"

@interface PullTableView (Private) <UIScrollViewDelegate>
- (void) config;
- (void) configDisplayProperties;
@end

@implementation PullTableView

# pragma mark - Initialization / Deallocation

@synthesize pullDelegate;
@synthesize refreshView=_refreshView;
@synthesize loadMoreView=_loadMoreView;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        loadMoreSwitch=YES;
        refreshSwitch=YES;
        [self config];
        
    }
    
    return self;
}
-(id)initWithFrame:(CGRect)frame loadMoreSwitch:(BOOL)isPull refreshSwitch:(BOOL)isRefresh style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        loadMoreSwitch=isPull;
        refreshSwitch=isRefresh;
        [self config];
    }
    
    return self;
}


-(id)initWithFrame:(CGRect)frame loadMoreSwitch:(BOOL)isPull refreshSwitch:(BOOL)isRefresh{
    self=[super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        loadMoreSwitch=isPull;
        refreshSwitch=isRefresh;
        [self config];
    }

    return self;
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    [self config];
}


- (void)dealloc {
    delegateInterceptor = nil;
}

# pragma mark - Custom view configuration

- (void) config
{
    /* Message interceptor to intercept scrollView delegate messages */
    delegateInterceptor = [[MessageInterceptor alloc] init];
    delegateInterceptor.middleMan = self;
    delegateInterceptor.receiver = self.delegate;
    super.delegate = (id)delegateInterceptor;
    
    /* Status Properties */
    pullTableIsRefreshing = NO;
    pullTableIsLoadingMore = NO;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.backgroundColor=[UIColor clearColor];
    /* Refresh View */
    
    
    if (refreshSwitch) {
        _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        _refreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _refreshView.delegate = self;
        [self addSubview:_refreshView];
    }
    
    /* Load more view init */
    
    if (loadMoreSwitch) {
        _loadMoreView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        _loadMoreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _loadMoreView.delegate = self;
        [self addSubview:_loadMoreView];
    }
    
}


# pragma mark - View changes

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat visibleTableDiffBoundsHeight = (self.bounds.size.height - MIN(self.bounds.size.height, self.contentSize.height));
    
    CGRect loadMoreFrame = _loadMoreView.frame;
    loadMoreFrame.origin.y = self.contentSize.height + visibleTableDiffBoundsHeight;
    _loadMoreView.frame = loadMoreFrame;
    
    
    
}

#pragma mark - Preserving the original behaviour

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if(delegateInterceptor) {
        super.delegate = nil;
        delegateInterceptor.receiver = delegate;
        super.delegate = (id)delegateInterceptor;
    } else {
        super.delegate = delegate;
    }
}

- (void)reloadData
{
    [super reloadData];
    // Give the footers a chance to fix it self.
    [_loadMoreView egoRefreshScrollViewDidScroll:self];
    
    if ([self.pullDelegate respondsToSelector:@selector(pullTableViewDidReloadData:)]) {
        [self.pullDelegate performSelector:@selector(pullTableViewDidReloadData:) withObject:self];
    }
}

#pragma mark - Status Propreties

@synthesize pullTableIsRefreshing;
@synthesize pullTableIsLoadingMore;

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    if(!pullTableIsRefreshing && isRefreshing) {
        // If not allready refreshing start refreshing
        [_refreshView startAnimatingWithScrollView:self];
        pullTableIsRefreshing = YES;
    } else if(pullTableIsRefreshing && !isRefreshing) {
        [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        pullTableIsRefreshing = NO;
        
    }
}

- (void)setPullTableIsLoadingMore:(BOOL)isLoadingMore
{
    if(!pullTableIsLoadingMore && isLoadingMore) {
        // If not allready loading more start refreshing
        [_loadMoreView startAnimatingWithScrollView:self];
        pullTableIsLoadingMore = YES;
    } else if(pullTableIsLoadingMore && !isLoadingMore) {
//        @try {
//            [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:offsetRow inSection:offsetSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        }
//        @catch (NSException *exception) { }
//        @finally { }
        [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        pullTableIsLoadingMore = NO;
        
        if ([self.pullDelegate respondsToSelector:@selector(pullTableViewDidEndLoadMore:)]) {
            [self.pullDelegate performSelector:@selector(pullTableViewDidEndLoadMore:) withObject:self];
        }
    }
}

#pragma mark - Display properties

@synthesize pullArrowImage;
@synthesize pullRefreshingBackgroundColor;
@synthesize pullLoadingBackgroundColor;
@synthesize pullRefreshingBackgroundTextColor;
@synthesize pullLoadingBackgroundTextColor;
@synthesize pullLastRefreshDate;

- (void)configDisplayProperties
{
    [_refreshView setBackgroundColor:self.pullRefreshingBackgroundColor textColor:self.pullRefreshingBackgroundTextColor arrowImage:self.pullArrowImage];
    [_loadMoreView setBackgroundColor:self.pullLoadingBackgroundColor textColor:self.pullLoadingBackgroundTextColor arrowImage:self.pullArrowImage];
}

- (void)setPullArrowImage:(UIImage *)aPullArrowImage
{
    if(aPullArrowImage != pullArrowImage) {
        pullArrowImage = aPullArrowImage ;
        [self configDisplayProperties];
    }
}

- (void)setPullRefreshingBackgroundColor:(UIColor *)aColor
{
    if(aColor != pullRefreshingBackgroundColor) {
        pullRefreshingBackgroundColor = aColor ;
        [self configDisplayProperties];
    }
}

- (void)setPullLoadingBackgroundColor:(UIColor *)aColor
{
    if(aColor != pullLoadingBackgroundColor) {
        pullLoadingBackgroundColor = aColor;
        [self configDisplayProperties];
    }
}

- (void)setPullRefreshingBackgroundTextColor:(UIColor *)aColor
{
    if(aColor != pullRefreshingBackgroundTextColor) {
        pullRefreshingBackgroundTextColor = aColor;
        [self configDisplayProperties];
    } 
}


- (void)setPullLoadingBackgroundTextColor:(UIColor *)aColor
{
    if(aColor != pullLoadingBackgroundTextColor) {
        pullLoadingBackgroundTextColor = aColor;
        [self configDisplayProperties];
    }
}

- (void)setPullLastRefreshDate:(NSDate *)aDate
{
    if(aDate != pullLastRefreshDate) {
        pullLastRefreshDate = aDate;
        [_refreshView refreshLastUpdatedDate];
    }
}

-(BOOL)touchWithEvent:(UIEvent *)event state:(UIGestureRecognizerState)state{
    UITouch *touch=[[event allTouches]anyObject];
    if (touch.tapCount<=1) {
        static CGPoint startPoint;
        if (state==UIGestureRecognizerStateBegan) {
            startPoint=[touch locationInView:self];
        }
        
        if (touch&&(state==UIGestureRecognizerStateEnded||state==UIGestureRecognizerStateCancelled)) {
            CGPoint endPoint=[touch locationInView:self];
            if (ABS(endPoint.y-startPoint.y)>20||ABS(endPoint.x-startPoint.x)>20) {
                CGFloat angle=atan2(endPoint.y-startPoint.y, endPoint.x-startPoint.x);
                if (angle>-M_PI/4&&angle<M_PI/4) {
                    if ([self.pullDelegate respondsToSelector:@selector(pullTableView:didTouchWithType:)]) {
                        [self.pullDelegate pullTableView:self didTouchWithType:PullTableViewTouchTypeRight];
                        return NO;
                    }
                }else if(angle>M_PI*3/4||angle<-M_PI*3/4){
                    if ([self.pullDelegate respondsToSelector:@selector(pullTableView:didTouchWithType:)]) {
                        [self.pullDelegate pullTableView:self didTouchWithType:PullTableViewTouchTypeLeft];
                        return NO;
                    }
                }
            }
            
        }
    }
    return YES;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreView egoRefreshScrollViewDidScroll:scrollView];
    
    // Also forward the message to the real delegate
    if ([delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [delegateInterceptor.receiver scrollViewDidScroll:scrollView];
    }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreView egoRefreshScrollViewDidEndDragging:scrollView];
    
    // Also forward the message to the real delegate
    if ([delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [delegateInterceptor.receiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_refreshView egoRefreshScrollViewWillBeginDragging:scrollView];
    
    // Also forward the message to the real delegate
    if ([delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [delegateInterceptor.receiver scrollViewWillBeginDragging:scrollView];
    }
}



#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    pullTableIsRefreshing = YES;
    if ([pullDelegate respondsToSelector:@selector(pullTableViewDidTriggerRefresh:)]) {
        [pullDelegate pullTableViewDidTriggerRefresh:self];
    }
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return self.pullLastRefreshDate;
}

#pragma mark - LoadMoreTableViewDelegate

- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    offsetSection=[self numberOfSections]-1;
    offsetRow=[self numberOfRowsInSection:offsetSection]-1;
    pullTableIsLoadingMore = YES;
    
    if ([pullDelegate respondsToSelector:@selector(pullTableViewDidTriggerLoadMore:)]) {
        [pullDelegate pullTableViewDidTriggerLoadMore:self];
    }
}


-(void)setShowRefreshing:(BOOL)showRefreshing{
        _refreshView.hidden=!showRefreshing;
    if (!_refreshView) {
        [_refreshView removeFromSuperview];
        _refreshView=nil;
    }
        
}


#pragma mark - 重载touch事件

-(BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL shouldWakeUpSuperEvent=[self touchWithEvent:event state:UIGestureRecognizerStateBegan];
    if (shouldWakeUpSuperEvent) {
        [super touchesBegan:touches withEvent:event];
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL shouldWakeUpSuperEvent=[self touchWithEvent:event state:UIGestureRecognizerStateChanged];
    if (shouldWakeUpSuperEvent) {
        [super touchesMoved:touches withEvent:event];
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL shouldWakeUpSuperEvent=[self touchWithEvent:event state:UIGestureRecognizerStateEnded];
    if (shouldWakeUpSuperEvent) {
        [super touchesEnded:touches withEvent:event];
    }

}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL shouldWakeUpSuperEvent=[self touchWithEvent:event state:UIGestureRecognizerStateCancelled];
    if (shouldWakeUpSuperEvent) {
        [super touchesCancelled:touches withEvent:event];
    }
}
@end

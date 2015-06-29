//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
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

#import "EGORefreshTableHeaderView.h"


@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullState)aState;
@end

@implementation EGORefreshTableHeaderView
{
    
    CGRect _waitingImageViewRect;
    CGRect _waitingLoadingImageViewRect;
    CGRect _waitingPullImageViewRect;
}

@synthesize delegate=_delegate;
@synthesize waitingImageView=_waitingImageView;
@synthesize waitingLoadingImageView=_waitingLoadingImageView;
@synthesize waitingPullImageView=_waitingPullImageView;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self loadSetting];
        [self loadUI];
        
        if (IS_IOS7()) {
            _defaultEdgeInsets=UIEdgeInsetsMake(64, 0, 0, 0);
        }
		
        isLoading = NO;
        
//        CGFloat midY = frame.size.height - PULL_AREA_HEIGTH/2;
        
        /* Config Last Updated Label */
//		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY, self.frame.size.width, 20.0f)];
//		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		label.font = [UIFont boldSystemFontOfSize:12.0f];
//		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
//		label.backgroundColor = [UIColor clearColor];
//		label.textAlignment = NSTextAlignmentCenter;
//		[self addSubview:label];
//		//_lastUpdatedLabel=label;
		
        /* Config Status Updated Label */
//		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY - 18, self.frame.size.width, 20.0f)];
//		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		label.font = [UIFont boldSystemFontOfSize:13.0f];
//		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
//		label.backgroundColor = [UIColor clearColor];
//		label.textAlignment = NSTextAlignmentCenter;
//		[self addSubview:label];
//		//_statusLabel=label;
		
        /* Config Arrow Image */
//		CALayer *layer = [[CALayer alloc] init];
//		layer.frame = CGRectMake(25.0f,midY - 35, 30.0f, 55.0f);
//		layer.contentsGravity = kCAGravityResizeAspect;
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
//		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//			layer.contentsScale = [[UIScreen mainScreen] scale];
//		}
//#endif
//		[[self layer] addSublayer:layer];
//		//_arrowImage=layer;
		
        /* Config activity indicator */
//		HZActivityIndicatorView *view = [[HZActivityIndicatorView alloc] initWithActivityIndicatorStyle:DEFAULT_ACTIVITY_INDICATOR_STYLE];
//		view.frame = CGRectMake(25.0f,midY - 8, 20.0f, 20.0f);
//		[self addSubview:view];
//		_activityView = view;		
		
		[self setState:EGOOPullNormal];
        
        /* Configure the default colors and arrow image */
        [self setBackgroundColor:nil textColor:nil arrowImage:nil];
		
    }
	
    return self;
	
}

-(void)loadSetting{
    _waitingImageViewRect= CGRectMake((WIDTH-40)/2, SELF_HEIGHT-40, 40, 40);
    _waitingLoadingImageViewRect= CGRectMake(0, 0, 40, 40);
    _waitingPullImageViewRect= CGRectMake(0, 0, 40, 40);
}

-(void)loadUI{
    [self addSubview:self.waitingImageView];
    [self.waitingImageView addSubview:self.waitingLoadingImageView];
    [self.waitingImageView addSubview:self.waitingPullImageView];
}

#pragma mark - 属性定义

-(UIImageView *)waitingImageView{
    if (!_waitingImageView) {
        _waitingImageView=[[UIImageView alloc]initWithFrame:_waitingImageViewRect];
        _waitingImageView.image=[UIImage imageNamed:@"刷新底_.png"];
        _waitingImageView.hidden=YES;
    }
    return _waitingImageView;
}


-(UIImageView *)waitingLoadingImageView{
    if (!_waitingLoadingImageView) {
        _waitingLoadingImageView=[[UIImageView alloc]initWithFrame:_waitingLoadingImageViewRect];
        _waitingLoadingImageView.image=[UIImage imageNamed:@"刷新logo0_.png"];
        _waitingLoadingImageView.hidden=YES;
    }
    return _waitingLoadingImageView;
}

-(UIImageView *)waitingPullImageView{
    if (!_waitingPullImageView) {
        _waitingPullImageView=[[UIImageView alloc]initWithFrame:_waitingPullImageViewRect];
        _waitingPullImageView.image=[UIImage imageNamed:@"刷新下拉_.png"];
        _waitingPullImageView.hidden=YES;
    }
    return _waitingPullImageView;
}

#pragma mark -
#pragma mark Setters

#define aMinute 60
#define anHour 3600
#define aDay 86400

- (void)refreshLastUpdatedDate {
    NSDate * date = nil;
    //[_activityView respondsToSelector:@selector(i)];
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
		date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
	}
    if(date) {
        NSTimeInterval timeSinceLastUpdate = [date timeIntervalSinceNow];
        NSInteger timeToDisplay = 0;
        timeSinceLastUpdate *= -1;
        
        if(timeSinceLastUpdate < anHour) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / aMinute);
            
            if(timeToDisplay == /* Singular*/ 1) {
            //_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"更新于 %ld 分钟前",@"PullTableViewLan",@"Last uppdate in minutes singular"),(long)timeToDisplay];
            } else {
                /* Plural */
                //_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"更新于 %ld 分钟 前",@"PullTableViewLan",@"Last uppdate in minutes plural"), (long)timeToDisplay];

            }
            
        } else if (timeSinceLastUpdate < aDay) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / anHour);
            if(timeToDisplay == /* Singular*/ 1) {
                //_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"更新于 %ld 小时 前",@"PullTableViewLan",@"Last uppdate in hours singular"), (long)timeToDisplay];
            } else {
                /* Plural */
                //_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"更新于 %ld 小时 前",@"PullTableViewLan",@"Last uppdate in hours plural"), (long)timeToDisplay];
                
            }
            
        } else {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / aDay);
            if(timeToDisplay == /* Singular*/ 1) {
                //_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"更新于 %ld 天 前",@"PullTableViewLan",@"Last uppdate in days singular"), (long)timeToDisplay];
            } else {
                /* Plural */
                //_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"更新于 %ld 天 前",@"PullTableViewLan",@"Last uppdate in days plural"), (long)timeToDisplay];
            }
            
        }
        
    } else {
        //_lastUpdatedLabel.text = nil;
    }
    
    // Center the status label if the lastupdate is not available
//    CGFloat midY = self.frame.size.height - PULL_AREA_HEIGTH/2;
//    if(!//_lastUpdatedLabel.text) {
//        //_statusLabel.frame = CGRectMake(0.0f, midY - 8, self.frame.size.width, 20.0f);
//    } else {
//        //_statusLabel.frame = CGRectMake(0.0f, midY - 18, self.frame.size.width, 20.0f);
//    }
    
}

- (void)setState:(EGOPullState)aState{
	
	switch (aState) {
		case EGOOPullPulling:
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideImageViews) object:nil];
            self.waitingPullImageView.transform=CGAffineTransformMakeRotation(0);
            self.waitingLoadingImageView.hidden=YES;
            self.waitingPullImageView.hidden=NO;
            self.waitingImageView.hidden=NO;
            
            
			//_statusLabel.text = NSLocalizedStringFromTable(@"松开更新...",@"PullTableViewLan", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			//_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
            
			break;
        }
		case EGOOPullNormal:
			if (_state == EGOOPullPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				//_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			//_statusLabel.text = NSLocalizedStringFromTable(@"继续下拉更新...",@"PullTableViewLan", @"Pull down to refresh status");
			//[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			//_arrowImage.hidden = NO;
			//_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
		case EGOOPullLoading:
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideImageViews) object:nil];
            self.waitingLoadingImageView.hidden=NO;
            self.waitingPullImageView.hidden=YES;
            self.waitingImageView.hidden=NO;
			
			//_statusLabel.text = NSLocalizedStringFromTable(@"正在更新...",@"PullTableViewLan", @"Loading Status");
			//[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			//_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor textColor:(UIColor *) textColor arrowImage:(UIImage *) arrowImage
{
    self.backgroundColor = backgroundColor? backgroundColor : DEFAULT_BACKGROUND_COLOR;
    
    if(textColor) {
        //_lastUpdatedLabel.textColor = textColor;
        //_statusLabel.textColor = textColor;
    } else {
        //_lastUpdatedLabel.textColor = DEFAULT_TEXT_COLOR;
        //_statusLabel.textColor = DEFAULT_TEXT_COLOR;
    }
    //_lastUpdatedLabel.shadowColor = [//_lastUpdatedLabel.textColor colorWithAlphaComponent:0.1f];
    //_statusLabel.shadowColor = [//_statusLabel.textColor colorWithAlphaComponent:0.1f];
    
    //_arrowImage.contents = (id)(arrowImage? arrowImage.CGImage : DEFAULT_ARROW_IMAGE.CGImage);
}


#pragma mark -
#pragma mark ScrollView Methods


- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
    
	if (_state == EGOOPullLoading) {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, PULL_AREA_HEIGTH);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.top = offset+_defaultEdgeInsets.top;
        scrollView.contentInset = currentInsets;
		
        CGFloat scaleChange=MAX((PULL_MAX_HEIGHT+scrollView.contentOffset.y+_defaultEdgeInsets.top),0)/(PULL_MAX_HEIGHT-PULL_AREA_HEIGTH);
        scaleChange=MIN(1, scaleChange);
        scaleChange=MAX(0, scaleChange);
        CGFloat scale=0.7+0.3*scaleChange;
        self.waitingImageView.transform=CGAffineTransformMakeScale(scale, scale);
        
        
        CGPoint center=self.waitingImageView.center;
        center.y=SELF_HEIGHT-MAX((-scrollView.contentOffset.y-_defaultEdgeInsets.top)/2,20*1.3);
        self.waitingImageView.center=center;
        
        
	} else if (scrollView.isDragging) {
		if (_state == EGOOPullPulling && scrollView.contentOffset.y > -PULL_TRIGGER_HEIGHT-_defaultEdgeInsets.top && scrollView.contentOffset.y < 0.0f && !isLoading) {
			[self setState:EGOOPullNormal];
		} else if (_state == EGOOPullNormal && scrollView.contentOffset.y < -PULL_TRIGGER_HEIGHT-_defaultEdgeInsets.top && !isLoading) {
			[self setState:EGOOPullPulling];
            
		}
        
        if (scrollView.contentOffset.y+_defaultEdgeInsets.top+PULL_TRIGGER_HEIGHT>0) {
            CGFloat scaleChange=(scrollView.contentOffset.y+_defaultEdgeInsets.top+PULL_TRIGGER_HEIGHT)/PULL_TRIGGER_HEIGHT;
            scaleChange=MIN(1, scaleChange);
            scaleChange=MAX(0, scaleChange);
            CGFloat scale=0.82+0.38*scaleChange;
            self.waitingImageView.transform=CGAffineTransformMakeScale(scale, scale);
            self.waitingPullImageView.transform=CGAffineTransformMakeRotation(0);
        }else{
            CGFloat scaleChange=MAX((PULL_MAX_HEIGHT+scrollView.contentOffset.y+_defaultEdgeInsets.top),0)/(PULL_MAX_HEIGHT-PULL_TRIGGER_HEIGHT);
            scaleChange=MIN(1, scaleChange);
            scaleChange=MAX(0, scaleChange);
            CGFloat scale=0.70+0.12*scaleChange;
            self.waitingImageView.transform=CGAffineTransformMakeScale(scale, scale);
            
            CGFloat rota=M_PI*(1-scaleChange);
            self.waitingPullImageView.transform=CGAffineTransformMakeRotation(rota);
        
        }
        
        
        CGPoint center=self.waitingImageView.center;
        center.y=SELF_HEIGHT-MAX((-scrollView.contentOffset.y-_defaultEdgeInsets.top)/2,20*1.2);
        self.waitingImageView.center=center;
        
		if (scrollView.contentInset.top != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.top = 0+_defaultEdgeInsets.top;
            scrollView.contentInset = currentInsets;
		}
		
	}
    
    if (scrollView.contentOffset.y==-_defaultEdgeInsets.top) {
    double delayInSeconds = 1.;
        [self performSelector:@selector(hideImageViews) withObject:nil afterDelay:delayInSeconds];
    }
}

-(void)hideImageViews{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideImageViews) object:nil];
    self.waitingLoadingImageView.hidden=YES;
    self.waitingPullImageView.hidden=YES;
    self.waitingImageView.hidden=YES;
}

- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView {
//    if (!_defaultEdgeInsetsHasInit&&IS_IOS7()) {
//        _defaultEdgeInsetsHasInit=YES;
//        [scrollView addObserver:self forKeyPath:@"contentInset" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
//    }
    
    
    
    isLoading = YES;
    
    [self setState:EGOOPullLoading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.top = PULL_AREA_HEIGTH+_defaultEdgeInsets.top;
    scrollView.contentInset = currentInsets;
    [UIView commitAnimations];
    if(scrollView.contentOffset.y ==-_defaultEdgeInsets.top){
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, -PULL_TRIGGER_HEIGHT-_defaultEdgeInsets.top) animated:YES];
    }
    
//    [UIView animateWithDuration:6./8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionRepeat animations:^{
//        self.waitingLoadingImageView.transform=CGAffineTransformMakeRotation(M_PI);
//    } completion:^(BOOL finished) {
//        self.waitingLoadingImageView.transform=CGAffineTransformMakeRotation(0);
//    }];
    
    [self playLoadingAnimate];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (_state==EGOOPullLoading) {
        [self playLoadingAnimate];
    }else{
        CABasicAnimation *animation;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = 6./6;
        animation.repeatCount =1;
        animation.toValue=[NSNumber numberWithFloat:2 * M_PI];
        animation.removedOnCompletion = YES;
        animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fillMode = kCAFillModeForwards;
        [self.waitingLoadingImageView.layer addAnimation:animation forKey:@"waitingLoading"];
    }
}

-(void)playLoadingAnimate{
    @autoreleasepool {
        CABasicAnimation *animation;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = 6./8.;
        animation.delegate=self;
        animation.repeatCount =1;
        animation.toValue=[NSNumber numberWithFloat:2 * M_PI];
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        [self.waitingLoadingImageView.layer addAnimation:animation forKey:@"waitingLoading"];
    }
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if (_defaultEdgeInsetsHasInit&&[keyPath isEqualToString:@"contentInset"]) {
//        NSValue *v=[change objectForKey:@"new"];
//        UIEdgeInsets editInsets=[v UIEdgeInsetsValue];
//        _defaultEdgeInsets=editInsets;
//        @try {
//            [object removeObserver:self forKeyPath:@"contentInset"];
//        }
//        @catch (NSException *exception) {  }
//        @finally {}
//    
//    }
//}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
	if (scrollView.contentOffset.y <= - PULL_TRIGGER_HEIGHT -_defaultEdgeInsets.top && !isLoading) {
        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
            [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
        }
        [self startAnimatingWithScrollView:scrollView];
	}
	
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	
    isLoading = NO;
    [self setState:EGOOPullNormal];
  
   __weak  EGORefreshTableHeaderView *__self=self;
    
    __weak UIScrollView *__scrollView=scrollView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            __scrollView.contentInset=_defaultEdgeInsets;
        }completion:^(BOOL finished){
            __self.waitingLoadingImageView.hidden=YES;
            __self.waitingPullImageView.hidden=YES;
            __self.waitingImageView.hidden=YES;
        }];
    });
}

- (void)egoRefreshScrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideImageViews) object:nil];
    self.waitingImageView.hidden=NO;
    self.waitingLoadingImageView.hidden=YES;
    self.waitingPullImageView.hidden=NO;
    
    [self refreshLastUpdatedDate];
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
//	//[_activityView release];
//	[//_statusLabel release];
//	[//_arrowImage release];
//	[//_lastUpdatedLabel release];
//    [super dealloc];
}


@end

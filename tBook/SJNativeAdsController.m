//
//  SJNativeAdsController.m
//  tBook
//
//  Created by 陈少杰 on 15/9/22.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJNativeAdsController.h"
#import "AdwoAdSDK.h"
#import <Social/Social.h>
#import "SJRecommendApp.h"


static SJNativeAdsController *_adsController;


static NSString* const adwoResponseErrorInfoList[] = {
    @"操作成功",
    @"广告初始化失败",
    @"当前广告已调用了加载接口",
    @"不该为空的参数为空",
    @"参数值非法",
    @"非法广告对象句柄",
    @"代理为空或adwoGetBaseViewController方法没实现",
    @"非法的广告对象句柄引用计数",
    @"意料之外的错误",
    @"广告请求太过频繁",
    @"广告加载失败",
    @"全屏广告已经展示过",
    @"全屏广告还没准备好来展示",
    @"全屏广告资源破损",
    @"开屏全屏广告正在请求",
    @"当前全屏已设置为自动展示",
    @"当前事件触发型广告已被禁用",
    @"没找到相应合法尺寸的事件触发型广告",
    
    @"服务器繁忙",
    @"当前没有广告",
    @"未知请求错误",
    @"PID不存在",
    @"PID未被激活",
    @"请求数据有问题",
    @"接收到的数据有问题",
    @"当前IP下广告已经投放完",
    @"当前广告都已经投放完",
    @"没有低优先级广告",
    @"开发者在Adwo官网注册的Bundle ID与当前应用的Bundle ID不一致",
    @"服务器响应出错",
    @"设备当前没连网络，或网络信号不好",
    @"请求URL出错"
};

@interface SJNativeAdsController ()<AWAdViewDelegate>
@property(nonatomic)NSMutableArray *ads;
@property(nonatomic)UIView *mAdView;
@property(nonatomic)UIView *adView;
@property(nonatomic)SJRecommendApp *app;
@end

@implementation SJNativeAdsController
@synthesize mAdView=_mAdView;
@synthesize adView=_adView;

+(SJNativeAdsController *)sharedAdsController{
    if (!_adsController) {
        _adsController=[[SJNativeAdsController alloc]init];
        
    }
   return  _adsController;
}

+(void)load{
}

-(void)loadAds{
    _mAdView = AdwoAdCreateImplantAd(ADWO_APPKEY, YES, self, nil, ADWOSDK_IMAD_SHOW_FORM_COMMON);
    
    // 加载原生广告
    if(!AdwoAdLoadImplantAd(_mAdView, NULL))
    {
        NSLog(@"原生广告加载失败，由于：%@", adwoResponseErrorInfoList[AdwoAdGetLatestErrorCode()]);
        
        // 移除原生广告对象
        AdwoAdRemoveAndDestroyImplantAd(_mAdView);
        _mAdView = nil;
    }
    else
        NSLog(@"加载成功");
}

-(NSMutableArray *)ads{
    if (!_ads) {
        _ads=[[NSMutableArray alloc]init];
    }
    return _ads;
}


#pragma mark - Adwo Ad delegates

- (UIViewController*)adwoGetBaseViewController
{
    UINavigationController *nav=(UINavigationController*)[[UIApplication sharedApplication]keyWindow].rootViewController;
    UIViewController *vc=[[nav viewControllers]lastObject];
    return vc;
}

- (void)adwoAdViewDidFailToLoadAd:(UIView*)adView
{
    NSLog(@"原生广告请求失败，由于：%@", adwoResponseErrorInfoList[AdwoAdGetLatestErrorCode()]);
    if (self.fail) {
        NSError *error=[NSError errorWithDomain:adwoResponseErrorInfoList[AdwoAdGetLatestErrorCode()] code:404 userInfo:nil];
        self.fail(error);
    }
}

- (void)adwoAdViewDidLoadAd:(UIView*)adView
{
    NSString *str = AdwoAdGetAdInfo(_mAdView);
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSLog(@"adinfo is :%@",dic);
    SJRecommendApp *app=[[SJRecommendApp alloc]initWithAdwoDictionary:dic];

    if (self.success) {
        UIView *showingView = self.success(adView,app);
        AdwoAdShowImplantAd(adView, showingView);
        AdwoAdImplantAdActivate(_mAdView);
    }
}

-(void)loadNativeAdWithSuccessBlock:(SJNavAdsSuccessBlock)successBlock failBlock:(SJNavAdsFailBlock)failBlock{
    self.success=successBlock;
    self.fail=failBlock;
    [self loadAds];
}

-(void)removeAds{
    if(_mAdView != nil)
    {
        AdwoAdRemoveAndDestroyImplantAd(_mAdView);
        _mAdView = nil;
    }
}

- (void)adwoAdRequestShouldPause:(UIView*)adView
{
//    mMayBeClosed = NO;
}

- (void)adwoAdRequestMayResume:(UIView*)adView
{
//    mMayBeClosed = YES;
}@end

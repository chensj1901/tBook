//
//  SJNativeAdsController.h
//  tBook
//
//  Created by 陈少杰 on 15/9/22.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJRecommendApp.h"

#define SJNAVITE_ADS_LOADED_EVENT @"SJNAVITE_ADS_LOADED_EVENT"

typedef UIView *(^SJNavAdsSuccessBlock)(UIView *adView,SJRecommendApp*adApp) ;
typedef void(^SJNavAdsFailBlock)(NSError *error) ;

@interface SJNativeAdsController : NSObject
@property(copy)SJNavAdsSuccessBlock success;
@property(copy)SJNavAdsFailBlock fail;
+(SJNativeAdsController *)sharedAdsController;
-(void)loadNativeAdWithSuccessBlock:(SJNavAdsSuccessBlock)successBlock failBlock:(SJNavAdsFailBlock)failBlock;
@end

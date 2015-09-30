//
//  SJAdsController.h
//  bounceBall
//
//  Created by 陈少杰 on 15/6/29.
//
//

#import <UIKit/UIKit.h>

@class AdMoGoView;

@interface SJAdsController : NSObject
@property(nonatomic)AdMoGoView *adMoGoView;
@property(nonatomic)AdMoGoView *adMoGoFullView;

+(SJAdsController*)shareController;
+(void)showAdsBanner;
+(void)removeAdsBanner;
+(void)showAdsFullScreen;
+(void)removeAdsFullScreen;
+(void)showPushAds;
@end

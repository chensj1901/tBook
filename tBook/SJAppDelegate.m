//
//  SJAppDelegate.m
//  tBook
//
//  Created by 陈少杰 on 14/11/24.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJAppDelegate.h"
#import "SJTabSwitchViewController.h"
#import <iflyMSC/IFlySpeechUtility.h>
#import "SJBookRecode.h"
#import "SJBookChapterReadRecode.h"
#import "SJBookChapterRecode.h"
#import "SJSettingRecode.h"
#import "SJAdsController.h"
#import "SJBookService.h"
#import "SJBookURLRequest.h"

@interface SJAppDelegate ()
@property(nonatomic)SJBookService *bookService;
@end

@implementation SJAppDelegate

-(SJBookService *)bookService{
    if (!_bookService) {
        _bookService=[[SJBookService alloc]init];
    }
    return _bookService;
}

-(void)initDB{
    [SJSettingRecode initDB];
    [SJBookRecode initDB];
    [SJBookChapterReadRecode initDB];
    [SJBookChapterRecode initDB];
    
    if ([[SJSettingRecode getSet:@"isInit"]boolValue]==NO) {
        [SJSettingRecode set:@"textColor" value:@"313746"];
        [SJSettingRecode set:@"textFont" value:@"20"];
        [SJSettingRecode set:@"backgroundStr" value:@"image:reading_background.jpg"];
        [SJSettingRecode set:@"isInit" value:@"1"];
    }
}

-(void)reloadLocationBooks{
    [self.bookService loadLocalBooksWithSuccess:^{
        SJBook *book=[self.bookService.locaBooks safeObjectAtIndex:0];
        if(book&&book.isLoadingLastChapterName){
            [self reloadLastChapters];
        }
    } fail:^(NSError *error) {
        
    }];
    
}


-(void)reloadLastChapters{
    for (SJBook *book in self.bookService.locaBooks) {
        [self.bookService loadBookChapterWithBook:book cacheMethod:SJCacheMethodFail success:^{
            SJBookChapter *lastChapter=[self.bookService.bookChapters lastObject];
            book.lastChapterName=lastChapter.chapterName;
            book.isLoadingLastChapterName=NO;
            
            NSString *recodeTag=[NSString stringWithFormat:@"lastChapterIdForBookId_%ld",(long)book.nid];
            NSInteger lastChapterId=[[SJSettingRecode getSet:recodeTag]integerValue];
            if (lastChapter._id>lastChapterId) {
                NSString *str=[NSString stringWithFormat:@"%@ 更新章节 %@",book.name,lastChapter.chapterName];
                [self sendLocationPush:str];
                [SJSettingRecode set:recodeTag value:[NSString stringWithFormat:@"%ld",(long)lastChapter._id]];
                [SJBookURLRequest apiUpdateBookChapterWithBook:book BookChapter:lastChapter success:^(AFHTTPRequestOperation *op, id dic) {
                    
                } failure:^(AFHTTPRequestOperation *op, NSError *error) {
                    
                }];
            }
        } fail:^(NSError *error) {
            
        }];
        NSLog(@"%@",book);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

//    for (int j=0; j<100; j++) {
//        NSInteger maxCoin=0;
//        NSInteger sum=10000;
//        NSInteger coin=1;
//        for (int i=0; i<500000; i++) {
//            NSInteger randInt=arc4random()%2;
//            if (randInt==0) {
//                sum+=coin;
//                coin=1;
//            }else{
//                sum-=coin;
//                coin*=2;
//            }
//            maxCoin=MAX(maxCoin, coin);
//            if (sum-coin<=0) {
//                break;
//            }
//        }
//        NSLog(@"%ld %ld",(long)sum,(long)maxCoin);
//    }
    
    // Override point for customization after application launch.
    
    [self initDB];
    [SJAdsController showPushAds];
    [self reloadLocationBooks];
    
    if (IS_IOS7()) {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        }
        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    }
    
    SJTabSwitchViewController *indexVC=[[SJTabSwitchViewController alloc]init];
    UINavigationController *indexNav=[[UINavigationController alloc]initWithRootViewController:indexVC];
    
    UIWindow *window=[[UIWindow alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    window.rootViewController=indexNav;
    [window makeKeyAndVisible];
    self.window=window;
    
    [IFlySpeechUtility createUtility:XUNFEI_APPID];
    
    return YES;
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSTimeInterval time=[[SJSettingRecode getSet:@"pushTime"]doubleValue];
    NSTimeInterval now=[[NSDate date]timeIntervalSince1970];NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSHourCalendarUnit fromDate:date];
    

    
    [self reloadLocationBooks];
    
    
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)sendLocationPush:(NSString *)string{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:2];
    if (notification != nil) {
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = 0;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        static NSString* const KDateFormat=@"yyyy-MM-dd HH:mm";
        NSDateFormatter* dateFormat=[[NSDateFormatter alloc] init];
        dateFormat.dateFormat=KDateFormat;
        
        // 推送内容
        notification.alertBody = [NSString stringWithFormat:@"%@",string];
        //显示在icon上的红色圈中的数子
        //        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"startEdit"forKey:@"startEdit"];
        notification.userInfo = info;
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

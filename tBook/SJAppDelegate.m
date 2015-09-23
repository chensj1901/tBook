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

@implementation SJAppDelegate

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
    
    
    SJTabSwitchViewController *indexVC=[[SJTabSwitchViewController alloc]init];
    UINavigationController *indexNav=[[UINavigationController alloc]initWithRootViewController:indexVC];
    
    UIWindow *window=[[UIWindow alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    window.rootViewController=indexNav;
    [window makeKeyAndVisible];
    self.window=window;
    
    [IFlySpeechUtility createUtility:XUNFEI_APPID];
    
    return YES;
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

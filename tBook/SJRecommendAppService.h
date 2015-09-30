//
//  SJRecommendAppService.h
//  Yunpan
//
//  Created by 陈少杰 on 15/8/5.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJService.h"
#import "SJRecommendApp.h"


@interface SJRecommendAppService : SJService
@property(nonatomic)NSMutableArray* apps;
@property(nonatomic)SJRecommendApp *recommendApp;
-(void)loadAppListWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;

-(void)getAppRecommendWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;
@end

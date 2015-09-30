//
//  SJRecommendAppService.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/5.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRecommendAppService.h"
#import "SJRecommendAppURLRequest.h"

@implementation SJRecommendAppService
-(void)loadAppListWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJRecommendAppURLRequest apiQueryAppLinkWithSuccess:^(AFHTTPRequestOperation *op, id dictionary) {
        for (NSDictionary *dic in [dictionary safeObjectForKey:@"apps"]) {
            SJRecommendApp *app=[[SJRecommendApp alloc]initWithDictionary:dic];
            [self.apps addObject:app];
        }
        
        if (success) {
            success();
        }
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)getAppRecommendWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJRecommendAppURLRequest apiGetAppRecommendWithSuccess:^(AFHTTPRequestOperation *op, id dic) {
    SJRecommendApp *app=[[SJRecommendApp alloc]initWithDictionary:dic[@"app"]];
    self.recommendApp=app;
    
    if (success) {
        success();
    }
} failure:^(AFHTTPRequestOperation *op, NSError *error) {
    if (fail) {
        fail(error);
    }
}];
}
-(NSMutableArray *)apps{
    if (!_apps) {
        _apps=[[NSMutableArray alloc]init];
    }
    return _apps;
}
@end

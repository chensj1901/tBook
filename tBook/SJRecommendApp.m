//
//  SJRecommendApp.m
//  zhitu
//
//  Created by 陈少杰 on 13-12-1.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "SJRecommendApp.h"

@implementation SJRecommendApp
-(id)initWithDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        self._id=[[dictionary objectForKey:@"id"]integerValue];
        self.appName=[dictionary objectForKey:@"appName"];
        self.appIcon=[dictionary objectForKey:@"appIcon"];
        self.appDesc=[dictionary objectForKey:@"appDesc"];
        self.url=[dictionary objectForKey:@"url"];
    }
    return self;
}

-(id)initWithAdwoDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        self.appName=[dictionary objectForKey:@"title"];
        self.appIcon=[dictionary objectForKey:@"icon"];
        self.appDesc=[dictionary objectForKey:@"summary"];
    }
    return self;
}
@end

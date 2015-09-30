//
//  SJHTTPRequestOperationManager.m
//  tBook
//
//  Created by 陈少杰 on 14/12/4.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJHTTPRequestOperationManager.h"
#import <EGOCache.h>

@implementation SJHTTPRequestOperationManager
-(AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"text/javascript", nil];
    
    NSString *hostRequest=[NSString stringWithFormat:@"%@?%@",URLString,[parameters stringValue]];
    
    NSLog(@"%@",hostRequest);
    
    NSString *cacheURL=[hostRequest md5Encode];
    
    if ((cacheMethod==SJCacheMethodOnlyCache||cacheMethod==SJCacheMethodCacheFirst)&&[[EGOCache globalCache]hasCacheForKey:cacheURL]) {
        NSData *data=[[EGOCache globalCache]dataForKey:cacheURL];
        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        if (success) {
            success(nil,[str objectValue]);
        }
        return nil;
    }else if(cacheMethod==SJCacheMethodOnlyCache){
        if (failure) {
            failure(nil,nil);
        }
        return nil;
    }else{
        AFHTTPRequestOperation *operation = [super POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *op, id result){
            [[EGOCache globalCache]setData:[[result stringValue]dataUsingEncoding:NSUTF8StringEncoding ]forKey:cacheURL];
            if (success) {
                success(op,result);
            }
        } failure:^(AFHTTPRequestOperation *op, NSError *error){
            if (cacheMethod==SJCacheMethodFail) {
                if ([[EGOCache globalCache]hasCacheForKey:cacheURL]) {
                    NSData *data=[[EGOCache globalCache]dataForKey:cacheURL];
                    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    if (success) {
                        success(nil,[str objectValue]);
                    }
                }else{
                    if (failure) {
                        failure(op,error);
                    }
                }
            }else{
                if (failure) {
                    failure(op,error);
                }
            }
        }];
        return operation;
    }
}

-(AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(id)parameters cacheMethod:(SJCacheMethod)cacheMethod  success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    
    self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"text/javascript", nil];
    
    NSString *hostRequest=[NSString stringWithFormat:@"%@?%@",URLString,[parameters stringValue]];
    
    NSLog(@"%@",hostRequest);
    
    NSString *cacheURL=[hostRequest md5Encode];
    
    if ((cacheMethod==SJCacheMethodOnlyCache||cacheMethod==SJCacheMethodCacheFirst)&&[[EGOCache globalCache]hasCacheForKey:cacheURL]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data=[[EGOCache globalCache]dataForKey:cacheURL];
            NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(),^{
                if (success) {
                    success(nil,[str objectValue]);
                }
            });
        });
        return nil;
    }else if(cacheMethod==SJCacheMethodOnlyCache){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(),^{
                if (failure) {
                    failure(nil,nil);
                }
            });
        });
        return nil;
    }else{
        AFHTTPRequestOperation *operation = [super GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *op, id result){
            [[EGOCache globalCache]setData:[[result stringValue]dataUsingEncoding:NSUTF8StringEncoding ]forKey:cacheURL];
            if (success) {
                success(op,result);
            }
        } failure:^(AFHTTPRequestOperation *op, NSError *error){
            if (cacheMethod==SJCacheMethodFail) {
                if ([[EGOCache globalCache]hasCacheForKey:cacheURL]) {
                    NSData *data=[[EGOCache globalCache]dataForKey:cacheURL];
                    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    if (success) {
                        success(nil,[str objectValue]);
                    }
                }else{
                    if (failure) {
                        failure(op,error);
                    }
                }
            }else{
                if (failure) {
                    failure(op,error);
                }
            }
        }];
        return operation;
    }

}


@end

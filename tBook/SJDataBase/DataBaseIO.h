//
//  DataBaseIO.h
//  HTShuo
//
//  Created by 陈少杰 on 12-9-25.
//  Copyright (c) 2012年 华南理工大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#define DATABASENAME @"BOOKINFO.db"

@interface DataBaseIO : NSObject
+(FMDatabase *)getDB;
+(void)executeUpdate:(NSString*)sql;
+(NSMutableArray*)executeQuery:(NSString*)sql;


+(void)backUp;

@end

//
//  DataBaseIO.m
//  HTShuo
//
//  Created by 陈少杰 on 12-9-25.
//  Copyright (c) 2012年 华南理工大学. All rights reserved.
//

#import "DataBaseIO.h"

@implementation DataBaseIO
+(FMDatabase *)getDB{
    return [FMDatabase databaseWithPath:[NSFileManager getFilePath:DATABASENAME]];
}
+(void)executeUpdate:(NSString*)sql{
    FMDatabase *db=[self getDB];
    [db open];
    @try {
        [db executeUpdate:sql];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [db close];
    }
}

+(NSMutableArray*)executeQuery:(NSString*)sql{
    FMDatabase *db;
    NSMutableArray*result;
    result=[[NSMutableArray alloc]init];
    db=[self getDB];
    [db open];
    @try {
        FMResultSet *rs =[db executeQuery:sql];
        while ([rs next]) {
            [result addObject:[rs resultDictionary]];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [db close];
    }
    return result;
}


+(void)backUp{
    @autoreleasepool {
        if ([NSFileManager isFileExists:DATABASENAME]) {
            [NSFileManager copyFileFromFilePath:[NSFileManager getFilePath:DATABASENAME] toFilePath:[NSFileManager getFilePath:@"WorldInfo_2.db.bk"]];
        }else if([NSFileManager isFileExists:@"WorldInfo_2.db.bk"]&&![NSFileManager isFileExists:DATABASENAME]){
            [NSFileManager copyFileFromFilePath:[NSFileManager getFilePath:@"WorldInfo_2.db.bk"] toFilePath:[NSFileManager getFilePath:DATABASENAME]];
        }
    }
}

@end

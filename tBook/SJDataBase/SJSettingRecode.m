//
//  SJPushRecode.m
//  zhitu
//
//  Created by 陈少杰 on 13-9-12.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "SJSettingRecode.h"

@implementation SJSettingRecode
+(void)initDB{
    if (![self hasInstall]) {
        NSString *sql=@"CREATE TABLE \"HTSG_PUSH_SETTING\" (\"setting_name\" text NOT NULL, \"value\" Varchar(255,0) NOT NULL,PRIMARY KEY(\"setting_name\"))";
        [self executeUpdate:sql];
    }
}

+(BOOL)hasInstall{
    NSString *sql=@"select count(*) from 'HTSG_PUSH_SETTING'";
    return [[self executeQuery:sql]count]>0;
}

+(void)set:(NSString*)settingName value:(NSString*)value{
    NSString *sql;
    if ([self getSet:settingName]) {
        sql=[NSString stringWithFormat:@"update HTSG_PUSH_SETTING set value='%@' where setting_name='%@'",value,settingName];
    }
    else{
        sql=[NSString stringWithFormat:@"insert into  HTSG_PUSH_SETTING ( value, setting_name) values ( '%@', '%@')",value,settingName];
    }
    [self executeUpdate:sql];
}

+(NSString*)getSet:(NSString*)settingName{
    NSString *sql=[NSString stringWithFormat:@"select * from HTSG_PUSH_SETTING where setting_name= '%@' ",settingName];
    NSArray *result=[self executeQuery:sql];
    if ([result count]==1) {
        return [[result objectAtIndex:0]objectForKey:@"value"];
    }
    else{
        return nil;
    }
}

@end

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

+(NSString*)getSet:(NSString*)settingName,...{
    va_list params; //定义一个指向个数可变的参数列表指针;
    va_start(params,settingName);//va_start 得到第一个可变参数地址,
    NSString *s=[[NSString alloc]initWithFormat:settingName arguments:params];
    va_end(params);
 
    NSString *sql=[NSString stringWithFormat:@"select * from HTSG_PUSH_SETTING where setting_name= '%@' ",s];
    NSArray *result=[self executeQuery:sql];
    if ([result count]==1) {
        return [[result objectAtIndex:0]objectForKey:@"value"];
    }
    else{
        return nil;
    }
}

-(NSArray *)actionUsePic:(id)actionNum, ... {
NSMutableArray *argsArray = [[NSMutableArray alloc] init];
va_list params; //定义一个指向个数可变的参数列表指针;
va_start(params,actionNum);//va_start 得到第一个可变参数地址,
id arg;
if (actionNum) {
    //将第一个参数添加到array
    id prev = actionNum;
    [argsArray addObject:prev];
    //va_arg 指向下一个参数地址
    //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
    while( (arg = va_arg(params,id)) )
        {
            if ( arg ){
                [argsArray addObject:arg];
                }
            }
    //置空
    va_end(params);
    //这里循环 将看到所有参数
    for (NSNumber *num in argsArray) {
        NSLog(@"%d", [num intValue]);
        }
    }
return argsArray;
}
@end

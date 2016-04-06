//
//  CNFileOperate.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNFileOperate.h"
#import "CNFlowInfo.h"

@implementation CNFileOperate

- (void)writeToFile:(NSString *)fileName modelName:(CNFlowInfo *)model{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"flowinfo.plist"];
    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    NSString *time = model.time;
    NSString *address = model.address;
    NSString *date = model.date;
    NSString *daotui = model.daotui;
    
    //创建字典
    //写入数据到plist文件
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:time,@"time",address,@"address",date,@"date",daotui,@"daotui",nil];

    [data addObject:dic1];
    
    //[data setArray:nil];
    
    [data writeToFile:plistPath atomically:YES];
    
//    data = [NSMutableArray arrayWithContentsOfFile:plistPath];
//    NSLog(@"%@",data);
    
}
@end

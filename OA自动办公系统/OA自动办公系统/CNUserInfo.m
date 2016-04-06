//
//  CNUserInfo.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNUserInfo.h"

@implementation CNUserInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)userInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)userInfosList{
    //健在plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userinfo" ofType:@"plist"];
    NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *arrayModel = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        CNUserInfo *model = [CNUserInfo userInfoWithDict:dict];
        [arrayModel addObject:model];
    }
    
    return arrayModel;
}
@end

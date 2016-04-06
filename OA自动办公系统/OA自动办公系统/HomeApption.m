//
//  HomeImage.m
//  OA系统
//
//  Created by AIogle on 15/11/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "HomeApption.h"

@implementation HomeApption

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)homeImageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)homeImagesList{
    //健在plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeApption" ofType:@"plist"];
    NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *arrayModel = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        HomeApption *model = [HomeApption homeImageWithDict:dict];
        [arrayModel addObject:model];
    }
    return arrayModel;
}
@end

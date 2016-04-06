//
//  CNFlowInfo.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNFlowInfo.h"

@implementation CNFlowInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)flowWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)flowsList{
    //健在plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flowinfo" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:filePath];

    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"flowinfo.plist"];
    NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *arrayModel = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        CNFlowInfo *model = [CNFlowInfo flowWithDict:dict];
        [arrayModel addObject:model];
    }
    
    for (NSDictionary *dict in fileArray) {
        CNFlowInfo *model = [CNFlowInfo flowWithDict:dict];
        [arrayModel addObject:model];
    }
    
    return arrayModel;
}
@end

//
//  CNLinkFriend.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/13.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNLinkFriend.h"

@implementation CNLinkFriend

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)linkWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)linksList{
    //健在plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FriendLink" ofType:@"plist"];
    NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *arrayModel = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        CNLinkFriend *model = [CNLinkFriend linkWithDict:dict];
        [arrayModel addObject:model];
    }
    
    return arrayModel;
}
@end

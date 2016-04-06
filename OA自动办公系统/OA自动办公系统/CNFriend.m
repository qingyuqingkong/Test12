//
//  CNFriend.m
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNFriend.h"

@implementation CNFriend

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end

//
//  CNMessage.m
//  QQ聊天
//
//  Created by AIogle on 15/11/11.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNMessage.h"

@implementation CNMessage

- (instancetype)initWihtDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWihtDict:dict];
}
@end

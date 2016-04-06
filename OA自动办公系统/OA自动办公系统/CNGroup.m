//
//  CNGroup.m
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNGroup.h"
#import "CNFriend.h"

@implementation CNGroup

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        // 把self.friends由字典数组转换为模型数据
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict_friend in self.friends) {
            CNFriend *model = [CNFriend friendWithDict:dict_friend];
            [arrayModels addObject:model];
        }
        self.friends = arrayModels;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end

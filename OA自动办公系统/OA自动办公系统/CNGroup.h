//
//  CNGroup.h
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNGroup : NSObject


//组名
@property (nonatomic, copy) NSString *name;

//在线人数
@property (nonatomic, assign) int online;

//当前组中的所有好友数据
@property (nonatomic, strong) NSArray *friends;

//表示这个组是否可见
@property (nonatomic, assign, getter=isVisible) BOOL visible;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end

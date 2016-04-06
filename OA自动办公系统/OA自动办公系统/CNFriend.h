//
//  CNFriend.h
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNFriend : NSObject

// 头像
@property (nonatomic, copy) NSString *icon;

// 昵称
@property (nonatomic, copy) NSString *name;

//个性签名
@property (nonatomic, copy) NSString *intro;

//是否是VIP
@property (nonatomic, assign) BOOL isOnline;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;
@end

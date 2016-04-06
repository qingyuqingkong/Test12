//
//  CNLinkFriend.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/13.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNLinkFriend : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray *message;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)linkWithDict:(NSDictionary *)dict;

+ (NSArray *)linksList;
@end

//
//  CNUserInfo.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNUserInfo : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *post;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *iphone;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)userInfoWithDict:(NSDictionary *)dict;

+ (NSArray *)userInfosList;
@end

//
//  CNFlowInfo.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNFlowInfo : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *daotui;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)flowWithDict:(NSDictionary *)dict;

+ (NSArray *)flowsList;

@end

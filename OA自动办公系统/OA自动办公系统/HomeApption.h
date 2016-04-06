//
//  HomeImage.h
//  OA系统
//
//  Created by AIogle on 15/11/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeApption : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSInteger actionTag;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)homeImageWithDict:(NSDictionary *)dict;

+ (NSArray *)homeImagesList;
@end

//
//  CNMessage.h
//  QQ聊天
//
//  Created by AIogle on 15/11/11.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    CNMessageTypeMe = 0,
    CNMessageTypeOther = 1
}CNMessageType;

@interface CNMessage : NSObject

//正文消息
@property (nonatomic, copy) NSString *text;

//消息发生时间
@property (nonatomic, copy) NSString *time;

//消息类型
@property (nonatomic,assign) CNMessageType type;

//用来记录是否徐uyaoxianshi“时间Label”
@property (nonatomic, assign) BOOL hideTime;
- (instancetype)initWihtDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end

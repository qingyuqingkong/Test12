//
//  CNMessageFrame.h
//  QQ聊天
//
//  Created by AIogle on 15/11/11.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class CNMessage;
@interface CNMessageFrame : NSObject
#define textFont [UIFont systemFontOfSize:13]
//引用数据模型
@property (nonatomic, strong) CNMessage *message;

//时间Label的frame
@property (nonatomic, assign, readonly) CGRect timeFrame;
//头像的frame
@property (nonatomic, assign, readonly) CGRect iconFrame;
//正文的frame
@property (nonatomic, assign, readonly) CGRect textFrame;
//行高
@property (nonatomic, assign, readonly) CGFloat rowHeight;
@end

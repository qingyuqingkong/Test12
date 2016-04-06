//
//  NSString+CNNSStringExt.h
//  QQ聊天
//
//  Created by AIogle on 15/11/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CNNSStringExt)

//对象方法
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

//类方法
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;
@end

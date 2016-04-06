//
//  NSString+CNNSStringExt.m
//  QQ聊天
//
//  Created by AIogle on 15/11/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "NSString+CNNSStringExt.h"

@implementation NSString (CNNSStringExt)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}
@end

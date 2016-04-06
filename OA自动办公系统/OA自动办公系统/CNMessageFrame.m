//
//  CNMessageFrame.m
//  QQ聊天
//
//  Created by AIogle on 15/11/11.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNMessageFrame.h"
#import <UIKit/UIKit.h>
#import "CNMessage.h"
#import "NSString+CNNSStringExt.h"
@implementation CNMessageFrame

- (void)setMessage:(CNMessage *)message{
    _message = message;
    
    //计算每个控件的frame和行高
    
    //获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //设置一个统一的间距
    CGFloat margin = 15;
    CGFloat marginH = 5;
    //计算时间Label的frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    if (!message.hideTime) {
        //如果需要显示时间Label，那么在计算时间Label的frame
        _timeFrame= CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    //计算头像的frame
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + marginH;
    CGFloat iconX = message.type == CNMessageTypeOther ? margin : screenW - margin - iconW;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //计算消息正文的frame
    //1.先计算正文的大小
    CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(245, MAXFLOAT) font:textFont];
    CGFloat textW = textSize.width + 40;
    CGFloat textH = textSize.height +30;
    //2.在计算x，y
    CGFloat textY = iconY;
    CGFloat textX = message.type == CNMessageTypeOther ? CGRectGetMaxX(_iconFrame) : (screenW - margin - iconW - textW);
    
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    //计算行高
    //获取头像的最大的Y值和正文的最大的Y值，然后用最大的Y值加margin
    CGFloat maxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = maxY + margin;
}
@end

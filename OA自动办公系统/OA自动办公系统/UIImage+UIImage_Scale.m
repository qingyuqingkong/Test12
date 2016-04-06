//
//  UIImage+UIImage_Scale.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/15.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "UIImage+UIImage_Scale.h"

@implementation UIImage (Scale)

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

@end

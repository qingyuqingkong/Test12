//
//  CNFileOperate.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CNFlowInfo;
@interface CNFileOperate : NSObject

- (void)writeToFile:(NSString *)fileName modelName:(CNFlowInfo *)model;
@end

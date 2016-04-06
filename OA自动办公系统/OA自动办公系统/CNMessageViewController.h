//
//  CNMessageViewController.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/13.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNBaseViewController.h"

@class CNFriend;
@interface CNMessageViewController : CNBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    friendModel:(CNFriend *)model;
@end

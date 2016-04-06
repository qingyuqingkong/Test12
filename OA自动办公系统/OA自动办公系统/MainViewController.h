//
//  ViewController.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNBaseViewController.h"
#import "CNTabBarController.h"

@interface MainViewController : CNBaseViewController

@property (nonatomic, assign) CNTabBarController *delegate;
@end


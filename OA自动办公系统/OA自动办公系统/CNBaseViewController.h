//
//  CNBaseViewController.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNUserInfo;
@interface CNBaseViewController : UIViewController

@property (nonatomic, assign) BOOL showBackButton;

//隐藏导航栏
@property (nonatomic, assign) BOOL showNavigationBar;

//是否显示toolBar
@property (nonatomic, assign) BOOL showTabBar;

//是否显示OA标签
@property (nonatomic, assign) BOOL showOATitle;

//判断是不是多级页面
@property (nonatomic, assign) BOOL isMoreView;

//用来保存当前的用户的信息
@property (nonatomic, strong) CNUserInfo *userInfo;
@end

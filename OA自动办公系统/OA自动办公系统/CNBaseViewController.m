//
//  CNBaseViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNBaseViewController.h"
#import "CNTabBarController.h"

@interface CNBaseViewController ()

//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backButtonItem;
@property (nonatomic, strong) UIBarButtonItem *oaTitle;
@end

@implementation CNBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置界面的背景色
    self.view.backgroundColor = [UIColor whiteColor];
    self.showOATitle = YES;
}

- (void)createOATitle{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    //button.adjustsImageWhenDisabled = NO;
    button.frame = CGRectMake(0, 0, 64, 44);
    [button setTitle:@"OA" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"status"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    _oaTitle = item;
}
#pragma mark ----重写showOATitle的setting方法
- (void)setShowOATitle:(BOOL)showOATitle{
    _showOATitle = showOATitle;
    if (_oaTitle == nil) {
        [self createOATitle];
    }
    if (_showOATitle) {
        self.navigationItem.leftBarButtonItem = _oaTitle;
    }
}
#pragma mark ----重写showbackbutton
- (void)setShowBackButton:(BOOL)showBakButton{
    _showBackButton = showBakButton;
    
    if (_backButtonItem == nil) {
        //需要创建的back按钮
        [self createBackButton];
    }
    
    if (_showBackButton == YES) {
        //需要back按钮
        self.navigationItem.leftBarButtonItem = _backButtonItem;
    }
}
//创建返回按钮
- (void)createBackButton{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 21, 34);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //设置点击事件
    [button addTarget:self action:@selector(backButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark --重新showTabBar
- (void)setShowTabBar:(BOOL)showTabBar{
    _showTabBar = showTabBar;
    
    if (showTabBar) {
        self.navigationController.tabBarController.tabBar.hidden = NO;
        if (_isMoreView) {
            self.navigationController.tabBarController.tabBar.hidden = YES;
            _isMoreView = NO;
        }
        
    } else {
        self.navigationController.tabBarController.tabBar.hidden = YES;
    }
    
}
- (void)backButtonDidClicked{
    [self.navigationController popViewControllerAnimated:YES];
    self.showTabBar = YES;
}


@end

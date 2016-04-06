//
//  CNTabBarController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNTabBarController.h"
#import "CNBaseNavigationController.h"
#import "CNLinkViewController.h"
#import "CNDynaViewController.h"
#import "CNMoreViewController.h"
#import "MainViewController.h"


@interface CNTabBarController () {
    UIImageView *tabBarView;//自定义的覆盖原先的tarbar的空间
    UIButton *previousBtn;//记录前一次选中的按钮
}

@end

@implementation CNTabBarController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    tabBarView = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    tabBarView.userInteractionEnabled = YES;
    tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toolBarBg"]];
    
    [self.tabBar addSubview:tabBarView];
    //创建main视图
    MainViewController *main = [[MainViewController alloc] init];
    main.delegate = self;
    CNBaseNavigationController *navMain = [[CNBaseNavigationController alloc] initWithRootViewController:main];
    
    //创建Link视图
    CNLinkViewController *link = [[CNLinkViewController alloc] init];
    CNBaseNavigationController *navLink = [[CNBaseNavigationController alloc] initWithRootViewController:link];
    
    //创建Dyna视图
    CNDynaViewController *dyna = [[CNDynaViewController alloc] init];
    CNBaseNavigationController *navDyna = [[CNBaseNavigationController alloc] initWithRootViewController:dyna];
    
    //创建more视图
    CNMoreViewController *more = [[CNMoreViewController alloc] initWithNibName:@"CNMoreViewController" bundle:nil];
    CNBaseNavigationController *navMore = [[CNBaseNavigationController alloc] initWithRootViewController:more];
    
    self.viewControllers = [NSArray arrayWithObjects:navMain,navLink,navDyna,navMore, nil];

    [self creatButtonName:@"HOME" andTitle:nil andIndex:0];
    [self creatButtonName:@"LINK" andTitle:nil andIndex:1];
    [self creatButtonName:@"DYNA" andTitle:nil andIndex:2];
    [self creatButtonName:@"MORE" andTitle:nil andIndex:3];
    
    UIButton *button = tabBarView.subviews[0];
    [self changeViewController:button];
}

- (void)creatButtonName:(NSString *)name andTitle:(NSString *)title andIndex:(int)index{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = tabBarView.frame.size.width / 4;
    CGFloat buttonH = tabBarView.frame.size.height;

    customButton.frame = CGRectMake(buttonW * index, 0, buttonW, buttonH);
    [customButton setTitle:name forState:UIControlStateNormal];
    
    //这里应该设置选中状态的图片
    //[customButton setImage:[UIImage imageNamed:@"toolBarHighlighted"] forState:UIControlStateSelected];
    //[customButton setTitle:title forState:UIControlStateNormal];
    [customButton setBackgroundImage:[UIImage imageNamed:@"toolBarHighlighted"] forState:UIControlStateSelected];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    [customButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [tabBarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        previousBtn = customButton;
        previousBtn.selected = YES;
    }
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(UIButton *)sender
{
    if(self.selectedIndex != sender.tag){
        self.selectedIndex = sender.tag; //切换不同控制器的界面
    
        previousBtn.selected = ! previousBtn.selected;
        previousBtn = sender;
        previousBtn.selected = YES;
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != tabBarView) {
            //tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

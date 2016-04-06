//
//  Demo1ViewController.m
//  DLSlideViewDemo
//
//  Created by Dongle Su on 14-12-11.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import "MessageViewController.h"
#import "DLFixedTabbarView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showOATitle = NO;
    self.showBackButton = YES;
    self.showTabBar = NO;
    
    //创建听不的标签和右边的添加按钮
    [self createTitleAndAddButton];
    
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"待处理" image:[UIImage imageNamed:@"goodsNew"] selectedImage:[UIImage imageNamed:@"goodsNew_d"]];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"已处理" image:[UIImage imageNamed:@"goodsHot"] selectedImage:[UIImage imageNamed:@"goodsHot_d"]];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"忽略" image:[UIImage imageNamed:@"goodsPrice"] selectedImage:[UIImage imageNamed:@"goodsPrice_d"]];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;

}

- (void)createTitleAndAddButton{
    //设置标签
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    lblTitle.text = @"任务事项";
    lblTitle.font = [UIFont systemFontOfSize:16];
    lblTitle.textColor = [UIColor colorWithRed:109/255.0 green:49/255.0 blue:23/255.0 alpha:1.0];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lblTitle;
    
    //添加右边的添加按钮
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(addTask) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = addButton;

}
//添加按钮的点击事件
- (void)addTask{
    NSLog(@"asdfasdfas");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            OneViewController *ctrl = [[OneViewController alloc] init];
            return ctrl;
        }
        case 1:
        {
            TwoViewController *ctrl = [[TwoViewController alloc] init];
            return ctrl;
        }
        case 2:
        {
            ThreeViewController *ctrl = [[ThreeViewController alloc] init];
            return ctrl;
        }

        default:
            return nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

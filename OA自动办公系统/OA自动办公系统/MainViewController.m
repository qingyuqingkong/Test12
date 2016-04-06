//
//  ViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "MainViewController.h"
#import "HomeApption.h"
#import "CNFirstEmailViewController.h"
#import "JRSegmentViewController.h"
#import "CNSecondEmailViewController.h"
#import "FlipViewController.h"
#import "CNFlowViewController.h"
#import "CNLoginView.h"
#import "CNUserInfo.h"
#import "MessageViewController.h"

@interface MainViewController () <UIScrollViewDelegate,CNLoginViewDeleget>

@property (nonatomic, strong) NSArray *homeImages;
@property (nonatomic, strong) CNLoginView *loginView;
@end

@implementation MainViewController
#pragma mark --- 懒加载
- (NSArray *)homeImages{
    if (!_homeImages) {
        _homeImages = [HomeApption homeImagesList];
    }
    return _homeImages;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView = [[CNLoginView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.loginView.deleget = self;
    
    //创建UIScrollView
    //创建UIScrollerView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
    
    
    //创建左边的视图  用于展示应用
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [scrollView addSubview:leftView];
    //加载左视图上的应用
    [self createLeftView:leftView];
    
    //创建右边视图
    UIView *rigthView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [scrollView addSubview:rigthView];
    [self createRightView:rigthView];
    
    //设置scrollView的内容大小
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    
    //设置scrollView的分页效果
    scrollView.pagingEnabled = YES;
    
    //隐藏scrollView的水平滚动指示器
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //服从scrollView的代理方法
    scrollView.delegate = self;
    
    //设置scrollView的背景色
    scrollView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:scrollView];
    
    self.navigationController.navigationBarHidden = YES;
    self.showOATitle = NO;
    self.showTabBar = NO;
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.view addSubview:_loginView];
    
}

//隐藏或显示状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}


//创建右边按钮
- (void)createRightView:(UIView *)view{
    //设置显示几行
    int comln = 3;
    CGFloat leftW = 100;
    CGFloat leftH = 100;
    CGFloat margeX = (self.view.frame.size.width - leftW * comln) / 4;
    CGFloat margeY = 55;
    
    for (int i = 0; i < 9; i++) {
        if (i == 1) {
            break;
        }
        HomeApption *model = self.homeImages[i+9];
        int comlnX = i % comln;
        int comlnY = i / comln;
        CGFloat leftX = (leftW + margeX) * comlnX + margeX;
        CGFloat leftY = (leftH + margeY) * comlnY + margeY;
        //创建按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( leftX, leftY, leftW, leftW)];
        button.tag = model.actionTag;
        //创建一个imageview用来安放图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 0, 78, 78)];
        imageView.image = [UIImage imageNamed:model.icon];
        [button addSubview:imageView];
        
        //创建一个Label 用于显示文字
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, 100, 21)];
        lblText.text = model.name;
        lblText.textColor = [UIColor purpleColor];
        lblText.textAlignment = NSTextAlignmentCenter;
        lblText.font = [UIFont systemFontOfSize:12];
        [button addSubview:lblText];
        
        //为按钮注册单击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
}

//创建左边按钮
- (void)createLeftView:(UIView *)view{
    //设置显示几行
    int comln = 3;
    CGFloat leftW = 100;
    CGFloat leftH = 100;
    CGFloat margeX = (self.view.frame.size.width - leftW * comln) / 4;
    CGFloat margeY = 55;
    
    for (int i = 0; i < 9; i++) {
        HomeApption *model = self.homeImages[i];
        int comlnX = i % comln;
        int comlnY = i / comln;
        CGFloat leftX = (leftW + margeX) * comlnX + margeX;
        CGFloat leftY = (leftH + margeY) * comlnY + margeY;
        //创建按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( leftX, leftY, leftW, leftW)];
        button.tag = model.actionTag;
        //创建一个imageview用来安放图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 0, 79, 79)];
        imageView.image = [UIImage imageNamed:model.icon];
        [button addSubview:imageView];
        
        //创建一个Label 用于显示文字
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, 100, 21)];
        lblText.text = model.name;
        lblText.textColor = [UIColor purpleColor];
        lblText.textAlignment = NSTextAlignmentCenter;
        lblText.font = [UIFont systemFontOfSize:12];
        [button addSubview:lblText];
        
        //为按钮注册单击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
}

//按钮的点击事件
- (void)buttonClick:(UIButton *)sender{
    
    for (HomeApption *model in _homeImages) {
        if (sender.tag == model.actionTag) {
            switch (model.actionTag) {
                case 0:
                    //加载邮箱视图
                    [self createEmail];
                    return;
                case 1:
                    NSLog(@"这个是天气的！");
                    return;
                case 2:
                    NSLog(@"这个是手机考勤的！");
                    return;
                case 6:
                    [self createFlipView ];
                    return;
                case 8:
                    //创建手机考勤界面
                    [self createFlowView];
                    return;
                case 9:
                    //任务管理
                    [self createMessageView];
                    return;
                default:
                    break;
            }
        }
        
    }
}

#pragma mark --- 登陆界面的代理方法
- (void)userNameAndPasswordDidSuccess:(CNUserInfo *)userInfo{
    self.userInfo = userInfo;
    
    //添加动画
    [UIView animateWithDuration:0.5 animations:^{
        
        self.loginView.frame = CGRectMake(0, self.view.frame.size.height, self.loginView.frame.size.width, self.loginView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [self.loginView removeFromSuperview];
        
    }];
    
    self.navigationController.navigationBarHidden = NO;
    self.showOATitle = YES;
    self.showTabBar = YES;
    
    
}

//创建任务管理界面
- (void)createMessageView{
    MessageViewController *mvc = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
}

//创建FlowView
- (void)createFlowView{
    CNFlowViewController *flow = [[CNFlowViewController alloc] init];
    [self.navigationController pushViewController:flow animated:YES];
}
//创建FlipView
- (void)createFlipView{
    FlipViewController *flip = [[FlipViewController alloc]initWithNibName:@"FlipViewController" bundle:nil];
    [self.navigationController pushViewController:flip animated:YES];
}

//创建Emain
- (void)createEmail{
    CNFirstEmailViewController *firstVC = [[CNFirstEmailViewController alloc] init];
    CNSecondEmailViewController *secondVC = [[CNSecondEmailViewController alloc] init];
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor colorWithRed:164.0f/255 green:114.0f/255 blue:87.0f/255 alpha:1.0f];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.isShowStatus = YES;
    [vc setViewControllers:@[firstVC, secondVC]];
    [vc setTitles:@[@"收件箱", @"已发送"]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end

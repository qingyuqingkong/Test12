//
//  CNFlowViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/16.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNFlowViewController.h"
#import "CNFlowCell.h"
#import "CNFlowInfo.h"
#import "CNFileOperate.h"
#import "CNLookFlowViewController.h"

@interface CNFlowViewController () <UITableViewDataSource,UITableViewDelegate>{
    int _countNum;
}

@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *btnRefresh;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *isFlow;
@property (nonatomic, strong) UIButton *flowBtn;
@property (nonatomic, strong) UITableView *myTableView;

//保存数据的数组
@property (nonatomic, strong) NSArray *flowinfo;
//保存今天的数据
@property (nonatomic, strong) NSMutableArray *todayInfo;
@end

@implementation CNFlowViewController

#pragma mark -------- 懒加载数据
- (NSArray *)flowinfo{
    if (!_flowinfo) {
        _flowinfo = [CNFlowInfo flowsList];
    }
    return _flowinfo;
}

- (void)initWithtodayInfo{
    //创建时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    //获取当前时间
    NSString *timertamp = [formatter stringFromDate:[NSDate date]];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CNFlowInfo *model in self.flowinfo) {
        //获取当天记录时间
        NSString *timeToday = [formatter stringFromDate:[formatter dateFromString:model.date]];
        if ([timertamp isEqualToString:timeToday]) {
            [array addObject:model];
        }
    }
    _todayInfo = array;
}

- (void)viewDidLoad{
    self.showBackButton = YES;
    self.showOATitle = NO;
    self.showTabBar = NO;
   // [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFlow"];
    self.isFlow = [[NSUserDefaults standardUserDefaults] valueForKey:@"isFlow"];

    if (_isFlow == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFlow"];
        _isFlow = @"NO";
    }
    [self initWithtodayInfo];
    NSLog(@"%@",_isFlow);
    _countNum = 3;
    //设置flow的背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载View的内容
    [self createView];
    
    //加载底部视图
    [self createFooterView];
    
    //添加查看签到功能
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"我的签到" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 64, 21);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lookFlow) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}
//我的签到点击事件
- (void)lookFlow{
    CNLookFlowViewController *lfvc = [[CNLookFlowViewController alloc] init];
    
    
    [self.navigationController pushViewController:lfvc animated:YES];
}
//创建底部视图
- (void)createFooterView{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 272, 115, 1)];
    leftView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [self.view addSubview:leftView];
    
    UILabel *lobLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 250, 115, 44)];
    lobLabel.text = @"今日签到记录";
    lobLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lobLabel];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(250, 272, 115, 1)];
    rightView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [self.view addSubview:rightView];
    
    //创建UITableView
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 292, self.view.frame.size.width, 300)];
    //设置代理
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellAccessoryNone;
    self.myTableView.rowHeight = 60;
    [self.view addSubview:self.myTableView];
}
#pragma mark -------- tableView的代理方法
//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todayInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据
    CNFlowInfo *model = _todayInfo[indexPath.row];
    
    //设置cell
    CNFlowCell *cell = [CNFlowCell loadCellWithTableView:tableView];
    //取消cell点击选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //设置数据
    cell.moedl = model;
    //返回cell
    return cell;
}
//创建顶部视图
- (void)createView{
    //加载获取位置视图
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
    //_imageView.image = ;
    _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    
    [self.view addSubview:_imageView];
    //创建时间View
    UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 1)];
    lineTop.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    [self.view addSubview:lineTop];
    
    UIButton *timeBtnView = [[UIButton alloc] initWithFrame:CGRectMake(0, 81, self.view.frame.size.width, 160)];
    timeBtnView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [timeBtnView addTarget:self action:@selector(flowClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeBtnView];
    self.flowBtn = timeBtnView;
    //self.timeView = timeView;
    //加载刷新按钮
    self.btnRefresh = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 20, 40, 40)];
    [_btnRefresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [_btnRefresh addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnRefresh];
    //获取当前时间并显示在timeView上
    
    //创建一个NSTimer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
    
    //创建label
    UILabel *timeLabel = [[UILabel alloc] init];
    //timeLabel.text = @"HH:MM:SS";
    timeLabel.font = [UIFont systemFontOfSize:50];
    timeLabel.frame = CGRectMake(50, 0, 275, 100);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [timeBtnView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    //创建提示时间
    UILabel *msgLabel = [[UILabel alloc] init];
    //msgLabel.text = @"此时间非签到时间，下次签到时间为17:00:00";
    msgLabel.frame = CGRectMake(100, 100, 175, 44);
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.font = [UIFont systemFontOfSize:14];
    msgLabel.numberOfLines = 0;
    msgLabel.textColor = [UIColor brownColor];
    [timeBtnView addSubview:msgLabel];
    self.msgLabel = msgLabel;
    
    UIView *lineFoord = [[UIView alloc] initWithFrame:CGRectMake(0, 241, self.view.frame.size.width, 1)];
    lineFoord.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    [self.view addSubview:lineFoord];
}

//签到事件
- (void)flowClick{
   // NSLog(@"签到成功");
    //self.msgLabel.text = @"签到成功!!!";
    
    self.flowBtn.userInteractionEnabled = NO;
    self.isFlow = @"YES";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *timestamp = [formatter stringFromDate:[NSDate date]];
    CNFlowInfo *model = [[CNFlowInfo alloc] init];
    model.time = [timestamp substringFromIndex:11];
    model.date = [timestamp substringToIndex:10];
    model.address = @"贵州财经大学";
    if ([[model.time substringToIndex:2] isEqualToString:@"10"]) {
        model.daotui = @"签到";
    } else {
        model.daotui = @"签退";
    }
    
    [[CNFileOperate alloc] writeToFile:@"flowinfo" modelName:model];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFlow"];

    self.flowinfo = nil;
    
    [self initWithtodayInfo];
    //刷新界面
    [self.myTableView reloadData];
}

//刷新位置事件
- (void)refreshClick{
    
    self.imageView.image = [UIImage imageNamed:@"locationBG"];
    //旋转图片
    [UIView animateWithDuration:0.5 animations:^{
        _btnRefresh.transform = CGAffineTransformMakeRotation(M_PI * _countNum);
    } completion:^(BOOL finished) {
        self.imageView.image = [UIImage imageNamed:@"location"];
        _countNum += 7;
    }];
}

//每一秒都被调用一次
- (void)timerFunc{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *timestamp = [formatter stringFromDate:[NSDate date]];
    
    int timesInt = [[timestamp substringToIndex:2] intValue];
    //设置时间
    [self.timeLabel setText:timestamp];
   // NSLog(@"%@",_isFlow);
    if ([self.isFlow isEqualToString:@"NO"]) {
        self.flowBtn.userInteractionEnabled = NO;
        
        if ( timesInt < 10) {
            self.msgLabel.text = @"此时间非签到时间，下次签到时间为10:00:00";
        } else if (timesInt > 10 && timesInt < 19){
            self.msgLabel.text = @"此时间非签退时间，下次签退时间为17:00:00";
        } else if (timesInt > 19 && timesInt <= 23){
            self.msgLabel.text = @"今天考勤时间已结束！";
        } else {
            self.flowBtn.userInteractionEnabled = YES;
            if (timesInt == 10) {
                self.msgLabel.text = @"该时段为签到时段，签到时间是10:00:00~11:00:00";
            } else {
                self.msgLabel.text = @"该时段为签退时段，签退时间是17:00:00~18:00:00";
            }
        }
    } else {
        self.flowBtn.userInteractionEnabled = NO;
        if (timesInt == 10) {
            self.msgLabel.text = @"签到成功";
        } else if (timesInt == 19){
            self.msgLabel.text = @"签退成功";
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFlow"];
            _isFlow = @"NO";
        }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
}
@end

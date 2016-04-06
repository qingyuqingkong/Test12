//
//  CNLookFlowViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNLookFlowViewController.h"
#import "FDCalendar.h"
#import "CNFlowInfo.h"
#import "CNFlowCell.h"
@interface CNLookFlowViewController ()

//保存数据的数组
@property (nonatomic, strong) NSArray *flowinfo;
//保存今天的数据
@property (nonatomic, strong) NSMutableArray *todayInfo;

@property (nonatomic, strong) UIView *footer;
@end

@implementation CNLookFlowViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showBackButton = YES;
    self.showOATitle = NO;
    self.isMoreView = YES;
    
    [self initWithtodayInfo];
    //self.navigationController.title = @"我的签到";
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    lblTitle.text = @"我的签到";
    lblTitle.font = [UIFont systemFontOfSize:16];
    lblTitle.textColor = [UIColor colorWithRed:109/255.0 green:49/255.0 blue:23/255.0 alpha:1.0];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lblTitle;
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame = calendar.frame;
    frame.origin.y = 0;
    calendar.frame = frame;
    
    [self.view addSubview:calendar];
    
    //创建一个监听时间用于监听获取点击的时间
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //添加监听器
    [center addObserver:self selector:@selector(notificationInfo:) name:@"choice_date" object:nil];
    
    //创建  今日打卡记录
    [self createFooterView];
    
    self.footer = [[UIView alloc] initWithFrame:CGRectMake(0, 510, 375, 122)];
    
    int num = 0;
    for (CNFlowInfo *model in _todayInfo) {
        [self createFlowInfo:model formRect:num];
        num++;
    }
    
}

//创建底部视图
- (void)createFooterView{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 425, 115, 1)];
    leftView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [self.view addSubview:leftView];
    
    UILabel *lobLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 405, 115, 44)];
    lobLabel.text = @"今日签到记录";
    lobLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lobLabel];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(250, 425, 115, 1)];
    rightView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [self.view addSubview:rightView];
    
}


- (void)notificationInfo:(NSNotification *)center{
    NSDictionary *info = center.userInfo;
    
    //创建时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    //获取选中时间
    NSString *timertamp = [[info allValues] lastObject];
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *arrayInfo = [CNFlowInfo flowsList];
    for (CNFlowInfo *model in arrayInfo) {
        //获取当天记录时间
        NSString *timeToday = [formatter stringFromDate:[formatter dateFromString:model.date]];
        if ([timertamp isEqualToString:timeToday]) {
            [array addObject:model];
        }
    }
    _todayInfo = array;
    [self.footer removeFromSuperview];
    self.footer = [[UIView alloc] initWithFrame:CGRectMake(0, 510, 375, 122)];
    int num = 0;
    for (CNFlowInfo *model in _todayInfo) {
        [self createFlowInfo:model formRect:num];
        num++;
    }
    
}
//18286184459

//创建显示的View
- (void)createFlowInfo:(CNFlowInfo *)model formRect:(int)num{

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(10, 0 + (num - 1) * 62, 355, 1)];
    topView.backgroundColor = [UIColor colorWithRed:255/255.0 green:205/255.0 blue:88/255.0 alpha:1.0];
    [self.footer addSubview:topView];
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(10, 1 + (num - 1) * 62, 355, 60)];
    textView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:212/255.0 alpha:1];
    [self.footer addSubview:textView];
    
    UILabel *lblLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 165, 40)];
    lblLeft.text = [NSString stringWithFormat:@"%@ %@",model.date,model.time];
    lblLeft.textAlignment = NSTextAlignmentCenter;
    [textView addSubview:lblLeft];
    
    UILabel *lblRight = [[UILabel alloc] initWithFrame:CGRectMake(165, 10, 165, 40)];
    lblRight.text = model.address;
    lblRight.textAlignment = NSTextAlignmentCenter;
    [textView addSubview:lblRight];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(10, 61 + (num - 1) * 62, 355, 1)];
    footerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:205/255.0 blue:88/255.0 alpha:1.0];
    [self.footer addSubview:footerView];
    
    //self.footer = footer;
    [self.view addSubview:_footer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

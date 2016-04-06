//
//  OneViewController.m
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import "OneViewController.h"
#import "CNTaskCell.h"

@interface OneViewController () <UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.rowHeight = 200;
}

#pragma mark ----- UITableView的代理方法和数据源方法 -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取模型数据
    
    //创建cell
    CNTaskCell *cell = [CNTaskCell taskCell:tableView];
    
    
    //设置模型数据
    
    //返回cell
    return cell;
}




- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"one didReceiveMemoryWarning");
}
- (void)dealloc{
    [_myTableView release];
}


@end

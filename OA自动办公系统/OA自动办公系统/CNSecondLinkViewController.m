//
//  CNSecondLinkViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/11.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNSecondLinkViewController.h"
#import "CNGroup.h"
#import "CNFriend.h"
#import "CNFrindCell.h"
#import "CNGoupHeaderView.h"
#import "CNMessageViewController.h"

#import "CNFirestLinkViewController.h"

@interface CNSecondLinkViewController () <CNGoupHeaderViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

//保存所有的朋友信息（分组信息）
@property (nonatomic, strong) NSArray *groups;

@end

@implementation CNSecondLinkViewController



#pragma mark - 懒加载分组数据
- (NSArray *)groups{
    if (!_groups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arrayDicts = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDicts) {
            CNGroup *model = [CNGroup groupWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    return _groups;
}


#pragma mark --- CNGoupHeaderViewDelegate的代理方法
- (void)groupHeaderViewDidClickGroupTitleButton:(CNGoupHeaderView *)groupHeaderView{
    //刷新全局的tableView
    //[self.table reloadData];
    //刷新组
    //创建一个用来表示某个组的对象
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark --- 实现数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //因为在这个发昂发中，要根据当前组的状态（是否展开），来设置不同的返回值
    //所以需要为CNGroup模型中增加一个属性来控制
    
    CNGroup *group = self.groups[section];
    if (group.isVisible) {
        return group.friends.count;
    } else{
        return 0;
    }
}

//返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.获取模型对象（数据）
    CNGroup *group = self.groups[indexPath.section];
    CNFriend *friend = group.friends[indexPath.row];
    
    //2.创建单元格（视图）
    CNFrindCell *cell = [CNFrindCell friendCellWithTableView:tableView];
    
    //3.设置单元格数据（把模型设置给单元格)
    cell.friendModel = friend;
    
    //4.返回单元格
    return cell;
    
}

//设置每一组的组标题 (下面的这个方法只能设置每一组的组标题字符串，但是我们要得是每一组中还包含其他子控件)
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    CNGroup *group = self.groups[section];
//    return group.name;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //不需要在这个方法中直接创建一个UIView对象返回，因为这样无法实现重用该UIView
    //为了重用每个Header中的UIView，所以这里要
    
    //1.获取模型数组
    CNGroup *group = self.groups[section];
    
    //2.创建UITableViewHeaderFooterView
    CNGoupHeaderView *headerView = [CNGoupHeaderView groupHeaderViewWithTableView:tableView];
    //记录当前组
    headerView.tag = section;
    //3.设置单元格数据
    headerView.group = group;
    //设置headerView的代理
    headerView.delegate = self;
    
    //在创建好的headerView中获取的headerView的frame都是0，是因为创建好的headerView 我们没有为其frame赋值，所以frame都是0
    //但是程序运行起来以后，heade是有frame的，是因为在当前方法中，将headerView返回以后，UITableView在执行的适合，会用到headerView，UITableView极软要用headerView，那么就必须将headerView添加到UITableView中，当把headerView添加到UITableView中的时候，UITableView内部会根据一些设置来动态的为headerView的frame赋值，也就是说在UITableView即将使用headerView的适合，才会为headerView的frame赋值.
    //4.返回单元格
    return headerView;
}

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取联系人信息
    CNGroup *group = _groups[indexPath.section];
    CNFriend *friend = group.friends[indexPath.row];
    
    //创建聊天界面
    CNMessageViewController *message = [[CNMessageViewController alloc] initWithNibName:@"CNMessageViewController" bundle:nil friendModel:friend];
    
    [self.navigationController pushViewController:message animated:YES];
}


//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //统一设置每组的组标题的高度
    self.table.sectionHeaderHeight = 60;
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.separatorStyle = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

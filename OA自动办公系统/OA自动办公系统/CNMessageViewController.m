//
//  CNMessageViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/13.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNMessageViewController.h"
#import "CNMessage.h"
#import "CNMessageFrame.h"
#import "CNMessageCell.h"
#import "CNFriend.h"

@interface CNMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *txtInput;
@property (nonatomic, strong) CNFriend *model;

//用来保存所有的消息的frame模型对象
@property (nonatomic, strong) NSMutableArray *messageFrames;
@end

@implementation CNMessageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                    friendModel:(CNFriend *)model{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = model;
    }
    return self;
}

#pragma mark - 懒加载数据
- (NSMutableArray *)messageFrames{
    if (!_messageFrames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            //创建一个数据模型
            CNMessage *model = [CNMessage messageWithDict:dict];
            
            //获取上一个数据模型
            CNMessage *lastMessage = (CNMessage *)[[arrayModels lastObject] message];
            
            //判断当前模型的“消息发送时间”是否和上一个模型的“消息发送时间“一致，如果一致做个标记
            if ([model.time isEqualToString:lastMessage.time]) {
                model.hideTime = YES;
            }
            
            //创建一个frame模型
            CNMessageFrame *modelFrame = [[CNMessageFrame alloc] init];
            modelFrame.message = model;
            
            //把frame模型加到arrayModel
            [arrayModels addObject:modelFrame];
        }
        _messageFrames = arrayModels;
    }
    return _messageFrames;
}

#pragma mark - 文本框的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //1.获取用户输入的文本
    NSString *text = textField.text;
    
    //2.发送用户输入的文本
    [self sendMessage:text withType:CNMessageTypeMe];
    
    //3.发送一个系统消息
    [self sendMessage:@"不知道，不晓得!" withType:CNMessageTypeOther];
    
    //4.发送清空文本框
    textField.text = nil;
    return YES;
}

- (void)sendMessage:(NSString *)msg withType:(CNMessageType)type{
    //2.创建一个数据模型和frame模型
    CNMessage *model = [[CNMessage alloc] init];
    //获取当前系统时间
    NSDate *newDate = [NSDate date];
    //创建一个日期时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式
    formatter.dateFormat = @"今天 HH:mm";
    model.time = [formatter stringFromDate:newDate];
    
    model.type = type;
    model.text = msg;
    
    //根据当前消息的时间和上一条消息的时间，来设置是否需要隐藏时间Label
    CNMessageFrame *lastMessageFrame = [self.messageFrames lastObject];
    NSString *lastTime = lastMessageFrame.message.time;
    
    if ([model.time isEqualToString:lastTime]) {NSLog(@"执行了");
        model.hideTime = YES;
    }
    //创建一个frame模型
    CNMessageFrame *messageFrame = [[CNMessageFrame alloc] init];
    messageFrame.message = model;
    //3.把frame模型加到集合当中
    [self.messageFrames addObject:messageFrame];
    
    //4.刷新uitablevi的数据
    [self.tableView reloadData];
    
    //5.把最后一行滚到最上面
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark - 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //把键盘叫回去，让控制器所管理的UIView
    [self.view endEditing:YES];
}

#pragma mark - 数据源方法
//当键盘上的return键盘被单击的时候
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.获取模型数据
    CNMessageFrame *modelFrame = self.messageFrames[indexPath.row];
    
    //2.创建单元格
    CNMessageCell *cell = [CNMessageCell messageCellWithTableView:tableView];
    
    //3.把模型设置给单元格
    cell.messageFrame = modelFrame;
    //4.返回单元格
    return cell;
    
}

//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //显示back按钮
    self.showBackButton = YES;
    //隐藏工具栏
    self.showTabBar = NO;
    self.showOATitle = NO;
    
    //设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.txtInput.delegate = self;
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0];
    //设置UITableView的航不能被选中
    self.tableView.allowsSelection = NO;
    
    //设置文本框最左侧有一段距离
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 5, 1);
    
    //把leftView设置给文本框
    self.txtInput.leftView = leftView;
    self.txtInput.leftViewMode = UITextFieldViewModeAlways;
    
    //监听键盘的弹出的事件
    //1.创建一个NSNotificationCenter对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //2.监听键盘的弹出通知
    [center addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyBoardWillChangeFrame:(NSNotification *)noteInfo{
    //1.获取键盘的Y值
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y - 64;
    NSLog(@"%g",keyboardY);
    CGFloat tranformVale = keyboardY - self.view.frame.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, tranformVale);
    }];
    
    //让UITableView的最后一行滚动最上面
    NSIndexPath *lastRowIdxPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastRowIdxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

// *********************注意：监听通知以后一定要在监听通知的对象的dealloc方法直接欧诺个移除监听*******************//
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

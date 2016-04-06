//
//  CNLinkViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNLinkViewController.h"
#import "JRSegmentViewController.h"
#import "CNFirestLinkViewController.h"
#import "CNSecondLinkViewController.h"

@interface CNLinkViewController ()

@end

@implementation CNLinkViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //NSLog(@"aaaa");
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    CNFirestLinkViewController *firstVC = [[CNFirestLinkViewController alloc] init];
    CNSecondLinkViewController *secondVC = [[CNSecondLinkViewController alloc] init];
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor colorWithRed:164.0f/255 green:114.0f/255 blue:87.0f/255 alpha:1.0f];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.isShowStatus = NO;
    [vc setViewControllers:@[firstVC, secondVC]];
    [vc setTitles:@[@"回话", @"全部"]];
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  NSTimerInprovement
//
//  Created by 刘冲 on 2018/7/30.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *timerLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(100.0, 100.0, 100.0, 100.0);
    [button addTarget:self action:@selector(gotoTimerVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)gotoTimerVC {
    [self.navigationController pushViewController:[[TimerViewController alloc] init] animated:YES];
}

@end

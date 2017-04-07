//
//  MainViewController.m
//  iOS与H5的交互理解
//
//  Created by dingping on 2017/4/6.
//  Copyright © 2017年 dingping. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UIButton *testButton;


@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testButton];
    self.testButton.frame = CGRectMake(100, 200, 200, 100);
    
}

- (UIButton *)testButton
{
    if(!_testButton) {
        _testButton = [[UIButton alloc]init];
        [_testButton setTitle:@"点击跳转到网页" forState:UIControlStateNormal];
        _testButton.backgroundColor = [UIColor cyanColor];
        [_testButton addTarget:self action:@selector(pushToNext) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _testButton;
}

- (void)pushToNext
{
    WebViewController *vc = [[WebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

//
//  KYViewController.m
//  KYToast
//
//  Created by wkwl on 06/13/2022.
//  Copyright (c) 2022 wkwl. All rights reserved.
//

#import "KYViewController.h"
#import <KYToast.h>

@interface KYViewController ()

@end

@implementation KYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapClick {
    [KYToast showNormalToast:@"测试数据测试数据是测试数据11111111111我的测试我的测试长段" duration:2 showType:KYToastShowTypeCenter];

}

@end

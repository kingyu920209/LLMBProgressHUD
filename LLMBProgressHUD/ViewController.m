//
//  ViewController.m
//  LLMBProgressHUD
//
//  Created by 嘚嘚以嘚嘚 on 2018/5/20.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+LLMB.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showCustomMessage:@"111" type:(BWMMBProgressHUDMsgTypeSuccessful) isWindow:NO timer:2 completion:^{
        NSLog(@"1");
    }];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

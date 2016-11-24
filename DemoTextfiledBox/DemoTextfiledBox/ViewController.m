//
//  ViewController.m
//  DemoTextfiledBox
//
//  Created by zhangshaoyu on 15/11/28.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYBoxTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"方框输入";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButtonClick)];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    // 1
    SYBoxTextField *boxTextfield1 = [[SYBoxTextField alloc] initWithFrame:CGRectMake(10.0, 10.0, 40.0 * 5 + 10 * 5, 40.0)];
    [self.view addSubview:boxTextfield1];
    boxTextfield1.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [boxTextfield1 boxInput:5 textEntry:YES editDone:^(NSString *text) {
        NSLog(@"text %@", text);
    }];
    boxTextfield1.limitStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    boxTextfield1.keyboardType = UIKeyboardTypeNumberPad;
    boxTextfield1.textBackgroundColor = [UIColor yellowColor];
    boxTextfield1.textCornerRadius = 5.0;
    boxTextfield1.textBorderColor = [UIColor blackColor];
    boxTextfield1.color = [UIColor redColor];
    
    // 2
    SYBoxTextField *boxTextfield2 = [[SYBoxTextField alloc] initWithFrame:CGRectMake(10.0, 60.0, 40.0 * 6 + 15.0 * 6, 40.0) count:6 textEntry:NO editDone:^(NSString *text) {
        NSLog(@"text %@", text);
    }];
    [self.view addSubview:boxTextfield2];
    boxTextfield2.limitStr = @"0123456789";
    boxTextfield2.keyboardType = UIKeyboardTypeDefault;
    
    // 3
    SYBoxTextField *boxTextfield3 = [[SYBoxTextField alloc] init];
    boxTextfield3.frame = CGRectMake(10.0, 120.0, 100.0, 30.0);
    [boxTextfield3 boxInput:6 textEntry:NO editDone:^(NSString *text) {
        NSLog(@"text %@", text);
    }];
    [self.view addSubview:boxTextfield3];
    boxTextfield3.keyboardType = UIKeyboardTypeDefault;
    
}

- (void)CancelButtonClick
{
    [self.view endEditing:YES];
}

@end

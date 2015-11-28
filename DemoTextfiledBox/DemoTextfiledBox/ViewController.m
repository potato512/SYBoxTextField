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

    SYBoxTextField *boxText = [[SYBoxTextField alloc] initWithFrame:CGRectMake(10.0, 10.0, 40.0 * 5 + 10 * 5, 40.0)];
    [self.view addSubview:boxText];
    boxText.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [boxText boxInput:5 textEntry:YES editDone:^(NSString *text) {
        NSLog(@"text %@", text);
    }];
    boxText.limitStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    boxText.keyboardType = UIKeyboardTypeNumberPad;
    boxText.textBackgroundColor = [UIColor orangeColor];
    boxText.textCornerRadius = 5.0;
    boxText.textBorderColor = [UIColor blackColor];
    boxText.secureTextEntry = NO;
    
    
    SYBoxTextField *boxTextfield = [[SYBoxTextField alloc] initWithFrame:CGRectMake(10.0, 60.0, 40.0 * 6 + 15.0 * 6, 40.0) count:6 textEntry:NO editDone:^(NSString *text) {
        NSLog(@"text %@", text);
    }];
    [self.view addSubview:boxTextfield];
    boxTextfield.limitStr = @"0123456789";
}

- (void)CancelButtonClick
{
    [self.view endEditing:YES];
}

@end

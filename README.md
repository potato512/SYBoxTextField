# BoxEntryTextField
小方块输入框（类似于微信支付密码的方块输入框）

~~~ javascript

// 使用方法介绍
// 导入头文件
#import "SYBoxTextField.h"

// 实例化方法
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

// 实例化方法
SYBoxTextField *boxTextfield = [[SYBoxTextField alloc] initWithFrame:CGRectMake(10.0, 60.0, 40.0 * 6 + 15.0 * 6, 40.0) count:6 textEntry:NO editDone:^(NSString *text) {
NSLog(@"text %@", text);
}];
[self.view addSubview:boxTextfield];
boxTextfield.limitStr = @"0123456789";

~~~
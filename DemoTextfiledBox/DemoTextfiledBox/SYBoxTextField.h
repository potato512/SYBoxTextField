//
//  BoxTextField.h
//  DemoTextfiledBox
//
//  Created by zhangshaoyu on 15/11/28.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBoxTextField : UITextField

/// 实例化方块输入框（位数，明文或密文显示）
- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count textEntry:(BOOL)isSecureText editDone:(void (^)(NSString *text))done;

/// 方块输入框（位数，明文或密文显示）
- (void)boxInput:(NSInteger)count textEntry:(BOOL)isSecureText editDone:(void (^)(NSString *text))done;

/// 限制字符（默认只能输入数字）
@property (nonatomic, strong) NSString *limitStr;

/// 字符方框背景色（默认白色）
@property (nonatomic, strong) UIColor *textBackgroundColor;

/// 字符方框圆角（默认3.0）
@property (nonatomic, assign) CGFloat textCornerRadius;

/// 字符方框边框颜色（默认黑色）
@property (nonatomic, strong) UIColor *textBorderColor;

@end

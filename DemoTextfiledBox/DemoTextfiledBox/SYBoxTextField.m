//
//  BoxTextField.m
//  DemoTextfiledBox
//
//  Created by zhangshaoyu on 15/11/28.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYBoxTextField.h"

static NSString *const markSecureText = @"●"; // ● *

@interface SYBoxTextField () <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) BOOL isSecureText;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, copy) void (^editFinish)(NSString *text);

@end

@implementation SYBoxTextField

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count textEntry:(BOOL)isSecureText editDone:(void (^)(NSString *text))done
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self boxInput:count textEntry:isSecureText editDone:done];
    }
    
    return self;
}

#pragma mark - 视力

/// 方块输入框（位数，明文或密文显示）
- (void)boxInput:(NSInteger)count textEntry:(BOOL)isSecureText editDone:(void (^)(NSString *text))done
{
    if (0 < count)
    {
        self.delegate = self;

        self.maxCount = count;
        self.isSecureText = isSecureText;
        self.editFinish = done;
        
        self.tintColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor clearColor];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textAlignment = NSTextAlignmentCenter;
      
        CGFloat heightSelf = CGRectGetHeight(self.bounds);
        CGFloat widthSelf = ((heightSelf * self.maxCount < CGRectGetWidth(self.bounds)) ? CGRectGetWidth(self.bounds) : (heightSelf * self.maxCount));
        
        CGFloat widthItem = heightSelf;
        CGFloat heightItem = heightSelf;
        CGFloat originX = ((widthSelf - widthItem * self.maxCount) / (self.maxCount - 1));
        CGFloat originY = 0.0;
        
        self.labelArray = [[NSMutableArray alloc] initWithCapacity:self.maxCount];
        for (int i = 0; i < self.maxCount; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i * (widthItem + originX)), originY, widthItem, heightItem)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 0.5;
            [self addSubview:label];
            
            [self.labelArray addObject:label];
        }
        
        self.textBackgroundColor = [UIColor whiteColor];
        self.textCornerRadius = 3.0;
        self.textBorderColor = [UIColor blackColor];
        
        self.limitStr = @"0123456789";
        self.textArray = [[NSMutableArray alloc] initWithCapacity:self.maxCount];
    }
}

- (void)resetLabelBackgroundColor
{
    for (NSInteger i = 0; i < self.maxCount; i++)
    {
        UILabel *label = self.labelArray[i];
        label.backgroundColor = _textBackgroundColor;
    }
}

- (void)resetLabelCornerRadius
{
    for (NSInteger i = 0; i < self.maxCount; i++)
    {
        UILabel *label = self.labelArray[i];
        label.layer.cornerRadius = _textCornerRadius;
    }
}

- (void)resetLabelBorderColor
{
    for (NSInteger i = 0; i < self.maxCount; i++)
    {
        UILabel *label = self.labelArray[i];
        label.layer.borderColor = _textBorderColor.CGColor;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController)
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

#pragma mark - 信息处理

// 只能输入指定位数字符
- (BOOL)limitTextCharacters:(NSString *)limitCharacter number:(NSInteger)limitNumber string:(NSString *)string
{
    NSInteger length = self.textArray.count;
    // 字数限制
    if (length > limitNumber)
    {
        return NO;
    }
    else
    {
        if (limitCharacter && 0 < limitCharacter.length)
        {
            if ([limitCharacter containsString:string])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    
    return YES;
}

// 显示输入字符
- (void)showLabelText
{
    for (NSInteger i = 0; i < self.maxCount; i++)
    {
        UILabel *label = self.labelArray[i];
        NSString *text = (i < self.textArray.count ? self.textArray[i] : @"");
        label.text = ((self.isSecureText && 0 != text.length) ? markSecureText : text);
    }
    
    if (self.editFinish && self.textArray.count == self.maxCount)
    {
        NSMutableString *textStr = [[NSMutableString alloc] initWithCapacity:self.maxCount];
        for (NSString *string in self.textArray)
        {
            [textStr appendString:string];
        }
        self.editFinish(textStr);
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 回车时退出，同时判断输入不能为空
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        
        return NO;
    }

    if ([textField isFirstResponder])
    {
        BOOL isResult = [self limitTextCharacters:self.limitStr number:self.maxCount string:string];

        if ([string isEqualToString:@""])
        {
            // 删除键时，删除信息
            [self.textArray removeLastObject];
        }
        else
        {
            if ((self.textArray.count < self.maxCount) && isResult)
            {
                [self.textArray addObject:string];
            }
        }
        [self performSelector:@selector(showLabelText) withObject:nil afterDelay:0.1];
        
        return isResult;
    }
    
    return YES;
}

#pragma mark - setter

- (void)setTextBackgroundColor:(UIColor *)textBackgroundColor
{
    _textBackgroundColor = textBackgroundColor;
    [self resetLabelBackgroundColor];
}

- (void)setTextCornerRadius:(CGFloat)textCornerRadius
{
    _textCornerRadius = textCornerRadius;
    [self resetLabelCornerRadius];
}

- (void)setTextBorderColor:(UIColor *)textBorderColor
{
    _textBorderColor = textBorderColor;
    [self resetLabelBorderColor];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    self.isSecureText = secureTextEntry;
}

- (void)setLimitStr:(NSString *)limitStr
{
    _limitStr = limitStr;
}

@end

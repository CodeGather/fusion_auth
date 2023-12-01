//
//  AlicomFusionVerifyCodeView.h
//  AlicomFusionAuthSDK
//
//  Created by lyz on 2023/1/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AlicomFusionVerifyCodeInputView.h"

NS_ASSUME_NONNULL_BEGIN

/* 短信验证码自定义View */
@interface AlicomFusionVerifyCodeView : UIView
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

#pragma mark - 自己输入手机号，10001、100002、100003、100004模版使用
/// 获取验证码父View
@property (nonatomic, strong) UIView *verifyCodeSendView;

/// 国家代码显示区
@property (nonatomic, strong) UILabel *countryCodeLabel;

/// 手机号输入
@property (nonatomic, strong) UITextField *phoneTextField;

/// 分割线
@property (nonatomic, strong) UIView *lineView;

#pragma mark - 自动填充手机号,10002、100005模版使用
/// 手机号部分
@property (nonatomic, strong) UILabel *phoneNumLabel;//带*号

@property (nonatomic, strong) NSString *phoneNumText;//真实手机号
/// 说明部分
@property (nonatomic, strong) UILabel *phoneNumExplainLabel;

#pragma mark - 按钮
/// 获取验证码按钮
@property (nonatomic, strong) UIButton *verifyCodeSendBtn;

#pragma mark 协议 100001模板使用
/// checkbox
@property (nonatomic, strong) UIButton *checkBoxBtn;

/// 隐私协议
@property (nonatomic, strong) UITextView *privacyTextView;

#pragma mark - 验证码部分
/// 提交验证码父View
@property (nonatomic, strong) UIView *verifyCodeSubmitView;

/// 发送成功之后的文案
@property (nonatomic, strong) UILabel *expainLabel;

/// 验证码输入框
@property (nonatomic, strong) AlicomFusionVerifyCodeInputView *codeView;

/// 提交验证按钮
@property (nonatomic, strong) UIButton *verifyCodeSubmitBtn;

/// 点击手势，用于收回键盘
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;


/// 获取验证码按钮点击事件,如果需要自己实现按钮事件，则需要调用该方法实现验证码发送
/// - Parameter phoneNumber: 手机号
/// - Parameter checked: 是否同意了协议,该参数只针对100001模板(注册登陆模板)生效，其他模板没有协议功能
- (void)verifyCodeBtnClick:(NSString *)phoneNumber checked:(BOOL)checked;

/// 提交验证码
/// - Parameters:
///   - phoneNumber: 手机号
///   - code: 验证码
- (void)submitVerifyCodeBtnClick:(NSString *)phoneNumber code:(NSString *)code;


@end

NS_ASSUME_NONNULL_END

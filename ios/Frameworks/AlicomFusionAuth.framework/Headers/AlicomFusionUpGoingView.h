//
//  AlicomFusionUpGoingView.h
//  AlicomFusionAuthSDK
//
//  Created by lyz on 2023/1/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* 上行短信验证验证自定义view */
@interface AlicomFusionUpGoingView : UIView

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

/// 顶部说明文案背景
@property (nonatomic, strong) UIView *contentBgView;

/// 顶部说明文案
@property (nonatomic, strong) UILabel *contentLabel;

/// 短信内容标题
@property (nonatomic, strong) UILabel *upGoingTitleLabel;

/// 短信内容
@property (nonatomic, strong) UILabel *upGoingContentLabel;

/// 短信接收号码标题
@property (nonatomic, strong) UILabel *phoneTitleLabel;

/// 短信接收号码
@property (nonatomic, strong) UILabel *phoneContentLabel;

/// 去发送短信按钮
@property (nonatomic, strong) UIButton *upGoingSendBtn;

/// 我已发送短信按钮
@property (nonatomic, strong) UIButton *upGoingAlreadySendBtn;

/// 去发送短信
/// smsContent 短信内容
/// receiveNum接收号码
- (void)gotoSendUpGoing:(NSString *)smsContent receiveNum:(NSString *)receiveNum;

/// 已发送短信
- (void)upGoingAlreadySend;

@end

NS_ASSUME_NONNULL_END

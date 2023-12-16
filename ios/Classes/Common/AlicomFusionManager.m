//
//  AlicomFusionMananer.m
//  AlicomFusionAuthDemo
//
//  Created by yanke on 2023/2/13.
//

#import <MJExtension/MJExtension.h>
#import "NSDictionary+Utils.h"
#import "UIColor+Hex.h"
#import "AlicomFusionManager.h"
#import "AlicomFusionUtil.h"
#import "AlicomFusionToastTool.h"
#import "FusionAuthCommon.h"
#import "AlicomFusionAuthTokenManager.h"
#import "AlicomFusionNetAdapter.h"
#import "AlicomFusionWebViewController.h"

#define TX_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define TX_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface AlicomFusionManager ()
@property (nonatomic, copy) NSString *currTemplateId;
@property (nonatomic, weak) UIViewController *currVC;
@property (nonatomic, assign) NSInteger reGetTime;
@property (nonatomic, assign) AlicomFusionNumberAuthModel *authmodel;
@property (nonatomic, strong) AlicomFusionVerifyCodeView *verifyView;
@property (nonatomic, strong) AlicomFusionUpGoingView *upGoingView;
@property (nonatomic, copy) NSString *smsContent;
@property (nonatomic, copy) NSString *receiveNum;
@end

@implementation AlicomFusionManager{
  FusionAuthCommon *common;
}

+ (instancetype)shareInstance {
    static AlicomFusionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            [AlicomFusionLog logEnable:YES];
            instance = [[AlicomFusionManager alloc] init];
            instance.reGetTime = 3;
        }
    });
    return instance;
}

- (void)destory {
    [self.handler destroy];
    self.handler = nil;
    self.isActive = NO;
}

- (void)start{
  if (self->common == nil) {
    self->common = [FusionAuthCommon shareInstance];
  }
  if (self->common.DEBUG_MODE) {
    // 1. 快速访问模式
    if (self->common.TOKEN != NULL) {
      [AlicomFusionAuthTokenManager shareInstance].authTokenStr = self->common.TOKEN;
      [self initFusionAuth];
    } else {
      // 开启简易模式必须指定token参数
    }
  } else {
    // 2. 正常访问模式
    [AlicomFusionAuthTokenManager getAuthToken:^(NSString * _Nonnull tokenStr,NSString *errorMsg) {
        if (errorMsg){
            dispatch_async(dispatch_get_main_queue(), ^{
                [AlicomFusionToastTool showToastMsg:errorMsg time:2];
            });
        } else {
            [self initFusionAuth];
        }
    }];
  }
}

#pragma mark - 开始场景
- (void)startSceneWithTemplateId:(NSString *)templateId viewController:(UIViewController *)controller{
    self.currTemplateId = templateId;
    self.currVC = controller;
    [self.handler startSceneUIWithTemplateId:self.currTemplateId viewController:controller delegate:self];
}

#pragma mark - 继续场景
- (void)continueScane{
  [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
}

#pragma mark - 结束场景
- (void)stopScene{
    [self.handler stopSceneWithTemplateId:self.currTemplateId];
}

#pragma mark - 主动更新Token
/**
 * 此方法为用户主动更新Token，Token相关鉴权及更新逻辑参考initWithToken中的Token逻辑。
 */
- (void)updateToken: (NSString *)tokenStr{
  AlicomFusionAuthToken *token = [[AlicomFusionAuthToken alloc] initWithTokenStr:tokenStr];
  [self.handler updateToken:token];
}

#pragma mark - 获取SDK版本号
- (NSString *)getSDKVersion{
    return [AlicomFusionAuthHandler getSDKVersion];
}

- (void)initFusionAuth{
    if (!self.handler){
       NSString *tokenStr = [AlicomFusionAuthTokenManager shareInstance].authTokenStr;
       AlicomFusionAuthToken *token = [[AlicomFusionAuthToken alloc] initWithTokenStr:tokenStr];
       self.handler = [[AlicomFusionAuthHandler alloc] initWithToken:token schemeCode:self->common.SCHEME_CODE];
       [self.handler setFusionAuthDelegate:self];
    }
}

- (void)dealWithPhone:(NSString *)phoneNum {
  NSString * kDEMO_UD_PHONE_NUM = @"18888888888";
    if (phoneNum.length < 11) {
        [AlicomFusionToastTool showToastMsg:@"获取手机号失败" time:2];
        return;
    }
    if ([AlicomFusionTemplateId_100001 isEqualToString:self.currTemplateId]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:phoneNum forKey:kDEMO_UD_PHONE_NUM];
        [ud synchronize];
        [AlicomFusionToastTool showToastMsg:@"登录成功" time:2];
        [self.handler stopSceneWithTemplateId:self.currTemplateId];
    } else if ([AlicomFusionTemplateId_100002 isEqualToString:self.currTemplateId]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:phoneNum forKey:kDEMO_UD_PHONE_NUM];
        [ud synchronize];
        [AlicomFusionToastTool showToastMsg:@"修改手机号成功" time:2];
        [self.handler stopSceneWithTemplateId:self.currTemplateId];
    } else if ([AlicomFusionTemplateId_100003 isEqualToString:self.currTemplateId]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *loginPhone = [ud objectForKey:kDEMO_UD_PHONE_NUM];
        if ([phoneNum isEqualToString:loginPhone]) {
            [AlicomFusionToastTool showToastMsg:@"手机号验证通过,可以去修改密码了" time:2];
            [self.handler stopSceneWithTemplateId:self.currTemplateId];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(verifySuccess)]){
                    [self.delegate verifySuccess];
                }
            });
        } else {
            [AlicomFusionToastTool showToastMsg:@"手机号验证不通过" time:2];
            [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
        }
    } else if ([AlicomFusionTemplateId_100004 isEqualToString:self.currTemplateId]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:phoneNum forKey:kDEMO_UD_PHONE_NUM];
        [ud synchronize];
        [AlicomFusionToastTool showToastMsg:@"新手机号绑定成功" time:2];
        [self.handler stopSceneWithTemplateId:self.currTemplateId];
    } else if ([AlicomFusionTemplateId_100005 isEqualToString:self.currTemplateId]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *loginPhone = [ud objectForKey:kDEMO_UD_PHONE_NUM];
        if ([phoneNum isEqualToString:loginPhone]) {
            [AlicomFusionToastTool showToastMsg:@"手机号验证通过" time:2];
            [self.handler stopSceneWithTemplateId:self.currTemplateId];
        } else {
            [AlicomFusionToastTool showToastMsg:@"手机号验证不通过" time:2];
            [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
        }
    }

    
}

#pragma mark - AlicomFusionAuthDelegate
/**
 *  token需要更新
 *  @note 必选回调，handler 初始化&历史token过期前5分钟，会触发此回调，由SDK维护token的生命周期
 *  @param handler handler
 *  @return token，APP更新最新token后，组装AlicomFusionAuthToken返回给到SDK，SDK会通过此token进行鉴权更新
 */
- (AlicomFusionAuthToken *)onSDKTokenUpdate:(AlicomFusionAuthHandler *)handler {
  NSLog(@"%s，调用",__func__);
  NSString *tokenStr = @"";
  if (self->common.DEBUG_MODE) {
    // 1. 快速访问模式
    tokenStr = self->common.TOKEN;
  } else {
    // 2. 正常访问模式
    tokenStr = [AlicomFusionAuthTokenManager updateAuthToken];
  }
  AlicomFusionAuthToken *token = [[AlicomFusionAuthToken alloc] initWithTokenStr:tokenStr];
  return token;
}

/**
 *  场景事件回调
 *  @note 可选回调，SDK场景流程中流程中各个界面点击事件&界面跳转事件等UI相关回调
 *  @note 本回调接口仅做事件通知，不可再此回调内处理业务逻辑
 *  @param handler handler
 *  @param event 点击事件，具体定义参考AlicomFusionEvent.h
 */
- (void)onAuthEvent:(AlicomFusionAuthHandler *)handler
          eventData:(AlicomFusionEvent *)event {
  NSLog(@"%s，调用:{\n%@}", __func__, event.description);
  [self->common showResultMsg: event.mj_keyValues msg:@""];
}

/**
 *  token鉴权成功
 *  @note 必选回调，token鉴权成功后，才可以调用startScene接口拉起场景
 *  @param handler handler
 */
- (void)onSDKTokenAuthSuccess:(AlicomFusionAuthHandler *)handler {
  NSLog(@"%s，调用",__func__);
  self.isActive = YES;
  self.reGetTime = 3;
  dispatch_async(dispatch_get_main_queue(), ^{
    [[AlicomFusionManager shareInstance]
     startSceneWithTemplateId:[FusionAuthCommon shareInstance].TEMLATEID
               viewController:[AlicomFusionUtil findCurrentViewController]
    ];
  });
  NSDictionary *dict = @{ @"resultCode": @"300002", @"resultMsg": @"Token鉴权合法" };
  [self->common showResultMsg: dict.mj_keyValues msg:@""];
}

/**
 *  token鉴权失败
 *  @note 必选回调，token初次鉴权失败&token更新后鉴权失败均会触发此回调
 *  @note token鉴权失败后，无法继续使用SDK的功能，请销毁SDK后重新初始化
 *  @param handler handler
 *  @param failToken 错误token
 *  @param error 错误定义
 */
- (void)onSDKTokenAuthFailure:(AlicomFusionAuthHandler *)handler
                    failToken:(AlicomFusionAuthToken *)failToken
                        error:(AlicomFusionEvent *)error {
  NSLog(@"%s，调用:{\n%@}",__func__,error.description);
  if (self->common.DEBUG_MODE) {
    // 1. 快速访问模式
    [self->common showResultMsg: error.mj_keyValues msg:@""];
  } else {
    // 2. 正常访问模式
    self.isActive = NO;
    if (self.reGetTime > 0) {
        NSString *tokenStr = [AlicomFusionAuthTokenManager updateAuthToken];
        AlicomFusionAuthToken *token = [[AlicomFusionAuthToken alloc] initWithTokenStr:tokenStr];
        [handler updateToken:token];
        self.reGetTime --;
    } else {
      self.reGetTime = 3;
      [self destory];
      [AlicomFusionAuthTokenManager shareInstance].authTokenStr = nil;
      return;
    }
  }
}

/**
 *  认证成功
 *  @note 必选回调
 *  @note 可以使用码号效验maskToken去APP Server做最终验证换取真实手机号码，如果换取手机号失败，可以通过SDK的continue接口继续后续场景流程
 *  @param handler handler
 *  @param maskToken 码号效验token
 */
- (void)onVerifySuccess:(AlicomFusionAuthHandler *)handler
               nodeName:(nonnull NSString *)nodeName
              maskToken:(NSString *)maskToken
                  event:(nonnull AlicomFusionEvent *)event {
    
    NSLog(@"%s，调用.nodeName=%@",__func__,nodeName);
  if (self->common.DEBUG_MODE) {
    // 1. 快速访问模式
    // 控制台提醒：
    NSLog(@"获取到认证token:%@, 请到https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/VerifyWithFusionAuthToken 校验结果，Demo默认校验已成功，流程结束，展示默认手机号码18888888888", maskToken);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dealWithPhone:@"18888888888"];
        [AlicomFusionToastTool showToastMsg:@"已获取到最终认证token,快速访问模式下，请到阿里云官网openapi调试 校验结果，Demo默认校验已成功，流程结束，展示为默认手机号码" time:5];
    });
    [self->common showResultMsg: event.mj_keyValues msg:@""];
  } else {
    // 2. 正常访问模式
    // 换手机号
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlicomFusionToastTool showLoading];
    });
    [AlicomFusionNetAdapter verifyTokenRequest:maskToken complete:^(id data,NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [AlicomFusionToastTool hideLoading];
            if (data&&!error){
                //保存手机号
                if ([data isKindOfClass:NSDictionary.class]) {
                    NSString *verifyResult = ((NSDictionary *)data)[@"VerifyResult"];
                    if ([@"PASS" isEqualToString:verifyResult]) {
                        [self dealWithPhone:((NSDictionary *)data)[@"PhoneNumber"]];
                    } else if ([@"REJECT" isEqualToString:verifyResult] || [@"UNKNOW" isEqualToString:verifyResult]) {
                        if ([nodeName isEqualToString:AlicomFusionNodeNameNumberAuth]) {
                            [AlicomFusionToastTool showToastMsg:@"一键登录失败" time:2];
                        } else if ([nodeName isEqualToString:AlicomFusionNodeNameVerifyCodeAuth]) {
                            [AlicomFusionToastTool showToastMsg:@"获取手机号失败，请检查验证码是否正确或是否过期" time:2];
                        } else if ([nodeName isEqualToString:AlicomFusionNodeNameUpGoingAuth]) {
                            [AlicomFusionToastTool showToastMsg:@"获取手机号失败，请检查短信是否发送成功" time:2];
                        }
                        
                        if (![AlicomFusionNodeNameVerifyCodeAuth isEqualToString:nodeName]) {
                            [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
                        }
                    }
                } else {
                    if (![AlicomFusionNodeNameVerifyCodeAuth isEqualToString:nodeName]) {
                        [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
                    }
                }
            }else{
              //结束认证
              [self.handler stopSceneWithTemplateId:self.currTemplateId];
              [AlicomFusionToastTool showToastMsg:error.userInfo[NSLocalizedDescriptionKey] ?:@"操作失败" time:2];
//              [self->common showResultMsg: error.mj_keyValues msg:@""];
              NSLog(@"%s，调用.nodeName=%@",__func__,error);
            }
        });
    }];
  }
}

- (void)onHalfwayVerifySuccess:(AlicomFusionAuthHandler *)handler nodeName:(NSString *)nodeName maskToken:(NSString *)maskToken event:(nonnull AlicomFusionEvent *)event resultBlock:(void (^)(BOOL))resultBlock {
    
  NSLog(@"%s，调用.nodeName=%@",__func__,nodeName);
  if (self->common.DEBUG_MODE) {
    // 1. 快速访问模式
    [self->common showResultMsg: event.mj_keyValues msg:@""];
  } else {
    // 2. 正常访问模式
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlicomFusionToastTool showLoading];
    });
    [AlicomFusionNetAdapter verifyTokenRequest:maskToken complete:^(id data,NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [AlicomFusionToastTool hideLoading];
            if (data&&!error){
                //保存手机号
                if ([data isKindOfClass:NSDictionary.class]) {
                    NSString *verifyResult = ((NSDictionary *)data)[@"VerifyResult"];
                    if ([@"PASS" isEqualToString:verifyResult]) {
                        [AlicomFusionToastTool showToastMsg:@"校验成功" time:2];
                        if (resultBlock) {
                            resultBlock(YES);
                        }
                    } else if ([@"REJECT" isEqualToString:verifyResult] || [@"UNKNOW" isEqualToString:verifyResult]) {
                        [AlicomFusionToastTool showToastMsg:@"校验失败" time:2];
                    }
                } else {
                    [AlicomFusionToastTool showToastMsg:@"校验失败" time:2];
                }
            }else{
                [AlicomFusionToastTool showToastMsg:@"校验失败" time:2];
            }
        });
    }];
  }
}

- (void)onVerifyFailed:(AlicomFusionAuthHandler *)handler nodeName:(nonnull NSString *)nodeName error:(nonnull AlicomFusionEvent *)error {
  [self->common showResultMsg: error.mj_keyValues msg:@""];
  NSLog(@"%s，nodeName=%@,调用:{\n%@}",__func__,nodeName,error.description);
  if ([nodeName isEqualToString:AlicomFusionNodeNameVerifyCodeAuth]) {
      if ([error.resultCode isEqualToString:AlicomFusionVerifyCodeFrequency] || [error.resultCode isEqualToString:AlicomFusionVerifyCodeRisk]) {
          dispatch_async(dispatch_get_main_queue(), ^{
              [AlicomFusionToastTool showToastMsg:error.resultMsg time:2];
          });
          [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
      } else if ([AlicomFusionVerifyCodeAutoNumberShowFail isEqualToString:error.resultCode]) {
          dispatch_async(dispatch_get_main_queue(), ^{
              [AlicomFusionToastTool showToastMsg:error.resultMsg time:2];
          });
          [self.handler stopSceneWithTemplateId:self.currTemplateId];
      } else {
          dispatch_async(dispatch_get_main_queue(), ^{
              [AlicomFusionToastTool showToastMsg:error.resultMsg time:2];
          });
      }
  } else {
      [self.handler continueSceneWithTemplateId:self.currTemplateId isSuccess:NO];
  }
}

/**
 *  认证结束
 *  @note 必选回调，SDK认证流程结束
 *  @param handler handler
 *  @param event 结束事件
 */
- (void)onTemplateFinish:(AlicomFusionAuthHandler *)handler event:(AlicomFusionEvent *)event {
  NSLog(@"%s，调用:{\n%@}",__func__,event.description);
    //结束认证
  [self->common showResultMsg: event.mj_keyValues msg:@""];
  [self.handler stopSceneWithTemplateId:self.currTemplateId];
}

#pragma mark - 协议点击回调操作
- (void)onProtocolClick:(AlicomFusionAuthHandler *)handler protocolName:(NSString *)protocolName protocolUrl:(NSString *)protocolUrl event:(AlicomFusionEvent *)event
{
  NSLog(@"%s，调用:{\n%@}",__func__,event.description);
  [self->common showResultMsg: event.mj_keyValues msg:@""];
  AlicomFusionWebViewController *controller = [[AlicomFusionWebViewController alloc] initWithUrl:protocolUrl andUrlName:protocolName];
  UINavigationController *navigationController = self.currVC.navigationController;
  if (self.currVC.presentedViewController) {
      //如果授权页成功拉起，这个时候则需要使用授权页的导航控制器进行跳转
      navigationController = (UINavigationController *)self.currVC.presentedViewController;
  }
  [navigationController pushViewController:controller animated:YES];
}

#pragma mark - 认证中断
- (void)onVerifyInterrupt:(AlicomFusionAuthHandler *)handler event:(AlicomFusionEvent *)event {
  [self->common showResultMsg: event.mj_keyValues msg:@""];
}

/**
 *  填充手机号，用于校验手机号是否和输入的一致，或者重新绑定手机号场景自动填充手机号
 *  @note 必选回调，SDK内置UI部分手机号
 *  @note 比如重置密码场景，需要先填写原手机号码进行第一步效验，SDK需效验该填写值是否为真实的原手机号码，或者重新绑定手机号场景自动填充手机号
 *  @param handler handler
 *  @param event 事件
 *  @return 返回当前用户正在使用的手机号用于下一步操作
 */
- (NSString *)onGetPhoneNumberForVerification:(AlicomFusionAuthHandler *)handler
                                        event:(nonnull AlicomFusionEvent *)event {
  [self->common showResultMsg: event.mj_keyValues msg:@""];
//  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSString *phoneNum = @"";//[ud objectForKey:kDEMO_UD_PHONE_NUM];
  return phoneNum;
}


- (void)otherPhoneLoginClick {
//    [self.authmodel otherPhoneLogin];
}

#pragma mark - AlicomFusionAuthUIDelegate 一键登录onPhoneNumberVerifyUICustomDefined:templateId:nodeId:UIModel:
- (void)onPhoneNumberVerifyUICustomDefined:(AlicomFusionAuthHandler *)handler
                                templateId:(nonnull NSString *)templateId
                                    nodeId:(NSString *)nodeId
                                   UIModel:(AlicomFusionNumberAuthModel *)model {
  model.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
  model.presentDirection = AlicomFusionPresentationDirectionBottom;
  
  NSDictionary *dict = [FusionAuthCommon shareInstance].CONFIG;
  
  #pragma mark- 状态栏
  NSDictionary *navStatusBar = [dict dictValueForKey: @"navStatusBarConfig" defaultValue: nil];
  if (navStatusBar != nil) {
    model.prefersStatusBarHidden = YES;
    model.preferredStatusBarStyle =UIStatusBarStyleDefault;
  }
  
  #pragma mark- 导航栏
  NSDictionary *nav = [dict dictValueForKey: @"navViewConfig" defaultValue: nil];
  if (nav != nil) {
    model.navTitle = [[NSAttributedString alloc] initWithString: [nav stringValueForKey: @"title" defaultValue: @"一键登录"]];
    model.navColor = [UIColor getColor: [nav stringValueForKey: @"backgroundColor" defaultValue: @"#EFF3F2"]];
  }
  
  #pragma mark- 背景
  NSDictionary *background = [dict dictValueForKey: @"backgroundConfig" defaultValue: nil];
  if (background != nil) {
    model.backgroundColor = [UIColor getColor: [background stringValueForKey: @"backgroundColor" defaultValue: @""]];
    UIImage * backgroundImage = [AlicomFusionUtil changeUriPathToImage: [background stringValueForKey: @"backgroundImage" defaultValue: nil]];
    if (backgroundImage != nil) {
      model.backgroundImage = backgroundImage;
    }
    model.backgroundImageContentMode = [background integerValueForKey: @"backgroundImageContentMode" defaultValue: UIViewContentModeScaleAspectFill];
  }
  
  #pragma mark- 名称部分
  NSDictionary *name = [dict dictValueForKey: @"nameConfig" defaultValue: nil];
  if (name != nil) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TX_SCREEN_WIDTH, 100)];
    label.text = [name stringValueForKey: @"text" defaultValue: @"登录"];
    label.textColor = [UIColor getColor: [name stringValueForKey: @"fontColor" defaultValue: @"#262626"]];
    label.font = [UIFont systemFontOfSize: [name integerValueForKey: @"fontSize" defaultValue: 24]];
    [label sizeToFit];
    model.nameLabel = label;
  }
  
  #pragma mark- logo图片
  NSDictionary *logo = [dict dictValueForKey: @"logoConfig" defaultValue: nil];
  if (logo != nil) {
    model.logoIsHidden = [logo boolValueForKey: @"logoIsHidden" defaultValue: NO];
    UIImage * logoImage = [AlicomFusionUtil changeUriPathToImage: [logo stringValueForKey: @"logoImage" defaultValue: nil]];
    if (logoImage != nil) {
      model.logoImage = logoImage;
    }
    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
      CGFloat y = 318;
      CGRect rect = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
      return rect;
    };
  }

  #pragma mark- slogan
  NSDictionary *slogan = [dict dictValueForKey: @"sloganConfig" defaultValue: nil];
  if (slogan != nil) {
    model.sloganIsHidden = [slogan boolValueForKey: @"sloganIsHidden" defaultValue: NO];
    // slogan 设置
    NSMutableAttributedString *sloganAttr = [
      [NSMutableAttributedString alloc]
      initWithString: [slogan stringValueForKey: @"sloganText" defaultValue: @"阿里云为您提供认证服务"]
      attributes: @{
        NSFontAttributeName: [UIFont systemFontOfSize:[slogan intValueForKey: @"sloganTextSize" defaultValue: 15]],
        NSForegroundColorAttributeName: [UIColor getColor: [slogan stringValueForKey: @"sloganTextColor" defaultValue: @"#555555"]],
      }
    ];
    model.sloganText = sloganAttr;
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat y = 252;
        CGRect rect = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
        return rect;
    };
  }

  #pragma mark- 号码
  NSDictionary *phone = [dict dictValueForKey: @"phoneNumberConfig" defaultValue: nil];
  if (phone != nil) {
    model.numberColor = [UIColor getColor: [phone stringValueForKey: @"numberColor" defaultValue: @"#262626"]];
    model.numberFont = [UIFont systemFontOfSize:[phone intValueForKey: @"numberSize" defaultValue: 16]];
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = (screenSize.width - frame.size.width) * 0.5;
        CGFloat y = 214;
        CGRect rect = CGRectMake(x, y, frame.size.width, frame.size.height);
        return rect;
    };
  }

  #pragma mark- 登录
  NSDictionary *loginButton = [dict dictValueForKey: @"loginButtonConfig" defaultValue: nil];
  if (loginButton != nil) {
    // 登录按钮
    NSMutableAttributedString *loginAttr = [
      [NSMutableAttributedString alloc]
      initWithString:[loginButton stringValueForKey: @"logBtnText" defaultValue: @"一键登录"]
      attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:[loginButton intValueForKey: @"logBtnTextSize" defaultValue: 16]],
        NSForegroundColorAttributeName: [UIColor getColor: [loginButton stringValueForKey: @"logBtnTextColor" defaultValue: @"#555555"]],
      }
    ];
    model.loginBtnText = loginAttr;
    
    UIImage *unSelectImage = [AlicomFusionUtil
        imageWithColor: [UIColor getColor:@"#0064C8"]
                  size: CGSizeMake(TX_SCREEN_WIDTH - 32, 44)
       isRoundedCorner: NO
                radius: 0.0
    ];
    UIImage *selectImage = [AlicomFusionUtil
        imageWithColor: [UIColor getColor:@"#0064C8"]
                  size: CGSizeMake(TX_SCREEN_WIDTH - 32, 44)
       isRoundedCorner: NO
                radius: 0.0
    ];
    UIImage *heighLightImage = [AlicomFusionUtil
        imageWithColor: [UIColor getColor:@"#0064C8"]
                  size: CGSizeMake(TX_SCREEN_WIDTH - 32, 44)
       isRoundedCorner: NO
                radius: 0.0
    ];
    model.loginBtnBgImgs = @[unSelectImage, selectImage, heighLightImage];
    
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat y = 318;
        CGRect rect = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
        return rect;
    };
  }
  
  #pragma mark- 选中框
  NSDictionary *checkBox = [dict dictValueForKey: @"checkBoxConfig" defaultValue: nil];
  if (checkBox != nil) {
    model.checkBoxIsHidden = [checkBox boolValueForKey: @"checkboxHidden" defaultValue: NO];
    model.checkBoxIsChecked = [checkBox boolValueForKey: @"checkBoxIsChecked" defaultValue: NO];
    model.checkBoxWH = [checkBox intValueForKey: @"checkBoxWidth" defaultValue: 21];
    model.checkBoxVerticalCenter = [checkBox boolValueForKey: @"checkBoxVerticalCenter" defaultValue: NO];
    UIImage * uncheckImage = [AlicomFusionUtil changeUriPathToImage: [checkBox stringValueForKey: @"uncheckImage" defaultValue: nil]];
    UIImage * checkedImage = [AlicomFusionUtil changeUriPathToImage: [checkBox stringValueForKey: @"checkedImage" defaultValue: nil]];
    if (uncheckImage != nil && checkedImage != nil) {
      model.checkBoxImages = @[uncheckImage, checkedImage];
    }
  }
  
  #pragma mark- 切换登录部分
  NSDictionary *changeButton = [dict dictValueForKey: @"changeButtonConfig" defaultValue: nil];
  if (changeButton != nil) {
    UIButton *otherLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherLogin setTitle:[dict stringValueForKey: @"changeBtnTitle" defaultValue: @"其他手机号登录"] forState:UIControlStateNormal];
    [otherLogin setTitleColor:[UIColor getColor: [dict stringValueForKey: @"changeBtnTextColor" defaultValue: @"#262626"]] forState:UIControlStateNormal];
    otherLogin.titleLabel.font = [UIFont systemFontOfSize:[dict intValueForKey: @"changeBtnTextSize" defaultValue: 16]];
    [otherLogin addTarget:self action:@selector(otherPhoneLoginClick) forControlEvents:UIControlEventTouchUpInside];
    model.otherLoginButton = otherLogin;
    model.moreLoginActionBlock = ^{
      NSLog(@"其他登录方式");
      NSDictionary *result = @{
        @"resultCode": @"888888",
        @"resultMsg": @"其他登录方式"
      };
      [self->common showResultMsg: result.mj_keyValues msg:@""];
    };
  }
  
  #pragma mark- 协议
  NSDictionary *privacy = [dict dictValueForKey: @"privacyConfig" defaultValue: nil];
  if (privacy != nil) {
    model.privacyOperatorIndex = [privacy intValueForKey: @"privacyOperatorIndex" defaultValue: 2];
    model.privacyOne = @[
      [privacy stringValueForKey: @"privacyOneName" defaultValue: @"用户协议"],
      [privacy stringValueForKey: @"privacyOneUrl" defaultValue: @""]
    ];
    model.privacyTwo = @[
      [privacy stringValueForKey: @"privacyTwoName" defaultValue: @"个人信息保护政策"],
      [privacy stringValueForKey: @"privacyTwoUrl" defaultValue: @""]
    ];
    model.privacyThree = @[
      [privacy stringValueForKey: @"privacyThreeName" defaultValue: @""],
      [privacy stringValueForKey: @"privacyThreeUrl" defaultValue: @""]
    ];
    
    
    model.privacyConectTexts = @[@"、",@" 和 "];
    // 前置文案
    model.privacyPreText = [privacy stringValueForKey: @"privacyPreText" defaultValue: @""];
    // 后置文案
    model.privacySufText = [privacy stringValueForKey: @"privacySufText" defaultValue: @""];
    // 设置运营商协议前缀符号，只能设置一个字符<、(、《、【、『、[、（中的一个
    model.privacyOperatorPreText = [privacy stringValueForKey: @"privacyOperatorPreText" defaultValue: @""];
    // 设置运营商协议后缀符号，只能设置一个字符>、)、》、】、』、]、）中的一个
    model.privacyOperatorSufText = [privacy stringValueForKey: @"privacyOperatorSufText" defaultValue: @""];
    
    model.privacyColors = @[
      [UIColor getColor:@"#262626"],
      [UIColor getColor:@"#262626"]
    ];
    
    // 设置隐私条款文字大小（单位：dp，字体大小不随系统变化）
    model.privacyFont = [UIFont systemFontOfSize:[privacy intValueForKey: @"privacyFontSize" defaultValue: 14]];
    // 运营商协议内容颜色
    model.privacyOperatorColor = [UIColor getColor: [privacy stringValueForKey: @"privacyOperatorColor" defaultValue: @""]];
    // 协议1内容颜色
    model.privacyOneColor = [UIColor getColor: [privacy stringValueForKey: @"privacyOneColor" defaultValue: @""]];
    // 协议2内容颜色
    model.privacyTwoColor = [UIColor getColor: [privacy stringValueForKey: @"privacyTwoColor" defaultValue: @""]];
    // 协议3内容颜色
    model.privacyThreeColor = [UIColor getColor: [privacy stringValueForKey: @"privacyThreeColor" defaultValue: @""]];
    
    model.privacyFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGRect rect = CGRectMake(frame.origin.x, screenSize.height - 60 - frame.size.height - 34, frame.size.width, frame.size.height);
        return rect;
    };
  }

//  CGFloat ratio = MAX(TX_SCREEN_WIDTH, TX_SCREEN_HEIGHT) / 667.0;
//  //实现该block，并且返回的frame的x或y大于0，则认为是弹窗谈起授权页
//  model.contentViewFrameBlock = ^CGRect(CGSize screenSize, CGSize contentSize, CGRect frame) {
//      CGFloat alertX = 0;
//      CGFloat alertY = 0;
//      CGFloat alertWidth = 0;
//      CGFloat alertHeight = 0;
////      if ([self isHorizontal:screenSize]) {
////        alertX = ratio * TX_Alert_Horizontal_Default_Left_Padding;
////        alertWidth = [viewConfig intValueForKey: @"dialogWidth" defaultValue: screenSize.width - alertX * 2];
////        alertY = (screenSize.height - alertWidth * 0.5) * 0.5;
////        alertHeight = [viewConfig intValueForKey: @"dialogHeight" defaultValue: screenSize.height - 2 * alertY];
////      } else {
////        alertWidth = [viewConfig intValueForKey: @"dialogWidth" defaultValue: screenSize.width / 2];
////        alertHeight = [viewConfig intValueForKey: @"dialogHeight" defaultValue: screenSize.height / 2];
////        alertX = [viewConfig intValueForKey: @"dialogOffsetX" defaultValue: (TX_SCREEN_WIDTH - alertWidth) / 2];
////        alertY = [viewConfig intValueForKey: @"dialogOffsetY" defaultValue: (TX_SCREEN_HEIGHT - alertHeight) / 2];
////      }
//      return CGRectMake(alertX, alertY, screenSize.width, screenSize.height);
//  };
  
  model.nameLabelFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
      return frame;
  };
  model.otherLoginButtonFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
      return frame;
  };
    
  model.customViewLayoutBlock = ^(
      CGSize screenSize,        /// 全屏参数
      CGRect contentViewFrame,  /// contentView参数
      CGRect nameLabelFrame,    /// “登录”文字的布局
      CGRect otherLoginBtnFrame,
      CGRect navFrame,          /// 导航参数
      CGRect titleBarFrame,     /// title参数
      CGRect logoFrame,         /// logo区域参数
      CGRect sloganFrame,       /// slogan参数
      CGRect numberFrame,       /// 号码处参数
      CGRect loginFrame,        /// 登录按钮处的参数
      CGRect changeBtnFrame,    /// 切换到其他的参数
      CGRect privacyFrame       /// 协议区域的参数
  ) {
      
  };
  model.customViewBlock = ^(UIView * _Nonnull superCustomView) {};
    
  #pragma mark - 二次隐私协议弹窗设置
  NSDictionary *privacyAlert = [dict dictValueForKey: @"privacyAlertConfig" defaultValue: nil];
  if (privacyAlert != nil) {
    model.privacyAlertIsNeedShow = [privacyAlert boolValueForKey: @"privacyAlertIsNeedShow" defaultValue: YES];
    model.privacyAlertIsNeedAutoLogin = [privacyAlert boolValueForKey: @"privacyAlertIsNeedAutoLogin" defaultValue: YES];
    model.privacyAlertCornerRadiusArray = [privacyAlert arrayValueForKey: @"privacyAlertCornerRadiusArray" defaultValue: @[@4, @4, @4, @4]];
    model.privacyAlertTitleFont = [UIFont systemFontOfSize:[privacyAlert intValueForKey: @"privacyAlertTitleTextSize" defaultValue: 16]];
    model.privacyAlertTitleColor = [UIColor getColor: [privacyAlert stringValueForKey: @"privacyAlertTitleColor" defaultValue: @"#262626"]];
    model.privacyAlertContentFont = [UIFont systemFontOfSize:[privacyAlert intValueForKey: @"privacyAlertContentTextSize" defaultValue: 16]];
    model.privacyAlertContentAlignment = NSTextAlignmentCenter;
    
    model.privacyAlertButtonTextColors = @[
      [UIColor getColor:@"#0064C8"],
      [UIColor getColor:@"#0064C8"]
    ];
    
    UIImage *imageUnselect = [AlicomFusionUtil
        imageWithColor: [UIColor getColor:@"#FFFFFF"]
                  size:CGSizeMake(TX_SCREEN_WIDTH, 56)
       isRoundedCorner: NO
                radius: 0.0
    ];
    UIImage *imageSelect = [AlicomFusionUtil
        imageWithColor: [UIColor getColor:@"#FFFFFF"]
                  size: CGSizeMake(TX_SCREEN_WIDTH, 56)
       isRoundedCorner: NO
                radius: 0.0
    ];
    model.privacyAlertBtnBackgroundImages = @[imageUnselect, imageSelect];
    
    model.privacyAlertButtonFont = [UIFont systemFontOfSize:[privacyAlert intValueForKey: @"privacyAlertBtnTextSize" defaultValue: 16]];
    model.tapPrivacyAlertMaskCloseAlert = [privacyAlert boolValueForKey: @"tapPrivacyAlertMaskCloseAlert" defaultValue: NO];
    model.privacyAlertMaskColor = [UIColor getColor: [privacyAlert stringValueForKey: @"switchAccTextColor" defaultValue: @"#262626"]];
    model.privacyAlertMaskAlpha = [privacyAlert floatValueForKey: @"privacyAlertMaskAlpha" defaultValue: 0.88];
    
    model.privacyAlertFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGRect rect = CGRectMake(27, (superViewSize.height - 200)*0.382, superViewSize.width - 54, 200);
        return rect;
    };
    
    model.privacyAlertTitleFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGRect rect = CGRectMake(0, 32, frame.size.width, frame.size.height);
        return rect;
    };
    
    model.privacyAlertPrivacyContentFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGRect rect = CGRectMake(24, 70, superViewSize.width - 48, frame.size.height);
        return rect;
    };
    
    model.privacyAlertButtonFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGRect rect = CGRectMake(0, superViewSize.height - 56, superViewSize.width, 56);
        return rect;
    };
  }
}

// 短信验证码onSMSCodeVerifyUICustomDefined:templateId:nodeId:isAutoInput:view:
- (void)onSMSCodeVerifyUICustomDefined:(AlicomFusionAuthHandler *)handler
                            templateId:(nonnull NSString *)templateId
                                nodeId:(NSString *)nodeId
                           isAutoInput:(BOOL)isAutoInput
                                  view:(AlicomFusionVerifyCodeView *)view {
  NSDictionary *dict = [self->common.CONFIG dictValueForKey: @"smsViewConfig" defaultValue: @{}];
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
  label.text = @"登录";
//  label.textColor = AlicomColorHex(0x262626);
//  label.font = [UIFont systemFontOfSize:24];
//  [label sizeToFit];
//  model.nameLabel = label;
//  view.phoneNumLabel =
  UIButton *verifyCodeSendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
  verifyCodeSendBtn.backgroundColor = [UIColor getColor: @"#00ff00"];
  view.verifyCodeSendBtn = verifyCodeSendBtn;
//  view.verifyCodeSendView.frame =CGRectMake(0, 0, TX_SCREEN_WIDTH, TX_SCREEN_HEIGHT);
  view.verifyCodeSendView.backgroundColor =[UIColor getColor: @"#00ff00"];
//  view.frame =CGRectMake(0, 0, TX_SCREEN_WIDTH, TX_SCREEN_HEIGHT);
  self.verifyView = view;
}

// 用户主动发短信onSMSSendVerifyUICustomDefined:templateId:nodeId:smsContent:receiveNum:view:
- (void)onSMSSendVerifyUICustomDefined:(AlicomFusionAuthHandler *)handler
                            templateId:(nonnull NSString *)templateId
                                nodeId:(NSString *)nodeId
                            smsContent:(nonnull NSString *)smsContent
                            receiveNum:(nonnull NSString *)receiveNum
                                  view:(AlicomFusionUpGoingView *)view {
  NSDictionary *dict = [self->common.CONFIG dictValueForKey: @"smsSendViewConfig" defaultValue: @{}];
  self.upGoingView = view;
  self.smsContent = smsContent;
  self.receiveNum = receiveNum;
  NSLog(@"smsContent-====%@,receiveNum=-------%@",smsContent,receiveNum);
}

// 导航栏：onNavigationControllerCustomDefined:templateId:nodeId:navigation:
- (void)onNavigationControllerCustomDefined:(AlicomFusionAuthHandler *)handler
                                 templateId:(nonnull NSString *)templateId
                                     nodeId:(NSString *)nodeId
                                 navigation:(UINavigationController *)naviController {
  // 配置参数
  NSDictionary *dict = [self->common.CONFIG dictValueForKey: @"navConfig" defaultValue: @{}];
  // 判断是否有字段
  if ([dict count] == 0) {
    naviController.navigationBar.hidden = [dict boolValueForKey: @"isHidden" defaultValue: NO];
    // 导航整体背景色
    naviController.navigationBar.backgroundColor = [UIColor getColor: [dict stringValueForKey: @"backgroundColor" defaultValue: @"#ffffff"]];
    // 文字的设置
    naviController.navigationBar.titleTextAttributes = @{
      // 文字大小
      NSFontAttributeName: [UIFont systemFontOfSize: [dict intValueForKey: @"textFontSize" defaultValue: 12]],
      // 文字颜色
      NSForegroundColorAttributeName: [UIColor getColor: [dict stringValueForKey: @"textForegroundColor" defaultValue: @"#000000"]],
      // 文字背景色
      NSBackgroundColorAttributeName: [UIColor getColor: [dict stringValueForKey: @"textBackgroundColor" defaultValue: @"#ffffff"]],
      // 文字间距
      NSKernAttributeName: [dict numberValueForKey: @"textKern" defaultValue: @0]
    };
  }
  naviController.parentViewController.modalPresentationStyle = UIModalPresentationFullScreen;
}


/// 是否是横屏 YES:横屏 NO:竖屏
- (BOOL)isHorizontal:(CGSize)size {
    return size.width > size.height;
}

@end

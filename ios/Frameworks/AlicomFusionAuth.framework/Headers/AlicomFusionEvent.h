//
//  AlicomFusionEvent.h
//  AlicomFusionAuthSDK
//
//  Created by lyz on 2023/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// @note 所有的错误码均会回调event事件，未说明的只会回调event
#pragma mark - 场景相关
//场景不存在
static NSString * const AlicomFusionTemplateNotExist = @"100001";
//场景还未开始
static NSString * const AlicomFusionTemplateNotStart = @"100002";
//上一个场景还未退出
static NSString * const AlicomFusionTemplateNotEnd = @"100003";
//场景结束，callbackTemplateFinish
static NSString * const AlicomFusionTemplateEnd = @"100004";
//场景成功结束
static NSString * const AlicomFusionTemplateEndSuccess = @"110005";

#pragma mark - 节点流程事件
//查找下一个节点失败，callbackTemplateFinish
static NSString * const AlicomFusionAuthNextNodeFail = @"200001";
//查找下一个节点成功
static NSString * const AlicomFusionAuthNextNodeSuccess = @"200002";
//当前节点任务还未结束，不允许继续操作
static NSString * const AlicomFusionAuthCurrentNodeNotComplete = @"200003";


#pragma mark - token相关
//token正在鉴权，callbackTokenVerifySuccess
static NSString * const AlicomFusionTokenIsVerifying = @"300001";
//token鉴权合法
static NSString * const AlicomFusionTokenValid = @"300002";
//token鉴权不合法，callbackTokenVerifyFailed
static NSString * const AlicomFusionTokenInvalid = @"300003";
//token获取超时，默认60s，callbackTokenVerifyFailed
static NSString * const AlicomFusionTokenUpdateTimeout = @"300004";
//token解析失败，callbackTokenVerifyFailed
static NSString * const AlicomFusionTokenAnalyseFail = @"300005";
//token鉴权失败，callbackTokenVerifyFailed
static NSString * const AlicomFusionTokenVerifyFail = @"300006";

#pragma mark - 一键登录相关
//一键登录初始化成功
static NSString * const AlicomFusionNumberAuthInitSuccess = @"400001";
//一键登录初始化失败，callbackVerifyFailed
static NSString * const AlicomFusionNumberAuthInitFail = @"400002";
//一键登录弹起授权页成功
static NSString * const AlicomFusionNumberAuthPresentSuccess = @"400003";
//一键登录弹起授权页失败，callbackVerifyFailed
static NSString * const AlicomFusionNumberAuthPresentFail = @"400004";
//一键登录弹起授权页取消，如果是场景结束或者点击返回按钮则callbackTemplateFinish
static NSString * const AlicomFusionNumberAuthDisMiss = @"400005";
//一键登录获取token成功，callbackVerifySuccess
static NSString * const AlicomFusionNumberAuthGetTokenSuccess = @"400006";
//一键登录获取token失败，callbackVerifyFailed
static NSString * const AlicomFusionNumberAuthGetTokenFail = @"400007";
//一键登录获取页面各种点击事件
static NSString * const AlicomFusionNumberAuthGetTokenEvent = @"410008";
//一键登录获取页面其他手机号登录按钮点击事件
static NSString * const AlicomFusionNumberAuthOtherPhoneLoginClickEvent = @"410009";
//一键登录点击返回按钮
static NSString * const AlicomFusionNumberAuthBackBtnClickEvent = @"410010";
//一键登录授权页点击协议，callbackProtocolClick
static NSString * const AlicomFusionNumberAuthProtocolClickEvent = @"410011";
//一键登录录授权页二次弹窗点击协议，callbackProtocolClick
static NSString * const AlicomFusionNumberAuthAlertProtocolClickEvent = @"410012";

#pragma mark - 短信验证码相关
//短信验证码初始化成功
static NSString * const AlicomFusionVerifyCodeInitSuccess = @"500001";
//短信验证码初始化失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeInitFail = @"500002";
//获取当前登录手机号
static NSString * const AlicomFusionVerifyCodeVerifyGetPhoneNum = @"500003";
//短信验证码自动填充手机号失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeAutoNumberShowFail = @"500004";
//短信VC弹起成功
static NSString * const AlicomFusionVerifyCodeShowSuccess = @"500005";
//短信VC弹起失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeShowFail = @"500006";
//验证码发送成功
static NSString * const AlicomFusionVerifyCodeGetSuccess = @"500007";
//验证码发送失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeGetFail = @"500008";
//验证码发送被限流，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeFrequency = @"500009";
//获取验证码的手机号存在风险，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeRisk = @"500010";
//验证码获取校验本手机号是否一致的token成功，callbackVerifySuccess
static NSString * const AlicomFusionVerifyCodeVerifyPhoneGetTokenSuccess = @"500011";
//验证码获取校验本手机号是否一致的token失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeVerifyPhoneGetTokenFail = @"500012";
//验证码获取token成功，callbackVerifySuccess
static NSString * const AlicomFusionVerifyCodeGetTokenSuccess = @"500013";
//验证码获取token失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeGetTokenFail = @"500014";
//手机号一致性校验失败，callbackVerifyFailed
static NSString * const AlicomFusionVerifyCodeAccuracyFail = @"500015";
//验证码页面取消，如果是场景结束或者点击返回按钮则callbackTemplateFinish
static NSString * const AlicomFusionVerifyCodeDisMiss = @"510001";
//获取验证码点击事件
static NSString * const AlicomFusionVerifyCodeSendClickEvent = @"510002";
//提交验证码点击事件
static NSString * const AlicomFusionVerifyCodeSubmitClickEvent = @"510003";
//返回按钮点击事件
static NSString * const AlicomFusionVerifyCodeBackClickEvent = @"510004";
//checkBox点击事件
static NSString * const AlicomFusionVerifyCodeCheckBoxClickEvent = @"510005";
//点击协议事件，callbackProtocolClick
static NSString * const AlicomFusionVerifyCodeProtocolClickEvent = @"510006";


#pragma mark - 上行短信验证
//上行短信验证验证码初始化成功
static NSString * const AlicomFusionUpGoingInitSuccess = @"600001";
//上行短信验证验证码初始化失败，callbackVerifyFailed
static NSString * const AlicomFusionUpGoingInitFail = @"600002";
//上行短信页面弹起成功
static NSString * const AlicomFusionUpGoingShowSuccess = @"600003";
//上行短信页面弹起失败，callbackVerifyFailed
static NSString * const AlicomFusionUpGoingShowFail = @"600004";
//上行短信验证发送成功
static NSString * const AlicomFusionUpGoingSendSuccess = @"600005";
//上行短信验证发送失败，callbackVerifyFailed
static NSString * const AlicomFusionUpGoingSendFail = @"600006";
//上行短信获取token成功，callbackVerifySuccess
static NSString * const AlicomFusionUpGoingGetTokenSuccess = @"600007";
//上行短信获取token失败，callbackVerifyFailed
static NSString * const AlicomFusionUpGoingGetTokenFail = @"600008";
//上行短信页面取消，如果是场景结束或者点击返回按钮则callbackTemplateFinish
static NSString * const AlicomFusionUpGoingDisMiss = @"610001";
//上行短信发送按钮点击
static NSString * const AlicomFusionUpGoingSendClickEvent = @"610002";
//上行短信验证已发送按钮点击
static NSString * const AlicomFusionUpGoingAlreadySendClickEvent = @"610003";
//上行短信返回按钮点击
static NSString * const AlicomFusionUpGoingBackClickEvent = @"610004";

#pragma mark - 端风险检测
//端风险检测安全
static NSString * const AlicomFusionDeviceSecurityDetectionSafe = @"700001";
//端风险检测存在风险
static NSString * const AlicomFusionDeviceSecurityDetectionFrequency = @"700002";
//端风险检测限流
static NSString * const AlicomFusionDeviceSecurityDetectionRisk = @"700003";
//端风险检测失败
static NSString * const AlicomFusionDeviceSecurityDetectionGetFail = @"700004";

#pragma mark - 网络相关
//网络连接失败
static NSString * const AlicomFusionErrorNoNetwork = @"800001";
//SDK内部网络请求超时，暂时不支持
static NSString * const AlicomFusionErrorNetworkTimeout = @"800002";
//网络连接成功
static NSString * const AlicomFusionNetworkConnected = @"800003";

#pragma mark - 其他
//SDK内部接口超时
static NSString * const AlicomFusionErrorSDKInnerTimeout = @"900001";
//方案号为空
static NSString * const AlicomFusionErrorSchemeCodeEmpty = @"900002";
//开始加载
static NSString * const AlicomFusionStartLoading = @"900003";
//结束加载
static NSString * const AlicomFusionEndLoading = @"900004";

#pragma mark - 一键登录内部错误码，请注意1600011及1600012错误内均含有运营商返回码，具体错误在碰到之后查阅 https://help.aliyun.com/document_detail/85351.html?spm=a2c4g.11186623.6.561.32a7360cxvWk6H
/// 接口成功
static NSString * const AlicomFusionNumberAuthInnerCodeSuccess = @"1600000";
/// 获取运营商配置信息失败
static NSString * const AlicomFusionNumberAuthInnerCodeGetOperatorInfoFailed = @"1600004";
/// 未检测到sim卡
static NSString * const AlicomFusionNumberAuthInnerCodeNoSIMCard = @"1600007";
/// 蜂窝网络未开启或不稳定
static NSString * const AlicomFusionNumberAuthInnerCodeNoCellularNetwork = @"1600008";
/// 无法判运营商
static NSString * const AlicomFusionNumberAuthInnerCodeUnknownOperator = @"1600009";
/// 未知异常
static NSString * const AlicomFusionNumberAuthInnerCodeUnknownError = @"1600010";
/// 获取token失败
static NSString * const AlicomFusionNumberAuthInnerCodeGetTokenFailed = @"1600011";
/// 预取号失败
static NSString * const AlicomFusionNumberAuthInnerCodeGetMaskPhoneFailed = @"1600012";
/// 运营商维护升级，该功能不可用
static NSString * const AlicomFusionNumberAuthInnerCodeInterfaceDemoted = @"1600013";
/// 运营商维护升级，该功能已达最大调用次数
static NSString * const AlicomFusionNumberAuthInnerCodeInterfaceLimited = @"1600014";
/// 接口超时
static NSString * const AlicomFusionNumberAuthInnerCodeInterfaceTimeout = @"1600015";
/// AppID、Appkey解析失败
static NSString * const AlicomFusionNumberAuthInnerCodeDecodeAppInfoFailed = @"1600017";
/// 运营商已切换
static NSString * const AlicomFusionNumberAuthInnerCodeCarrierChanged = @"1600021";
/// 终端环境检测失败（终端不支持认证 / 终端检测参数错误）
static NSString * const AlicomFusionNumberAuthInnerCodeEnvCheckFail = @"1600025";

/*************** 号码认证授权页相关返回码 START ***************/

/// 唤起授权页成功
static NSString * const AlicomFusionNumberAuthCodeLoginControllerPresentSuccess = @"1600001";
/// 唤起授权页失败
static NSString * const AlicomFusionNumberAuthCodeLoginControllerPresentFailed = @"1600002";
/// 授权页已加载时不允许调用加速或预取号接口
static NSString * const AlicomFusionNumberAuthCodeCallPreLoginInAuthPage = @"1600026";
/// 点击返回，⽤户取消一键登录
static NSString * const AlicomFusionNumberAuthCodeLoginControllerClickCancel = @"1700000";
/// 点击切换按钮，⽤户取消免密登录
static NSString * const AlicomFusionNumberAuthCodeLoginControllerClickChangeBtn = @"1700001";
/// 点击登录按钮事件
static NSString * const AlicomFusionNumberAuthCodeLoginControllerClickLoginBtn = @"1700002";
/// 点击CheckBox事件
static NSString * const AlicomFusionNumberAuthCodeLoginControllerClickCheckBoxBtn = @"1700003";
/// 点击协议富文本文字
static NSString * const AlicomFusionNumberAuthCodeLoginControllerClickProtocol = @"1700004";

/*************** 号码认证授权页相关返回码 FINISH ***************/


/*************** 二次授权页返回code码 START ***************/

/// 点击一键登录拉起授权页二次弹窗
static NSString * const AlicomFusionNumberAuthCodeLoginClickPrivacyAlertView = @"1700006";
/// 隐私协议二次弹窗关闭
static NSString * const AlicomFusionNumberAuthCodeLoginPrivacyAlertViewClose = @"1700007";
/// 隐私协议二次弹窗点击确认并继续
static NSString * const AlicomFusionNumberAuthCodeLoginPrivacyAlertViewClickContinue = @"1700008";
/// 点击隐私协议二次弹窗上的协议富文本文字
static NSString * const AlicomFusionNumberAuthCodeLoginPrivacyAlertViewPrivacyContentClick = @"1700009";

/*************** 二次授权页返回code码 FINISH ***************/


#pragma mark - Event封装类
/* event 封装 */
@interface AlicomFusionEvent : NSObject
// 模板id
@property (nonatomic, copy, readonly) NSString *templateId;
// 节点id
@property (nonatomic, copy, readonly) NSString *nodeId;
// 返回码
@property (nonatomic, copy, readonly) NSString *resultCode;
// 描述
@property (nonatomic, copy, readonly) NSString *resultMsg;
// 内部返回码，目前只针对一键登录才有
@property (nonatomic, copy, readonly) NSString *innerCode;
// 内部返回信息，目前只针对一键登录才有
@property (nonatomic, copy, readonly) NSString *innerMsg;
// 内部运营商错误信息，目前只针对一键登录才有
@property (nonatomic, strong, readonly) id carrierFailedResultData;
// 内部子sdk请求id
@property (nonatomic, copy, readonly) NSString *innerRequestId;
// 请求id
@property (nonatomic, copy, readonly) NSString *requestId;

// 拓展字段，其他一些参数，比如checkbox是否选中等
@property (nonatomic, strong, readonly) NSDictionary *extendData;

@end

NS_ASSUME_NONNULL_END

//
//  AlicomFusionAuthCallback.h
//  AlicomFusionAuthSDK
//
//  Created by shenchao12344 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AlicomFusionAuthHandler,
AlicomFusionEvent,
AlicomFusionVerifyCodeView,
AlicomFusionUpGoingView,
AlicomFusionNumberAuthModel,
AlicomFusionAuthToken;

//一键登录
static NSString * const AlicomFusionNodeNameNumberAuth = @"AlicomFusionNodeNameNumberAuth";
//短信验证码
static NSString * const AlicomFusionNodeNameVerifyCodeAuth = @"AlicomFusionNodeNameVerifyCodeAuth";
//上行短信
static NSString * const AlicomFusionNodeNameUpGoingAuth = @"AlicomFusionNodeNameUpGoingAuth";


/* SDK业务核心回调 */
@protocol AlicomFusionAuthDelegate <NSObject>

@required
/**
 *  token需要更新
 *  @note 必选回调，handler 初始化&历史token过期前5分钟，会触发此回调，由SDK维护token的生命周期
 *  @param handler handler
 *  @return token，APP更新最新token后，给到SDK，SDK会通过此token进行鉴权更新
 */
- (AlicomFusionAuthToken *)onSDKTokenUpdate:(AlicomFusionAuthHandler *)handler;

/**
 *  token鉴权成功
 *  @note 必选回调，token鉴权成功后，才可以使用startScene接口拉起场景
 *  @note 不建议在本回调中直接调用startScene接口，本回调跟随token鉴权事件触发，可能存在多次回调
 *  @param handler handler
 */
- (void)onSDKTokenAuthSuccess:(AlicomFusionAuthHandler *)handler;

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
                        error:(AlicomFusionEvent *)error;

/**
 *  认证成功
 *  @note 必选回调
 *  @note 可以使用码号效验maskToken去APP Server做最终验证换取真实手机号码，如果换取手机号失败，可以通过SDK的continue接口继续后续场景流程
 *  @param handler handler
 *  @param nodeName 获取token的节点名称
 *  @param maskToken 码号效验token
 */
- (void)onVerifySuccess:(AlicomFusionAuthHandler *)handler
               nodeName:(NSString *)nodeName
              maskToken:(NSString *)maskToken
                  event:(AlicomFusionEvent *)event;


/**
 *  中途认证节点，需要知道中途认证结果，否则影响流程继续执行，目前只有更换手机号的时候第一次验证码会回调
 *  @note 必选回调
 *  @note 可以使用码号效验maskToken去APP Server做最终验证换取真实手机号码，通过resultBlock告知SDK验证结果，如果失败则SDK不进行任何操作，成功则进入下一个节点
 *  @param handler handler
 *  @param nodeName 获取token的节点名称
 *  @param maskToken 码号效验token
 *  @param resultBlock 告知SDK校验结果
 */
- (void)onHalfwayVerifySuccess:(AlicomFusionAuthHandler *)handler
                      nodeName:(NSString *)nodeName
                     maskToken:(NSString *)maskToken
                         event:(AlicomFusionEvent *)event
                   resultBlock:(void (^)(BOOL))resultBlock;

/**
 *  认证失败
 *  @note 必选回调
 *  @note 当接收到这个回调的时候表示在场景的某个节点出现了获取token失败的情况，业务方可以根据实际情况决定是否需要执行下一个节点
 *  @param handler handler
 *  @param nodeName 获取token的节点名称
 *  @param error 错误
 */
- (void)onVerifyFailed:(AlicomFusionAuthHandler *)handler
              nodeName:(NSString *)nodeName
                 error:(AlicomFusionEvent *)error;

/**
 *  场景流程结束
 *  @note 必选回调，SDK当前场景流程结束，场景正常结束和异常结束均会触发此回调
 *  @param handler handler
 *  @param event 结束事件
 */
- (void)onTemplateFinish:(AlicomFusionAuthHandler *)handler
                   event:(AlicomFusionEvent *)event;

/**
 *  填充手机号，用于校验手机号是否和输入的一致，或者重新绑定手机号场景自动填充手机号
 *  @note 必选回调，SDK内置UI部分手机号
 *  @note 比如重置密码场景，需要先填写原手机号码进行第一步效验，SDK需效验该填写值是否为真实的原手机号码，或者重新绑定手机号场景自动填充手机号
 *  @param handler handler
 *  @param event 事件
 *  @return 返回当前用户正在使用的手机号用于下一步操作
 */
- (NSString *)onGetPhoneNumberForVerification:(AlicomFusionAuthHandler *)handler
                                        event:(AlicomFusionEvent *)event;

/**
 *  点击协议富文本，返回协议标题以及协议URL，外部需要自定义容器打开该协议
 *  @note 必选回调，SDK协议详情页
 *  @note 一键登录的协议点击，短信验证码的协议点击
 *  @param handler handler
 *  @param protocolName 协议名称
 *  @param protocolUrl 协议URL
 *  @param event 事件
 */
- (void)onProtocolClick:(AlicomFusionAuthHandler *)handler
           protocolName:(NSString *)protocolName
            protocolUrl:(NSString *)protocolUrl
                  event:(AlicomFusionEvent *)event;

/**
 *  认证中断
 *  @note 必选回调
 *  @note 认证流程临时中断，APP可根据不同事件显示对应的提示信息
 *  @note 触发条件：1. 未勾选隐私协议框，进行认证；2. 验证手机号码输入格式错误，3sdk开始加载某个节点和结束加载某个节点，4、相关的接口可用校验
 *  @param handler handler
 *  @param event 中断原因
 */
- (void)onVerifyInterrupt:(AlicomFusionAuthHandler *)handler
                    event:(AlicomFusionEvent *)event;

@optional
/**
 *  场景事件回调
 *  @note 可选回调，包括SDK内所有event通知，例如场景流程中各个界面点击事件、界面跳转事件、错误事件等等
 *  @note 本回调接口仅做事件通知，不可再此回调内处理业务逻辑
 *  @param handler handler
 *  @param event 点击事件，具体定义参考AlicomFusionEvent.h
 */
- (void)onAuthEvent:(AlicomFusionAuthHandler *)handler
          eventData:(AlicomFusionEvent *)event;
@end



/* UI自定义回调 */
@protocol AlicomFusionAuthUIDelegate <NSObject>
/**
 *  此回调内接口全部为可选接口，不实现的情况下使用SDK内置默认UI页面
 *  nodeId对应融合认证各个场景中的节点id，请通过控制台查看，用户可根据ID修改不同节点的UI界面
 *  当前Delegate的回调接口全部在主线程执行
 */
@optional

/**
 *  一键登录自定义UI
 *  @note 自定义一键登录相关UI界面，一键登录界面不可100%完全自定义，请通过AlicomFusionNumberAuthModel参数进行修改
 *  @param handler handler
 *  @param templateId 模版id
 *  @param nodeId 节点ID
 *  @param model 自定义UI属性
 */
- (void)onPhoneNumberVerifyUICustomDefined:(AlicomFusionAuthHandler *)handler
                                templateId:(NSString *)templateId
                                    nodeId:(NSString *)nodeId
                                   UIModel:(AlicomFusionNumberAuthModel *)model;

/**
 *  短信验证码认证自定义UI
 *  @note 短信验证码界面相关UI修改
 *  @param handler handler
 *  @param templateId 模版id
 *  @param nodeId 节点ID
 *  @param isAutoInput 手机号是否是自动填充
 *  @param view 短信验证码界面view
 */
- (void)onSMSCodeVerifyUICustomDefined:(AlicomFusionAuthHandler *)handler
                            templateId:(NSString *)templateId
                                nodeId:(NSString *)nodeId
                           isAutoInput:(BOOL)isAutoInput
                                  view:(AlicomFusionVerifyCodeView *)view;

/**
 *  上行短信认证自定义UI
 *  @note 上行短信认证界面相关UI修改
 *  @param handler handler
 *  @param templateId 模版id
 *  @param nodeId 节点ID
 *  @param smsContent 短信内容
 *  @param receiveNum 接收号码
 *  @param view 上行短信认证界面view
 */
- (void)onSMSSendVerifyUICustomDefined:(AlicomFusionAuthHandler *)handler
                            templateId:(NSString *)templateId
                                nodeId:(NSString *)nodeId
                            smsContent:(NSString *)smsContent
                            receiveNum:(NSString *)receiveNum
                                  view:(AlicomFusionUpGoingView *)view;

/**
 *  navigationController自定义UI
 *  @note iOS特有
 *  @param handler handler
 *  @param templateId 模版id
 *  @param nodeId 节点ID
 *  @param naviController navigationController
 */
- (void)onNavigationControllerCustomDefined:(AlicomFusionAuthHandler *)handler
                                 templateId:(NSString *)templateId
                                     nodeId:(NSString *)nodeId
                                 navigation:(UINavigationController *)naviController;

@end

NS_ASSUME_NONNULL_END


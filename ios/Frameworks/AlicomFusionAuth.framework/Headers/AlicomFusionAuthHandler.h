//
//  AlicomFusionAuthHandler.h
//  AlicomFusionAuthSDK
//
//  Created by shenchao12344 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "AlicomFusionAuthCallback.h"
#import "AlicomFusionEvent.h"
#import "AlicomFusionAuthToken.h"

NS_ASSUME_NONNULL_BEGIN

/* 默认登录注册场景 */
static NSString * const AlicomFusionTemplateId_100001 = @"100001";
/* 默认更换手机号场景 */
static NSString * const AlicomFusionTemplateId_100002 = @"100002";
/* 默认重置密码场景 */
static NSString * const AlicomFusionTemplateId_100003 = @"100003";
/* 默认绑定新手机号场景 */
static NSString * const AlicomFusionTemplateId_100004 = @"100004";
/* 默认验证绑定手机号场景 */
static NSString * const AlicomFusionTemplateId_100005 = @"100005";


/* 核心接口 */
@interface AlicomFusionAuthHandler : NSObject

/**
 *  获取SDK版本号
 *  @return  版本号
 */
+ (NSString *)getSDKVersion;

/**
 *  设置是否使用SDK关联友盟统计组件
 *  @note SDK默认使用融合认证关联友盟组件，如果您当前APP未集成友盟组件，根据SDK集成文档接入各个SDK后，无需再关心此接口设置
 *  @note 如果您当前已经集成过友盟组件，则无需重复集成，使用此接口关闭内置链接，并确保使用本SDK前已经完成友盟组件初始化
 *  @param isUseSupply YES:使用SDK默认关联友盟组件  NO:不使用SDK关联友盟组件，即使用APP原有友盟组件，默认YES
 */

+ (void)useSDKSupplyUMSDK:(BOOL)isUseSupply;


- (instancetype)init NS_UNAVAILABLE;


/**
 *  初始化，传入鉴权token
 *  @note 由APP维护token的生命周期，可以提升SDK中token处理效率，快速拉起场景页面
 *  @param token 鉴权token
 *  @param schemeCode 方案号
 */
- (instancetype)initWithToken:(AlicomFusionAuthToken *)token schemeCode:(NSString *)schemeCode;

/**
 *  主动更新鉴权token
 *  @param token 鉴权token
 *  @note 鉴权token具有时效性，APP可再Token即将过期时，主动向SDK更新token
 *  @note 非必要接口 : SDK内部存在token的过期监控，过期前会通过AlicomFusionAuthDelegate回调通知APP，APP可不感知此项逻辑
 */
- (void)updateToken:(AlicomFusionAuthToken *)token;

/**
 *  设置回调
 *  @param delegate SDK核心回调
 */
- (void)setFusionAuthDelegate:(id<AlicomFusionAuthDelegate>)delegate;

/**
 *  销毁服务
 *  @note 销毁服务后，SDK内部各个模块同步销毁，若想继续使用SDK，请重新初始化
 */
- (void)destroy;

/**
 *  开始拉起场景，使用SDK内置UI
 *  @param templateId 场景唯一标识 与控制台场景ID唯一对应
 *  @param controller 基础页面，SDK将从该页面弹出融合认证相关页面
 */
- (void)startSceneWithTemplateId:(NSString *)templateId viewController:(UIViewController *)controller;

/**
 *  开始拉起场景，使用APP自定义UI
 *  @param templateId 场景唯一标识 与控制台场景ID唯一对应
 *  @param controller 基础页面，SDK将从该页面弹出融合认证相关UI界面
 *  @param delegate UI回调，自定义UI需通过该回调实现
 */
- (void)startSceneUIWithTemplateId:(NSString *)templateId
                    viewController:(UIViewController *)controller
                          delegate:(id<AlicomFusionAuthUIDelegate> _Nullable)delegate;

/**
 *  继续场景
 *  @param templateId 场景唯一标识 与控制台场景ID唯一对应
 *  @param isSuccess 当前场景验证是否成功，成功与否决定继续场景后的业务流程走向
 *  @note 该接口用于场景中断后恢复流程，如获取到码号效验token后，假设服务端效验失败，可以通过该接口继续进行场景流程
 */
- (void)continueSceneWithTemplateId:(NSString *)templateId isSuccess:(BOOL)isSuccess;

/**
 *  结束场景
 *  @param templateId 场景唯一标识 与控制台场景ID唯一对应
 *  @note 随时调用，随时停止，与start接口对应，结束后才可以start下一次场景，不可同时start多个场景
 */
- (void)stopSceneWithTemplateId:(NSString *)templateId;

/**
 *  获取当前正在运行中的场景Id
 *  @return templateId 场景唯一标识 与控制台场景ID唯一对应
 */
- (NSString *)getCurrentTemplateId;

/**
 *  主动关闭一键登录二次授权页弹窗
 */
- (void)closeNumberAuthPrivactAlertView;

@end

NS_ASSUME_NONNULL_END

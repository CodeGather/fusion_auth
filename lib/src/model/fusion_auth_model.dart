import 'package:fusion_auth/src/model/view_nav_model.dart';
import 'package:json_annotation/json_annotation.dart';

import './fusion_auth_enum.dart';

part 'fusion_auth_model.g.dart';

///一键登录onPhoneNumberVerifyUICustomDefined:templateId:nodeId:UIModel:
/// 短信验证码onSMSCodeVerifyUICustomDefined:templateId:nodeId:isAutoInput:view:
/// 用户主动发短信onSMSSendVerifyUICustomDefined:templateId:nodeId:smsContent:receiveNum:view:
/// 导航栏：onNavigationControllerCustomDefined:templateId:nodeId:navigation:

/// 登录窗口配置
@JsonSerializable()
class FusionAuthModel {
  const FusionAuthModel({
    this.token,
    required this.schemeCode,
    this.templateId,
    this.logEnable = true,
    this.debugMode = true,
    this.isDelay = false,
    this.appServerHost,
    this.authtokenApi,
    this.verifyApi,
    this.tokenExpirTime = 30,
    this.navConfig,
  })  : assert(debugMode == true && (token == null || token == "")),
        assert(debugMode == false && (appServerHost == null || authtokenApi == null || verifyApi == null)),
        assert(schemeCode == null),
        assert(templateId == null),
        assert(isDelay != null);

  factory FusionAuthModel.fromJson(Map<String, dynamic> json) =>
      _$FusionAuthModelFromJson(json);

  /// 用于融合认证的鉴权
  /// 简易模式下该参数必传
  /// 可前往该地址获取: https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/GetFusionAuthToken
  final String? token;

  /// 方案Code
  /// 可前往该地址获取: https://dypns.console.aliyun.com/fusionSolution/All
  final String? schemeCode;

  /// 默认登录注册场景 "100001"
  /// 默认更换手机号场景 "100002"
  /// 默认重置密码场景 "100003"
  /// 默认绑定新手机号场景 "100004"
  /// 默认验证绑定手机号场景 "100005"
  /// templateId 场景唯一标识 与控制台场景ID唯一对应
  final String? templateId;

  /// 是否打印log，默认开启
  final bool? logEnable;

  /// 是否初始化后立即执行登录的操作，默认false
  final bool? isDelay;

  /// 服务端host地址
  final String? appServerHost;

  /// 获取token api
  final String? authtokenApi;

  /// 换取手机号api
  final String? verifyApi;

  /// 超时时间
  final int? tokenExpirTime;

  /// 提供两种模式
  /// 1、简易模式还是正常模式 必须参数 appServerHost authtokenApi verifyApi
  /// 2、简易模式的情况下需要设置token为必须，默认true，正式环境简易关闭使用正常模式
  final bool? debugMode;

  final ViewNavModel? navConfig;

  Map<String, dynamic> toJson() => _$FusionAuthModelToJson(this);
}

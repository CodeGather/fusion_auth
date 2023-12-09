import 'package:flutter/foundation.dart';

import '../config/fusion_auth_config.dart';
import '../model/response_model.dart';
import './fusion_auth_platform_interface.dart';

class FusionAuth {
  /// 获取版本号
  Future<String?> getPlatformVersion() {
    return FusionAuthPlatform.instance.getPlatformVersion();
  }

  /// 初始化SDK
  static void initSdk(FusionAuthConfig? config) {
    FusionAuthPlatform.instance.init(config);
  }

  /// 登录
  static void login() {
    FusionAuthPlatform.instance.login();
  }

  /// 监听事件
  static void handleEvent({
    required AsyncValueSetter<ResponseModel> onEvent,
  }){
    FusionAuthPlatform.instance.handleEvent(onEvent: onEvent);
  }

  /// 移除监听事件
  static void removeHandler() {
    FusionAuthPlatform.instance.removeHandler();
  }
}

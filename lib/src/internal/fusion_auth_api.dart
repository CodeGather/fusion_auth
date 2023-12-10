import 'package:flutter/foundation.dart';

import '../config/fusion_auth_config.dart';
import '../model/response_model.dart';
import './fusion_auth_platform_interface.dart';

/// 融合登录
class FusionAuth {
  // 初始化插件时是否添加监听回调
  FusionAuth({
    AsyncValueSetter<ResponseModel>? onEvent,
  }) {
    if (onEvent != null) {
      handleEvent(onEvent: onEvent);
    }
  }

  /// 获取版本号
  Future<String?> getVersion() {
    return FusionAuthPlatform.instance.getVersion();
  }

  /// 初始化SDK
  static void initSdk(FusionAuthConfig? config) {
    FusionAuthPlatform.instance.init(config);
  }

  /// 直接登录
  static void login() {
    FusionAuthPlatform.instance.login();
  }

  /// 回调监听事件
  static void handleEvent({
    required AsyncValueSetter<ResponseModel> onEvent,
  }) {
    FusionAuthPlatform.instance.handleEvent(onEvent: onEvent);
  }

  /// 移除监听事件
  static void removeHandler() {
    FusionAuthPlatform.instance.removeHandler();
  }

  /// 移除监听事件
  static void dispose() {
    FusionAuthPlatform.instance.dispose();
  }
}

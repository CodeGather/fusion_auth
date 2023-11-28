
import 'package:fusion_auth/fusion_auth_model.dart';

import 'fusion_auth_platform_interface.dart';

class FusionAuth {
  Future<String?> getPlatformVersion() {
    return FusionAuthPlatform.instance.getPlatformVersion();
  }

  /// 初始化监听
  static Stream<dynamic>? onChange({bool type = true}) {
    return FusionAuthPlatform.instance.onChange(type: type);
  }

  /// 数据监听
  static loginListen(
      {bool type = true,
        required Function onEvent,
        Function? onError,
        isOnlyOne = true}) async {
    return FusionAuthPlatform.instance.loginListen(
        type: type, onEvent: onEvent, onError: onError, isOnlyOne: isOnlyOne);
  }

  static void init(FusionAuthModel? config) {
    return FusionAuthPlatform.instance.init(config);
  }

  static void login() {
    return FusionAuthPlatform.instance.login();
  }
}

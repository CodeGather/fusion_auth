import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fusion_auth_model.dart';
import 'fusion_auth_platform_interface.dart';

/// An implementation of [FusionAuthPlatform] that uses method channels.
class MethodChannelFusionAuth extends FusionAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fusion_auth');

  /// 声明监听回调通道
  @visibleForTesting
  final EventChannel eventChannel = const EventChannel("fusion_auth/event");

  /// 监听器
  static Stream<dynamic>? onListener;

  /// 为了控制Stream 暂停。恢复。取消监听 新建
  static StreamSubscription? streamSubscription;

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 初始化监听
  @override
  Stream<dynamic>? onChange({bool type = true}) {
    onListener ??= eventChannel.receiveBroadcastStream(type);
    return onListener;
  }

  /// 数据监听
  @override
  loginListen(
      {bool type = true,
        required Function onEvent,
        Function? onError,
        isOnlyOne = true}) async {
    /// 默认为初始化单监听
    if (isOnlyOne && streamSubscription != null) {
      /// 原来监听被移除
      // dispose();
    }
    streamSubscription = onChange(type: type)!.listen(
        onEvent as void Function(dynamic)?,
        onError: onError,
        onDone: null,
        cancelOnError: null);
  }

  @override
  void init (FusionAuthModel? config) {
    config ??= const FusionAuthModel();
    methodChannel.invokeMethod("init", config.toJson());
  }

  @override
  void login () {
    methodChannel.invokeMethod<String>('login');
  }
}

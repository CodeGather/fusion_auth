import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../config/fusion_auth_config.dart';
import './fusion_auth_platform_interface.dart';
import '../model/response_model.dart';

/// An implementation of [FusionAuthPlatform] that uses method channels.
class MethodChannelFusionAuth extends FusionAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fusion_auth');

  @override
  Future<String?> getVersion() async {
    final version = await methodChannel.invokeMethod<String>('getVersion');
    debugPrint(version);
    return version;
  }

  @override
  void handleEvent({
    required AsyncValueSetter<ResponseModel> onEvent,
  }) {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onEvent":
          final ResponseModel responseModel = ResponseModel.fromJson(
            Map.from(call.arguments),
          );
          await onEvent.call(responseModel);
          break;
        default:
          throw UnsupportedError('Unrecognized JSON message');
      }
    });
  }

  @override
  void removeHandler() {
    methodChannel.setMethodCallHandler(null);
  }

  @override
  Future<void> initSdk(FusionAuthConfig? config) {
    config ??= FusionAuthConfig.fromJson({});
    return methodChannel.invokeMethod("initSdk", config.toJson());
  }

  @override
  Future<void> login() {
    return methodChannel.invokeMethod<String>('login');
  }

  @override
  void dispose() {
    removeHandler();
    methodChannel.invokeMethod<String>('dispose');
  }
}

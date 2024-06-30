import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../config/fusion_auth_config.dart';
import './fusion_auth_method_channel.dart';
import '../model/response_model.dart';

abstract class FusionAuthPlatform extends PlatformInterface {
  /// Constructs a FusionAuthPlatform.
  FusionAuthPlatform() : super(token: _token);

  static final Object _token = Object();

  static FusionAuthPlatform _instance = MethodChannelFusionAuth();

  /// The default instance of [FusionAuthPlatform] to use.
  ///
  /// Defaults to [MethodChannelFusionAuth].
  static FusionAuthPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FusionAuthPlatform] when
  /// they register themselves.
  static set instance(FusionAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getVersion() {
    throw UnimplementedError('version() has not been implemented.');
  }

  Future<void> initSdk(FusionAuthConfig? config) {
    throw UnimplementedError('loginListen() has not been implemented.');
  }

  Future<void> login() {
    throw UnimplementedError('loginListen() has not been implemented.');
  }

  void handleEvent({
    required AsyncValueSetter<ResponseModel> onEvent,
  }) {
    throw UnimplementedError('loginListen() has not been implemented.');
  }

  void removeHandler() {
    throw UnimplementedError('loginListen() has not been implemented.');
  }

  void dispose() {
    throw UnimplementedError('loginListen() has not been implemented.');
  }
}

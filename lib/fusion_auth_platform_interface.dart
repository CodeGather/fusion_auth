import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fusion_auth_method_channel.dart';
import 'fusion_auth_model.dart';

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

  Stream? onChange({bool type = true}) {
    throw UnimplementedError('onChange() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  loginListen(
      {bool type = true,
        required Function onEvent,
        Function? onError,
        isOnlyOne = true}) {
    throw UnimplementedError('loginListen() has not been implemented.');
  }

  void init(FusionAuthModel? config) {
    throw UnimplementedError('loginListen() has not been implemented.');
  }

  void login() {
    throw UnimplementedError('loginListen() has not been implemented.');
  }
}

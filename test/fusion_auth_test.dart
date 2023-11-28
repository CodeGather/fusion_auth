import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_auth/fusion_auth.dart';
import 'package:fusion_auth/fusion_auth_model.dart';
import 'package:fusion_auth/fusion_auth_platform_interface.dart';
import 'package:fusion_auth/fusion_auth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFusionAuthPlatform
    with MockPlatformInterfaceMixin
    implements FusionAuthPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  loginListen({bool type = true, required Function onEvent, Function? onError, isOnlyOne = true}) {
    // TODO: implement loginListen
    throw UnimplementedError();
  }

  @override
  Stream? onChange({bool type = true}) {
    // TODO: implement onChange
    throw UnimplementedError();
  }

  @override
  void init(FusionAuthModel? config) {
    // TODO: implement init
  }

  @override
  void login() {
    // TODO: implement login
  }
}

void main() {
  final FusionAuthPlatform initialPlatform = FusionAuthPlatform.instance;

  test('$MethodChannelFusionAuth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFusionAuth>());
  });

  test('getPlatformVersion', () async {
    FusionAuth fusionAuthPlugin = FusionAuth();
    MockFusionAuthPlatform fakePlatform = MockFusionAuthPlatform();
    FusionAuthPlatform.instance = fakePlatform;

    expect(await fusionAuthPlugin.getPlatformVersion(), '42');
  });
}

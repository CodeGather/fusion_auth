import 'package:flutter/src/foundation/basic_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_auth/src/internal/fusion_auth_api.dart';
import 'package:fusion_auth/src/model/fusion_auth_model.dart';
import 'package:fusion_auth/src/internal/fusion_auth_platform_interface.dart';
import 'package:fusion_auth/src/internal/fusion_auth_method_channel.dart';
import 'package:fusion_auth/src/model/response_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFusionAuthPlatform
    with MockPlatformInterfaceMixin
    implements FusionAuthPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void init(FusionAuthModel? config) {
    // TODO: implement init
  }

  @override
  void login() {
    // TODO: implement login
  }

  @override
  void removeHandler() {
    // TODO: implement removeHandler
  }

  @override
  void handleEvent({required AsyncValueSetter<ResponseModel> onEvent}) {
    // TODO: implement handleEvent
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

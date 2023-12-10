import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fusion_auth/src/internal/fusion_auth_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFusionAuth platform = MethodChannelFusionAuth();
  const MethodChannel channel = MethodChannel('fusion_auth');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getVersion', () async {
    expect(await platform.getVersion(), '42');
  });
}

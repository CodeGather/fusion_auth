import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fusion_auth/fusion_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _fusionAuthPlugin = FusionAuth();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {

      platformVersion =
          await _fusionAuthPlugin.getPlatformVersion() ?? 'Unknown platform version';


      FusionAuth.loginListen(onEvent: (onEvent) {
        if (kDebugMode) {
          print("----------------> $onEvent <----------------");
        }
        // EasyLoading.show(status: onEvent['msg'] ?? "", maskType: EasyLoadingMaskType.black);
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(onPressed: () {
                FusionAuth.init(null);
              }, child: const Text("开始初始化"),),
              ElevatedButton(onPressed: () {
                FusionAuth.login();
              }, child: const Text("开始登录"),),
            ],
          ),
        ),
      ),
    );
  }
}

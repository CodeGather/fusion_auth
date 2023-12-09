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
      platformVersion = await _fusionAuthPlugin.getPlatformVersion() ??
          'Unknown platform version';

      FusionAuth.handleEvent(onEvent: (ResponseModel onEvent) async {
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
              ElevatedButton(
                onPressed: () {
                  FusionAuthConfig authConfig = FusionAuthConfig(
                    token: "eyJhY2Nlc3NLZXlJZCI6IlNUUy5OU3lWVXpnTjZIZUE1enQ1ZHpqcWpWQkJiIiwiYWNjZXNzS2V5U2VjcmV0IjoiQVVySGdydHdDaGtvMkhoR1Uxc1FoUVZuaWN2Y2V1WGYzTmF6aWEyYlJnRlUiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrY2MrbU5XNWNoaDlZVFBNYzFVdUxJSTM3Q0dUTG1LdVhaemNGOGI5ZzIxSmU2Mjl4MHFyTUpsZ2x5UUxMTkhWMGdQT0tYN1NsYjFBeFVvVXIzQ29qbU9yWnZrZjhsR3hlcHRud3V5citYZDBqck5UNUpqTWd6bXp1eVcyc0V6K3VHYTA2VlFJZ3JpYWpLSlFnVWJYaElhQmsxV3lLbFZRVmhFbW9HL0YyZjg5bVF0YjIrUGRNdExSSzQ2M0VRbWI0U3BYL0FVY1ZQajV2bXc2VnB1c3VxQXdwaFJpZEwycDBuOXpRaFg1OXEya2Z4UE9jUVVhLzd3PT0iLCJ1bWVuZ0FwcEtleSI6IjY1NmRjNWYzYjJmNmZhMDBiYThjYWIyZiIsInN0c1Rva2VuIjoiQ0FJU3p3UjFxNkZ0NUIyeWZTaklyNURNSGUvT2lwRVgvNmVxTjF6RjBXUXZadjVHdVlmcGdEejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVU2SVJVVkYrT3JlWGRzalVYOXZ3UWNPdTlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORDNxT0hObjduSldkUTZUclJHaFFGOXZTUDNES3phcE1YL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlbzBNYkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0S2RVQ3p5aTl0L1cwYmJIL3I1NURRSXEvYW8vTnd5ZWRzdDNwRkVVaU1uYnJUYnJxYisvQWk3d3JqdGtwb0NIcHRBUnRuRUpKS24wMzdXZzJSZkZwMkdWYktVRG44UGFaWFppV3h6ZmVRWWluNkhDMWk5ZiswQmR6enZ1WlVoRXRnbUxvbSs3ZDhBQXlmS1czWEpEQks1T2hlVGZVenFtOTMxaEZNbUUrYXdNWGU1eWkybUJoZ2wrRVdvYWdBRjkzN0hLNDdKR080M2FhT3BlbzJjbzBlTElpUzV6aVo1T3NSald0UmpZUklNZmZlK3k2cHErN3Vuak9JYjRjdWxmcEpsKzdkZ1cvbDlOeWl6L0RBUjdRVTRobnA5Y21zR2VrZDNONGhUVlgwam9xdjBzdjVMTklUZTZlUnFvMWY2dm9kQ3FjcDROamFJS0Fnd040ZXZTSnZCSnNLQjVYNkxINWlNSFRYZ05jaUFBIiwiZXhwaXJlZFRpbWUiOjE3MDIxMjk5MDk5MzF9",
                    pageType: PageType.fullPort,
                    debugMode: true,
                    isDelay: false,
                    logEnable: true,
                    templateId: "100001"
                  );
                  FusionAuth.initSdk(authConfig);
                },
                child: const Text("全屏初始化"),
              ),
              ElevatedButton(
                onPressed: () {
                  FusionAuth.login();
                },
                child: const Text("开始登录"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

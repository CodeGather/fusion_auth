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
    FusionAuth.handleEvent(onEvent: (ResponseModel onEvent) async {
      if (kDebugMode) {
        print("----------------> $onEvent <----------------");
      }
      setState(() {
        _platformVersion = onEvent.toJson().toString();
      });
      // EasyLoading.show(status: onEvent['msg'] ?? "", maskType: EasyLoadingMaskType.black);
    });
    await _fusionAuthPlugin.getVersion();
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('阿里云融合认证插件'),
        ),
        body: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      FusionAuthConfig authConfig = const FusionAuthConfig(
                          token: "eyJhY2Nlc3NLZXlJZCI6IlNUUy5OVjVGYTRCS0xKWldtNkRYaVdtbjl2eEd5IiwiYWNjZXNzS2V5U2VjcmV0IjoiRFk4V1pYMURQSDdCdXdzSHJCb0tFY0tLNFozbldyR0Z4ZXBvUjNMZ1Y2eUQiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrY2MrbU5XNWNoaDlZVFBNYzFVdUxJSTM3Q0dUTG1LdVhaemNGOGI5ZzIxSmU2Mjl4MHFyTUpsZ2x5UUxMTkhWMGdQT0tYN1NsYjFBeFVvVXIzQ29qbU9yWnZrZjhsR3hlcHRud3V5citYZDNzeHpoQUpPVTROanpIK3FLZWdFSkJUL0tIWmo0WUZSaHZ0T05Na0h2R3NtaTNSa1pKdzdqakFRT29WRkJnSnp1YlhjUzNGVlpqUjFVdTZMZ0UwZTNQamJuQkw2Mm9qeTJ5UlZUQW4vYXNwV0hzMHBQWUdHUjlyZEJ1dG0zSHVXRVZyRUFNQ1BJTmRnPT0iLCJ1bWVuZ0FwcEtleSI6IjY1NmRjNWYzYjJmNmZhMDBiYThjYWIyZiIsInN0c1Rva2VuIjoiQ0FJU3p3UjFxNkZ0NUIyeWZTaklyNVdBRGR1QXI1UnQvWmk4YnhEMXZHa0NZZUVWbWIzc216ejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVU2SjZIamgvT3JlWGRzalVYOXZ3UWNPdTlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORDNxT0hObjduSldkUTZUclJHaFFGOXZTUDNES3phcE1YL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlbzBNYkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0S2RVQ3p5aTl0L1cwYmJIL3I1NURRSXEvYW8vTnd5ZWRzdDNwRkVVaU1uYnJUYnJxYisvQWk3d3JqdGtwb0NIcHRBUnRuRUpKS24wMzdXZzJSZkZwMkdWYktVRG44UGFaWFppV3h6ZmVRWWluNkhDMWk5ZiswQmR6enZ1WlVoRXRnbUxvbSs3ZDhBQXlmS1czWEpEQks1T2hlVGZVenFtOTMxaEZNbUUrYXdNWGU1eWkybUJoZ2wrRVdvYWdBRVRvK2p4by95Z3dnTHlvYU1UVVhUTzBCY0xPT3FGN2s2OWpBRkxVZmExTVdSV1FNcC9CZml4RkdMOHFzRzlmeVVTbHdldStTQVJiazRKZDMrcXdnTWtVazg4TGR3azJZcU9UbzU1b3J6a2xSR1B4V3o4QjlhMjhNWXR0TkFDcis2dFM5S01kdXhnVWhEZ1MrZ3c1L3dFU3JUaTlXTE1RN2QwZHFKZnRwQlM4eUFBIiwiZXhwaXJlZFRpbWUiOjE3MDIyMTQ5Mzk3MzJ9",
                          pageType: PageType.fullPort,
                          debugMode: true,
                          isDelay: false,
                          logEnable: true,
                          schemeCode: "FA000000004690134613",
                          templateId: "100001"
                      );
                      FusionAuth.initSdk(authConfig);
                    },
                    child: const Text("全屏初始化"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FusionAuth.login();
                      setState(() {
                        _platformVersion = "99999";
                      });
                    },
                    child: const Text("开始登录"),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: SelectableText(
                      _platformVersion,
                      style: const TextStyle(fontSize: 22),
                      onSelectionChanged: (selection, cause) {},
                    ),
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}

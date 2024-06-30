import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
  late FusionAuth _fusionAuthPlugin;

  /// 控制显示屏蔽蒙层
  late bool isCurrentLogin = false;

  @override
  void initState() {
    super.initState();

    /// 初始化时添加监听以免接受不到某些回调数据
    _fusionAuthPlugin = FusionAuth(onEvent: (ResponseModel onEvent) async {
      if (kDebugMode) {
        print(">>>>>>>> $onEvent <<<<<<<<");
      }
      setState(() {
        // 唤起授权页面后需要处理点击穿透的问题
        isCurrentLogin = onEvent.errorCode == "400003";
        _platformVersion = onEvent.toJson().toString();
      });
      // EasyLoading.show(status: onEvent['msg'] ?? "", maskType: EasyLoadingMaskType.black);
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await _fusionAuthPlugin.getVersion();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          FusionAuthConfig authConfig = FusionAuthConfig(
                              token: Platform.isAndroid
                                  ? "eyJhY2Nlc3NLZXlJZCI6IlNUUy5OVTNZVjJUTTdlcGR1ZmRlVlVWUVdmSmR1IiwiYWNjZXNzS2V5U2VjcmV0IjoiM3RCVFl0VVpOS1daV2F0MlFNbWR5RVpFUmNzekhCMWNaV1poWkNONDZtVEMiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrN3lMZzJHanZWN1lQcVBjb2syVkRaM1R5RUU1dWZSYUU4WDNMOWRzaDRaWGlkTGxlTE5mK281a1hmOFk4NTZYaFgzcURSZnJFNGJtQjA4ZGJqWXBJRldiZTdKbzNqUXd5cnlnY0RuK3RnZzA2WE1uOHRza202Y0lNWVBINkNMTlNKYnpqUTVEUURteC9HYkk1MGV6K2dQZWVESUozSGtxU2s0b0ltb2dXdHh2MVphZU5rY1E0OTI2MlF6UVVGT01HZngyMVJkaTJMUHd6SXhFblNGN2FiNmZIeGJxbEs3dGZMaGdUNHJmMVkvWTN0amtxYkVmZ0VIc0FGTGl0QnhKYVJ1RU9lVTh4bFNvTUVaT3kwL3V5NEt6TDlNTzhzenNSMjF5TEtEQ2NFbGdOL3Vsb1hVSzV6RlFVelhHWHB1eWVEcHRQYks4SlF3cz0iLCJ1bWVuZ0FwcEtleSI6IjY2N2ZjM2Y2Y2FjMmE2NjRkZTU3NzFiOCIsInN0c1Rva2VuIjoiQ0FJUzR3VjFxNkZ0NUIyeWZTaklyNWFHRXV5R3VaSVcwcktQZDBEVmdWWUFXdDU3aVkvUGx6ejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVUrZCtGRzg4T2JlWGRzalVYOXZ3UWZxdjlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORFgyQ0hOcjRuSldkUTZUclJDTlRGOXZTUDNES3phb1ZYL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlb204YkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0TDlVWlV1QS9kK0Q4cUhXOHAxeEx3b3k1djVDRmdDQ2QvOXdzMXhhNUtpLzZYYmYvUDc3Vkd2NDMydys5OFBtOHBOTzUxcGJmK3VrcmZLSnZ6bllsV0dNWVpVK204clJJaG9OSnk2NllIdGsydnVmcTJzYXJoUWE2UUdPTmcwWTlrNmEyQlRiSHFSWjhJVFNsaThVWFAwRHlMaUVFbWo1cHpzL003L1R2ZVpYQTlFRlZmdFZUL094MFR0dXd2RGF0QkNxcytYRHkwdzZOcjZrS3VONk05SVVXVWl0dnYrd01NdGhrT1JwQWlUbGQ3TkhxNHhZemdTTDN6TXowc01GYjlVbUhFZENIb0VoYktkaktFRmpTRlhEOWtRenNyOXlYUGZSTGR5U2xyRjBzeU56aWVvSnd2dW1ZMVRiLzRSaUpIczJ0eVdaQnNoazRrekd3M01QS0FURm5OK2ltWHMzSmRlZEJxSTEycUZaS2huRjV4OEtCMkxNdm5zL3diN1BHb0FCUmpiUkdZUm9qM1o2OEhBbWRwUXg1MHJjUGpuaW1FUHlpM2Y5cUZ2UGxQL0NxZmNKVGdFL0dOeGdHTVlIbUJVNjlXVVNkNzZmaFZCK3JZcENyQ0M4SVRMdXJVMStWZnkwWFZrQUZnNjVCUEl4aDJGejJOVXJyUU1YMEdUcW45VWJEZjFMZXREVTU4M0N4V2p3VGZ1SjRyMGR3OTRBWGNKcGt0U1RFYUtMWTMwZ0FBPT0iLCJleHBpcmVkVGltZSI6MTcxOTc0OTA2NDIxMywiZXhwYW5kSW5mbyI6IldXSFdrZ1JKUDA4eUp6MzhkcHZNUVo1QjQ4VDdqRzNDRDJ4MU9IYnpIVUhnMlJZRktCNDVZL05pVGFmYlQvME8wc0x0UU9ZR3FUeEd3cDFyZTl6T3ZvQWFVUXJjNTJVUnJLK0tMd0JFK0tIRlpOczg4Y2pTWUVsWFZlc1J4ZFZELzhLUUowSWo0bXNINTFUdEZMc29jUFg3QlVuWEY3VjRvV2xEYUhiUVE0eW1wRGs0R2xKZ1lsc3N0U2tEQ1A0bko4bzVxTWxmRkFGdnBwbUFscDgrNnA4RUNyZzIxM2xwVm9lQTZzMTZwRDlwTjBHYWZVQVVxS0dxZWY0VVVmK1dRNllJREI3QVFtQjlUamdrVnYrRG85Z1lHY2V3NmlmM3NtUDFYZVNKcWExdDRjREdiQWMxWUlxVkVhQWo1dHBjeHJnRmVzZGQ1c2VNdmE1VFRGeks3cnFsTmtNTHpKTlc3N0ZJeGo4T2JvVk1wYVRNSFVJZTdhQVBZMkZaS001S1JwSTB4TnVQTFJZVFc2d1dWSmNtRjVwKzVUQWNta2xxMS9Kd1RkOU1OY2JBUFlJb3Y4cUlnZ0Q1WlNORitZR2JNZDV3ZDlSMGVxVUsrRWx3akFjWUxneWt4dUxBREpRSHo5eEpWMjlzSlJVdHFhaDV3eDQwVU9LTmlId0RXVlJKQmdKZHFxdUpjYStyVzB1cElyd3ZZS3B2cGN6QmN3emYifQ=="
                                  : "eyJhY2Nlc3NLZXlJZCI6IlNUUy5OVGNXRlJkWE1GanMyTFY5SkhhR1VLWWtrIiwiYWNjZXNzS2V5U2VjcmV0IjoiRHZRYWtrM1RQaHZldk1MbUhyeFpaVHpkczRFeXB2OFN4UTF3ZkM0OTRZNkgiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrY2MrbU5XNWNoaDlZVFBNYzFVdUxJSTM3Q0dUTG1LdVhaemNGOGI5ZzIxSmU2Mjl4MHFyTUpsZ2x5UUxMTkhWMGdQT0tYN1NsYjFBeFVvVXIzQ29qbU9yWnZrZjhsR3hlcHRud3V5citYZDJ4SnVlTmM2alU4UThoVEpjMlpCYjFBVGc3Q3kzZkNMNWo0eCtWQ1FndG5SbmpIMWpFMlFTVTdlS3RVVldlWDRKSUZOa3VRWVptMU9jeEM2bjFSNUhkUCt2UjU0YW9hME9ldk9WVmNqc0JVZ0RybVZiZTBJcXN0dHdOM2RtVkFsNFIxVjVoTlRBZWpBPT0iLCJ1bWVuZ0FwcEtleSI6IjY1NmRjNWYzYjJmNmZhMDBiYThjYWIyZiIsInN0c1Rva2VuIjoiQ0FJU3p3UjFxNkZ0NUIyeWZTaklyNWZXSFB6bWlZZHM4YWlZTUdybjNVb2RiY2g1cEp6QWlUejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVUvNDRVRHQ5T3JlWGRzalVYOXZ3UWNPdTlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORDNxT0hObjduSldkUTZUclJHaFFGOXZTUDNES3phcE1YL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlbzBNYkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0S2RVQ3p5aTl0L1cwYmJIL3I1NURRSXEvYW8vTnd5ZWRzdDNwRkVVaU1uYnJUYnJxYisvQWk3d3JqdGtwb0NIcHRBUnRuRUpKS24wMzdXZzJSZkZwMkdWYktVRG44UGFaWFppV3h6ZmVRWWluNkhDMWk5ZiswQmR6enZ1WlVoRXRnbUxvbSs3ZDhBQXlmS1czWEpEQks1T2hlVGZVenFtOTMxaEZNbUUrYXdNWGU1eWkybUJoZ2wrRVdvYWdBRXhoenlpVFRLRVNDZjZYc2lxUzhCa0lnWDFuNlZNTEZEOURQeElVdnFlNUg1d2VFVzdzZGVQQngycUczSTZ0TWFhQnRBNytOZnJvOFhKdngwVWZWVUxCNkpOd25idXhtRkgrb0RjOUF3bHF1cEtncXArbWFCQ01NYTkyOCtWaXk4cTRDSHpza2RFVDM5ek5OdVRrY2xQUlo0ZStnYVZ0UG0zVTEreElnbWt4eUFBIiwiZXhwaXJlZFRpbWUiOjE3MDI3NDY0NjE0MDl9",
                              pageType: PageType.fullPort,
                              debugMode: true,
                              isDelay: false,
                              logEnable: true,
                              schemeCode: "FA000000004690134613",
                              templateId: SceneType.login,
                              privacyAlertConfig: PrivacyAlertConfig(
                                  privacyAlertIsNeedShow: false));
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
                        borderRadius: BorderRadius.circular(10)),
                    child: SelectableText(
                      _platformVersion,
                      style: const TextStyle(fontSize: 18),
                      onSelectionChanged: (selection, cause) {},
                    ),
                  ))
                ],
              ),
              isCurrentLogin
                  ? Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Container(color: Colors.transparent),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

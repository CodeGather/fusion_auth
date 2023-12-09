import 'package:fusion_auth/src/config/part_ui_config.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model/view/nav_view_model.dart';
import '../model/view/sms_send_view_model.dart';
import '../model/view/sms_view_model.dart';
import 'part_abstract_config.dart';

part 'fusion_auth_config.g.dart';

/// 全局配置
@JsonSerializable()
class FusionAuthConfig extends PartAbstractConfig{
  const FusionAuthConfig({
    this.navViewConfig,
    this.smsSendViewConfig,
    this.smsViewConfig,
    this.logoConfig,
    this.sloganConfig,
    this.phoneNumberConfig,
    this.loginButtonConfig,
    this.changeButtonConfig,
    this.checkBoxConfig,
    this.privacyConfig,
    this.customViewBlockList,
    super.token,
    super.schemeCode,
    super.templateId,
    super.logEnable,
    super.debugMode,
    super.isDelay,
    super.appServerHost,
    super.authtokenApi,
    super.verifyApi,
    super.tokenExpirTime,
  })  : assert(debugMode == true && (token == null || token == "")),
        assert(debugMode == false && (appServerHost == null || authtokenApi == null || verifyApi == null)),
        assert(schemeCode == null),
        assert(templateId == null),
        assert(isDelay != null);

  factory FusionAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$FusionAuthConfigFromJson(json);

  final NavViewModel? navViewConfig;
  final SmsSendViewModel? smsSendViewConfig;
  final SmsViewModel? smsViewConfig;
  final LogoConfig? logoConfig;
  final SloganConfig? sloganConfig;
  final PhoneNumberConfig? phoneNumberConfig;
  final LoginButtonConfig? loginButtonConfig;
  final ChangeButtonConfig? changeButtonConfig;
  final CheckBoxConfig? checkBoxConfig;
  final PrivacyConfig? privacyConfig;
  final List<CustomViewBlock>? customViewBlockList;

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'schemeCode': schemeCode,
      'templateId': templateId,
      'logEnable': logEnable,
      'isDelay': isDelay,
      'appServerHost': appServerHost,
      'authtokenApi': authtokenApi,
      'verifyApi': verifyApi,
      'tokenExpirTime': tokenExpirTime,
      'debugMode': debugMode,
      'navViewConfig': navViewConfig?.toJson(),
      'smsSendViewConfig': smsSendViewConfig?.toJson(),
      'smsViewConfig': smsViewConfig?.toJson(),
      'logoConfig': logoConfig?.toJson(),
      'sloganConfig': sloganConfig?.toJson(),
      'phoneNumberConfig': phoneNumberConfig?.toJson(),
      'loginButtonConfig': loginButtonConfig?.toJson(),
      'changeButtonConfig': changeButtonConfig?.toJson(),
      'checkBoxConfig': checkBoxConfig?.toJson(),
      'privacyConfig': privacyConfig?.toJson(),
      'customViewBlockList': customViewBlockList?.map((e) => e.toJson()).toList(growable: false),
    }..removeWhere((key, value) => value == null);
  }
}

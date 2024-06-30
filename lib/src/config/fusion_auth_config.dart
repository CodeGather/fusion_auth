import 'package:json_annotation/json_annotation.dart';

import '../model/fusion_auth_enum.dart';
import '../model/view/nav_view_model.dart';
import '../model/view/sms_send_view_model.dart';
import '../model/view/sms_view_model.dart';
import 'part_abstract_config.dart';
import 'part_ui_config.dart';
import 'privacy_alert_ui_config.dart';

part 'fusion_auth_config.g.dart';

/// 全局配置
@JsonSerializable()
class FusionAuthConfig extends PartAbstractConfig {
  const FusionAuthConfig({
    this.navStatusBarConfig,
    this.backgroundConfig,
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
    this.privacyAlertConfig,
    this.customViewBlockList,
    super.token,
    super.schemeCode,
    super.pageType,
    super.templateId,
    super.logEnable,
    super.debugMode,
    super.isDelay,
    super.appServerHost,
    super.authtokenApi,
    super.verifyApi,
    super.tokenExpirTime,
  })  : assert(schemeCode != null, "方案号不能为空"),
        assert(templateId != null, "场景ID不能为空");

  factory FusionAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$FusionAuthConfigFromJson(json);

  final NavStatusBarConfig? navStatusBarConfig;
  final BackgroundConfig? backgroundConfig;
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

  /// 二次隐私协议弹窗设置
  final PrivacyAlertConfig? privacyAlertConfig;
  final List<CustomViewBlock>? customViewBlockList;

  @override
  Map<String, dynamic> toJson() {
    if (debugMode == true && (token ?? "").isEmpty) {
      assert(false, "DEBUG模式下：token参数为必传");
    } else if (debugMode == false &&
        (appServerHost == null || authtokenApi == null || verifyApi == null)) {
      assert(false, "正常模式下：appServerHost、authtokenApi、verifyApi参数为必传");
    }
    return {
      'token': token,
      'schemeCode': schemeCode,
      'pageType': pageType?.index ?? PageType.fullPort.index,
      'templateId': EnumUtils.formatSenceValue(templateId ?? SceneType.login),
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
      'customViewBlockList':
          customViewBlockList?.map((e) => e.toJson()).toList(growable: false),
    }..removeWhere((key, value) => value == null);
  }
}

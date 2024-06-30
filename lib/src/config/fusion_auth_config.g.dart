// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fusion_auth_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FusionAuthConfig _$FusionAuthConfigFromJson(Map<String, dynamic> json) =>
    FusionAuthConfig(
      navStatusBarConfig: json['navStatusBarConfig'] == null
          ? null
          : NavStatusBarConfig.fromJson(
              json['navStatusBarConfig'] as Map<String, dynamic>),
      backgroundConfig: json['backgroundConfig'] == null
          ? null
          : BackgroundConfig.fromJson(
              json['backgroundConfig'] as Map<String, dynamic>),
      navViewConfig: json['navViewConfig'] == null
          ? null
          : NavViewModel.fromJson(
              json['navViewConfig'] as Map<String, dynamic>),
      smsSendViewConfig: json['smsSendViewConfig'] == null
          ? null
          : SmsSendViewModel.fromJson(
              json['smsSendViewConfig'] as Map<String, dynamic>),
      smsViewConfig: json['smsViewConfig'] == null
          ? null
          : SmsViewModel.fromJson(
              json['smsViewConfig'] as Map<String, dynamic>),
      logoConfig: json['logoConfig'] == null
          ? null
          : LogoConfig.fromJson(json['logoConfig'] as Map<String, dynamic>),
      sloganConfig: json['sloganConfig'] == null
          ? null
          : SloganConfig.fromJson(json['sloganConfig'] as Map<String, dynamic>),
      phoneNumberConfig: json['phoneNumberConfig'] == null
          ? null
          : PhoneNumberConfig.fromJson(
              json['phoneNumberConfig'] as Map<String, dynamic>),
      loginButtonConfig: json['loginButtonConfig'] == null
          ? null
          : LoginButtonConfig.fromJson(
              json['loginButtonConfig'] as Map<String, dynamic>),
      changeButtonConfig: json['changeButtonConfig'] == null
          ? null
          : ChangeButtonConfig.fromJson(
              json['changeButtonConfig'] as Map<String, dynamic>),
      checkBoxConfig: json['checkBoxConfig'] == null
          ? null
          : CheckBoxConfig.fromJson(
              json['checkBoxConfig'] as Map<String, dynamic>),
      privacyConfig: json['privacyConfig'] == null
          ? null
          : PrivacyConfig.fromJson(
              json['privacyConfig'] as Map<String, dynamic>),
      privacyAlertConfig: json['privacyAlertConfig'] == null
          ? null
          : PrivacyAlertConfig.fromJson(
              json['privacyAlertConfig'] as Map<String, dynamic>),
      customViewBlockList: (json['customViewBlockList'] as List<dynamic>?)
          ?.map((e) => CustomViewBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String?,
      schemeCode: json['schemeCode'] as String?,
      pageType: $enumDecodeNullable(_$PageTypeEnumMap, json['pageType']),
      templateId: $enumDecodeNullable(_$SceneTypeEnumMap, json['templateId']),
      logEnable: json['logEnable'] as bool? ?? false,
      debugMode: json['debugMode'] as bool? ?? true,
      isDelay: json['isDelay'] as bool? ?? false,
      appServerHost: json['appServerHost'] as String?,
      authtokenApi: json['authtokenApi'] as String?,
      verifyApi: json['verifyApi'] as String?,
      tokenExpirTime: json['tokenExpirTime'] as int? ?? 20,
    );

Map<String, dynamic> _$FusionAuthConfigToJson(FusionAuthConfig instance) =>
    <String, dynamic>{
      'token': instance.token,
      'schemeCode': instance.schemeCode,
      'pageType': _$PageTypeEnumMap[instance.pageType],
      'templateId': _$SceneTypeEnumMap[instance.templateId],
      'logEnable': instance.logEnable,
      'isDelay': instance.isDelay,
      'appServerHost': instance.appServerHost,
      'authtokenApi': instance.authtokenApi,
      'verifyApi': instance.verifyApi,
      'tokenExpirTime': instance.tokenExpirTime,
      'debugMode': instance.debugMode,
      'navStatusBarConfig': instance.navStatusBarConfig,
      'backgroundConfig': instance.backgroundConfig,
      'navViewConfig': instance.navViewConfig,
      'smsSendViewConfig': instance.smsSendViewConfig,
      'smsViewConfig': instance.smsViewConfig,
      'logoConfig': instance.logoConfig,
      'sloganConfig': instance.sloganConfig,
      'phoneNumberConfig': instance.phoneNumberConfig,
      'loginButtonConfig': instance.loginButtonConfig,
      'changeButtonConfig': instance.changeButtonConfig,
      'checkBoxConfig': instance.checkBoxConfig,
      'privacyConfig': instance.privacyConfig,
      'privacyAlertConfig': instance.privacyAlertConfig,
      'customViewBlockList': instance.customViewBlockList,
    };

const _$PageTypeEnumMap = {
  PageType.fullPort: 'fullPort',
  PageType.fullLand: 'fullLand',
  PageType.dialogPort: 'dialogPort',
  PageType.dialogLand: 'dialogLand',
  PageType.dialogBottom: 'dialogBottom',
  PageType.customView: 'customView',
  PageType.customXml: 'customXml',
  PageType.customGif: 'customGif',
  PageType.customMOV: 'customMOV',
  PageType.customPIC: 'customPIC',
};

const _$SceneTypeEnumMap = {
  SceneType.login: 'login',
  SceneType.changeMobile: 'changeMobile',
  SceneType.resetPaW: 'resetPaW',
  SceneType.bandMobile: 'bandMobile',
  SceneType.verifyMobile: 'verifyMobile',
};

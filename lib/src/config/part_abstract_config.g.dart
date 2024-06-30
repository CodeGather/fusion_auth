// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_abstract_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartAbstractConfig _$PartAbstractConfigFromJson(Map<String, dynamic> json) =>
    PartAbstractConfig(
      token: json['token'] as String?,
      schemeCode: json['schemeCode'] as String?,
      pageType: json['pageType'],
      templateId: json['templateId'],
      logEnable: json['logEnable'] as bool? ?? false,
      debugMode: json['debugMode'] as bool? ?? true,
      isDelay: json['isDelay'] as bool? ?? false,
      yMengSdk: json['yMengSdk'] as bool? ?? false,
      appServerHost: json['appServerHost'] as String?,
      authtokenApi: json['authtokenApi'] as String?,
      verifyApi: json['verifyApi'] as String?,
      tokenExpirTime: json['tokenExpirTime'] as int? ?? 20,
    );

Map<String, dynamic> _$PartAbstractConfigToJson(PartAbstractConfig instance) =>
    <String, dynamic>{
      'token': instance.token,
      'schemeCode': instance.schemeCode,
      'pageType': _$PageTypeEnumMap[instance.pageType],
      'templateId': instance.templateId,
      'logEnable': instance.logEnable,
      'isDelay': instance.isDelay,
      'yMengSdk': instance.yMengSdk,
      'appServerHost': instance.appServerHost,
      'authtokenApi': instance.authtokenApi,
      'verifyApi': instance.verifyApi,
      'tokenExpirTime': instance.tokenExpirTime,
      'debugMode': instance.debugMode,
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

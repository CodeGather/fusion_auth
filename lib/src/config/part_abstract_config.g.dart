// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_abstract_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartAbstractConfig _$PartAbstractConfigFromJson(Map<String, dynamic> json) =>
    PartAbstractConfig(
      token: json['token'] as String?,
      schemeCode: json['schemeCode'] as String?,
      templateId: json['templateId'] as String?,
      logEnable: json['logEnable'] as bool? ?? true,
      debugMode: json['debugMode'] as bool? ?? true,
      isDelay: json['isDelay'] as bool? ?? false,
      appServerHost: json['appServerHost'] as String?,
      authtokenApi: json['authtokenApi'] as String?,
      verifyApi: json['verifyApi'] as String?,
      tokenExpirTime: json['tokenExpirTime'] as int? ?? 20,
    );

Map<String, dynamic> _$PartAbstractConfigToJson(PartAbstractConfig instance) =>
    <String, dynamic>{
      'token': instance.token,
      'schemeCode': instance.schemeCode,
      'templateId': instance.templateId,
      'logEnable': instance.logEnable,
      'isDelay': instance.isDelay,
      'appServerHost': instance.appServerHost,
      'authtokenApi': instance.authtokenApi,
      'verifyApi': instance.verifyApi,
      'tokenExpirTime': instance.tokenExpirTime,
      'debugMode': instance.debugMode,
    };

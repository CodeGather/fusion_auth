// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fusion_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FusionAuthModel _$FusionAuthModelFromJson(Map<String, dynamic> json) =>
    FusionAuthModel(
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
      navConfig: json['navConfig'] == null
          ? null
          : ViewNavModel.fromJson(json['navConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FusionAuthModelToJson(FusionAuthModel instance) =>
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
      'navConfig': instance.navConfig,
    };

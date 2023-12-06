// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_ui_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogUIConfig _$DialogUIConfigFromJson(Map<String, dynamic> json) =>
    DialogUIConfig(
      alertTitleBarConfig: json['alertTitleBarConfig'] == null
          ? null
          : AlertTitleBarConfig.fromJson(
              json['alertTitleBarConfig'] as Map<String, dynamic>),
      alertContentViewColor: json['alertContentViewColor'] as String?,
      alertBlurViewColor: json['alertBlurViewColor'] as String?,
      alertBlurViewAlpha: (json['alertBlurViewAlpha'] as num?)?.toDouble(),
      alertBorderRadius: (json['alertBorderRadius'] as num?)?.toDouble(),
      alertBorderWidth: (json['alertBorderWidth'] as num?)?.toDouble(),
      alertBorderColor: json['alertBorderColor'] as String?,
      alertWindowHeight: (json['alertWindowHeight'] as num?)?.toDouble(),
      alertWindowWidth: (json['alertWindowWidth'] as num?)?.toDouble(),
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
    );

Map<String, dynamic> _$DialogUIConfigToJson(DialogUIConfig instance) =>
    <String, dynamic>{
      'logoConfig': instance.logoConfig,
      'sloganConfig': instance.sloganConfig,
      'phoneNumberConfig': instance.phoneNumberConfig,
      'loginButtonConfig': instance.loginButtonConfig,
      'changeButtonConfig': instance.changeButtonConfig,
      'checkBoxConfig': instance.checkBoxConfig,
      'privacyConfig': instance.privacyConfig,
      'alertTitleBarConfig': instance.alertTitleBarConfig,
      'alertContentViewColor': instance.alertContentViewColor,
      'alertBlurViewColor': instance.alertBlurViewColor,
      'alertBlurViewAlpha': instance.alertBlurViewAlpha,
      'alertBorderRadius': instance.alertBorderRadius,
      'alertBorderWidth': instance.alertBorderWidth,
      'alertBorderColor': instance.alertBorderColor,
      'alertWindowWidth': instance.alertWindowWidth,
      'alertWindowHeight': instance.alertWindowHeight,
    };

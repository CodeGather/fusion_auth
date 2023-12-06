// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_screen_ui_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullScreenUIConfig _$FullScreenUIConfigFromJson(Map<String, dynamic> json) =>
    FullScreenUIConfig(
      navConfig: json['navConfig'] == null
          ? null
          : NavConfig.fromJson(json['navConfig'] as Map<String, dynamic>),
      backgroundImage: json['backgroundImage'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      prefersStatusBarHidden: json['prefersStatusBarHidden'] as bool? ?? false,
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
      customViewBlockList: (json['customViewBlockList'] as List<dynamic>?)
          ?.map((e) => CustomViewBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FullScreenUIConfigToJson(FullScreenUIConfig instance) =>
    <String, dynamic>{
      'logoConfig': instance.logoConfig,
      'sloganConfig': instance.sloganConfig,
      'phoneNumberConfig': instance.phoneNumberConfig,
      'loginButtonConfig': instance.loginButtonConfig,
      'changeButtonConfig': instance.changeButtonConfig,
      'checkBoxConfig': instance.checkBoxConfig,
      'privacyConfig': instance.privacyConfig,
      'customViewBlockList': instance.customViewBlockList,
      'navConfig': instance.navConfig,
      'backgroundColor': instance.backgroundColor,
      'backgroundImage': instance.backgroundImage,
      'prefersStatusBarHidden': instance.prefersStatusBarHidden,
    };

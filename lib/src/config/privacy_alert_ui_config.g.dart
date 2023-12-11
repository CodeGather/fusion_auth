// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_alert_ui_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyAlertConfig _$PrivacyAlertConfigFromJson(Map<String, dynamic> json) =>
    PrivacyAlertConfig(
      privacyAlertIsNeedShow: json['privacyAlertIsNeedShow'] as bool?,
      privacyAlertIsNeedAutoLogin: json['privacyAlertIsNeedAutoLogin'] as bool?,
      privacyAlertCornerRadiusArray:
          (json['privacyAlertCornerRadiusArray'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      privacyAlertBackgroundColor:
          json['privacyAlertBackgroundColor'] as String?,
      privacyAlertAlpha: (json['privacyAlertAlpha'] as num?)?.toDouble(),
      privacyAlertTitleFont: json['privacyAlertTitleFont'] as int?,
      privacyAlertTitleColor: json['privacyAlertTitleColor'] as String?,
      privacyAlertTitleBackgroundColor:
          json['privacyAlertTitleBackgroundColor'] as String?,
      privacyAlertTitleAlignment: $enumDecodeNullable(
          _$TextAlignmentEnumMap, json['privacyAlertTitleAlignment']),
      privacyAlertContentFont: json['privacyAlertContentFont'] as int?,
      privacyAlertContentBackgroundColor:
          json['privacyAlertContentBackgroundColor'] as String?,
      privacyAlertContentColors:
          (json['privacyAlertContentColors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      privacyAlertContentAlignment: $enumDecodeNullable(
          _$TextAlignmentEnumMap, json['privacyAlertContentAlignment']),
      privacyAlertBtnBackgroundImages:
          (json['privacyAlertBtnBackgroundImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      privacyAlertButtonTextColors:
          (json['privacyAlertButtonTextColors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      privacyAlertButtonFont: json['privacyAlertButtonFont'] as int?,
      privacyAlertCloseButtonIsNeedShow:
          json['privacyAlertCloseButtonIsNeedShow'] as bool?,
      privacyAlertCloseButtonImage:
          json['privacyAlertCloseButtonImage'] as String?,
      privacyAlertMaskIsNeedShow: json['privacyAlertMaskIsNeedShow'] as bool?,
      tapPrivacyAlertMaskCloseAlert:
          json['tapPrivacyAlertMaskCloseAlert'] as bool?,
      privacyAlertMaskColor: json['privacyAlertMaskColor'] as String?,
      privacyAlertMaskAlpha:
          (json['privacyAlertMaskAlpha'] as num?)?.toDouble(),
      privacyAlertContentWidth:
          (json['privacyAlertContentWidth'] as num?)?.toDouble(),
      privacyAlertContentHeight:
          (json['privacyAlertContentHeight'] as num?)?.toDouble(),
      privacyAlertAlignment: $enumDecodeNullable(
          _$DialogAlignmentEnumMap, json['privacyAlertAlignment']),
    );

Map<String, dynamic> _$PrivacyAlertConfigToJson(PrivacyAlertConfig instance) =>
    <String, dynamic>{
      'privacyAlertIsNeedShow': instance.privacyAlertIsNeedShow,
      'privacyAlertIsNeedAutoLogin': instance.privacyAlertIsNeedAutoLogin,
      'privacyAlertCornerRadiusArray': instance.privacyAlertCornerRadiusArray,
      'privacyAlertBackgroundColor': instance.privacyAlertBackgroundColor,
      'privacyAlertAlpha': instance.privacyAlertAlpha,
      'privacyAlertTitleFont': instance.privacyAlertTitleFont,
      'privacyAlertTitleColor': instance.privacyAlertTitleColor,
      'privacyAlertTitleBackgroundColor':
          instance.privacyAlertTitleBackgroundColor,
      'privacyAlertTitleAlignment':
          _$TextAlignmentEnumMap[instance.privacyAlertTitleAlignment],
      'privacyAlertContentFont': instance.privacyAlertContentFont,
      'privacyAlertContentBackgroundColor':
          instance.privacyAlertContentBackgroundColor,
      'privacyAlertContentColors': instance.privacyAlertContentColors,
      'privacyAlertContentAlignment':
          _$TextAlignmentEnumMap[instance.privacyAlertContentAlignment],
      'privacyAlertBtnBackgroundImages':
          instance.privacyAlertBtnBackgroundImages,
      'privacyAlertButtonTextColors': instance.privacyAlertButtonTextColors,
      'privacyAlertButtonFont': instance.privacyAlertButtonFont,
      'privacyAlertCloseButtonIsNeedShow':
          instance.privacyAlertCloseButtonIsNeedShow,
      'privacyAlertCloseButtonImage': instance.privacyAlertCloseButtonImage,
      'privacyAlertMaskIsNeedShow': instance.privacyAlertMaskIsNeedShow,
      'tapPrivacyAlertMaskCloseAlert': instance.tapPrivacyAlertMaskCloseAlert,
      'privacyAlertMaskColor': instance.privacyAlertMaskColor,
      'privacyAlertMaskAlpha': instance.privacyAlertMaskAlpha,
      'privacyAlertContentWidth': instance.privacyAlertContentWidth,
      'privacyAlertContentHeight': instance.privacyAlertContentHeight,
      'privacyAlertAlignment':
          _$DialogAlignmentEnumMap[instance.privacyAlertAlignment],
    };

const _$TextAlignmentEnumMap = {
  TextAlignment.left: 'left',
  TextAlignment.center: 'center',
  TextAlignment.right: 'right',
};

const _$DialogAlignmentEnumMap = {
  DialogAlignment.center: 'center',
  DialogAlignment.bottom: 'bottom',
};

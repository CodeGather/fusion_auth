// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_nav_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewNavModel _$ViewNavModelFromJson(Map<String, dynamic> json) => ViewNavModel(
      isHidden: json['isHidden'] as bool?,
      backgroundColor: json['backgroundColor'] as String?,
      textFontSize: json['textFontSize'] as int?,
      textForegroundColor: json['textForegroundColor'] as String?,
      textBackgroundColor: json['textBackgroundColor'] as String?,
      textKern: json['textKern'] as int?,
    );

Map<String, dynamic> _$ViewNavModelToJson(ViewNavModel instance) =>
    <String, dynamic>{
      'isHidden': instance.isHidden,
      'backgroundColor': instance.backgroundColor,
      'textFontSize': instance.textFontSize,
      'textForegroundColor': instance.textForegroundColor,
      'textBackgroundColor': instance.textBackgroundColor,
      'textKern': instance.textKern,
    };

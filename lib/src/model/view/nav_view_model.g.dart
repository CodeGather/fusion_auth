// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavViewModel _$NavViewModelFromJson(Map<String, dynamic> json) => NavViewModel(
      title: json['title'] as String?,
      isHidden: json['isHidden'] as bool?,
      backgroundColor: json['backgroundColor'] as String?,
      textFontSize: json['textFontSize'] as int?,
      textForegroundColor: json['textForegroundColor'] as String?,
      textBackgroundColor: json['textBackgroundColor'] as String?,
      textKern: json['textKern'] as int?,
    );

Map<String, dynamic> _$NavViewModelToJson(NavViewModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'isHidden': instance.isHidden,
      'backgroundColor': instance.backgroundColor,
      'textFontSize': instance.textFontSize,
      'textForegroundColor': instance.textForegroundColor,
      'textBackgroundColor': instance.textBackgroundColor,
      'textKern': instance.textKern,
    };

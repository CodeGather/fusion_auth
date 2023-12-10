// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      resultCode: json['resultCode'] as String?,
      requestId: json['requestId'] as String?,
      msg: json['msg'] as String?,
      token: json['token'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'requestId': instance.requestId,
      'msg': instance.msg,
      'token': instance.token,
      'data': instance.data,
    };

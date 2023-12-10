// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
    resultCode: json['resultCode'] as String?,
    resultMsg: json['resultMsg'] as String?,
    innerCode: json['innerCode'] as String?,
    innerMsg: json['innerMsg'] as String?,
      requestId: json['requestId'] as String?,
      msg: json['msg'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
    'resultCode': instance.resultCode,
    'resultMsg': instance.resultMsg,
    'innerCode': instance.innerCode,
    'innerMsg': instance.innerMsg,
      'requestId': instance.requestId,
      'msg': instance.msg,
      'token': instance.token,
    };

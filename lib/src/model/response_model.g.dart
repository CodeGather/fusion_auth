// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      resultCode: json['resultCode'] as String?,
      msg: json['msg'] as String?,
      requestId: json['requestId'] as String?,
      token: json['token'] as String?,
      innerMsg: json['innerMsg'] as String?,
      innerCode: json['innerCode'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'msg': instance.msg,
      'requestId': instance.requestId,
      'token': instance.token,
      'innerMsg': instance.innerMsg,
      'innerCode': instance.innerCode,
    };

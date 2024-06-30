// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      errorCode: json['errorCode'] as String?,
      errorMsg: json['errorMsg'] as String?,
      innerCode: json['innerCode'] as String?,
      innerMsg: json['innerMsg'] as String?,
      requestId: json['requestId'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'innerCode': instance.innerCode,
      'innerMsg': instance.innerMsg,
      'requestId': instance.requestId,
      'token': instance.token,
    };

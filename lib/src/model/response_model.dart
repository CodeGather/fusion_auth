import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  const ResponseModel({
    this.resultCode,
    this.resultMsg,
    this.innerCode,
    this.innerMsg,
    this.requestId,
    this.msg,
    this.token,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  final String? resultCode;
  final String? resultMsg;
  final String? innerCode;
  final String? innerMsg;
  final String? requestId;
  final String? msg;
  final String? token;

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  const ResponseModel({
    this.errorCode,
    this.errorMsg,
    this.innerCode,
    this.innerMsg,
    this.requestId,
    this.token,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  final String? errorCode;
  final String? errorMsg;
  final String? innerCode;
  final String? innerMsg;
  final String? requestId;
  final String? token;

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

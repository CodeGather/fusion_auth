import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  const ResponseModel({
    this.resultCode,
    this.requestId,
    this.msg,
    this.token,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  final String? resultCode;
  final String? requestId;
  final String? msg;
  final String? token;
  final String? data;

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

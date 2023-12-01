import 'dart:convert';

part 'response_model.g.dart';

class ResponseModel {
  const ResponseModel({
    this.resultCode,
    this.msg,
    this.requestId,
    this.token,
    this.innerMsg,
    this.innerCode,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  final String? resultCode;
  final String? msg;
  final String? requestId;
  final String? token;
  final String? innerMsg;
  final String? innerCode;

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
import 'package:json_annotation/json_annotation.dart';

part 'view_sms_model.g.dart';

/// 登录窗口配置
@JsonSerializable()
class ViewSmsModel {
  const ViewSmsModel({
    this.token
  });

  factory ViewSmsModel.fromJson(Map<String, dynamic> json) =>
      _$ViewSmsModelFromJson(json);

  /// 用于融合认证的鉴权
  /// 简易模式下该参数必传
  /// 可前往该地址获取: https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/GetFusionAuthToken
  final String? token;

  Map<String, dynamic> toJson() => _$ViewSmsModelToJson(this);
}

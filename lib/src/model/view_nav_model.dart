import 'package:json_annotation/json_annotation.dart';
part 'view_nav_model.g.dart';

/// 登录窗口配置
@JsonSerializable()
class ViewNavModel {
  const ViewNavModel({
    this.token
  });

  factory ViewNavModel.fromJson(Map<String, dynamic> json) =>
      _$ViewNavModelFromJson(json);

  /// 用于融合认证的鉴权
  /// 简易模式下该参数必传
  /// 可前往该地址获取: https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/GetFusionAuthToken
  final String? token;

  Map<String, dynamic> toJson() => _$ViewNavModelToJson(this);
}

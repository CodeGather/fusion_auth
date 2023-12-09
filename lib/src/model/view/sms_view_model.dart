import 'package:json_annotation/json_annotation.dart';

part 'sms_view_model.g.dart';

/// 获取验证吗页面配置
@JsonSerializable()
class SmsViewModel {
  const SmsViewModel({
    this.token
  });

  factory SmsViewModel.fromJson(Map<String, dynamic> json) =>
      _$SmsViewModelFromJson(json);

  /// 用于融合认证的鉴权
  /// 简易模式下该参数必传
  /// 可前往该地址获取: https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/GetFusionAuthToken
  final String? token;

  Map<String, dynamic> toJson() => _$SmsViewModelToJson(this);
}

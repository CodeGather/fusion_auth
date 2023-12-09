import 'package:json_annotation/json_annotation.dart';

import 'fusion_auth_config.dart';
import 'part_ui_config.dart';
part 'full_screen_ui_config.g.dart';

@JsonSerializable()
class FullScreenUIConfig extends FusionAuthConfig {
  const FullScreenUIConfig({
    this.navConfig,
    this.backgroundImage,
    this.backgroundColor,
    this.prefersStatusBarHidden = false,
    super.logoConfig,
    super.sloganConfig,
    super.phoneNumberConfig,
    super.loginButtonConfig,
    super.changeButtonConfig,
    super.checkBoxConfig,
    super.privacyConfig,
    super.customViewBlockList,
  });

  final NavConfig? navConfig;

  ///十六进制的颜色
  final String? backgroundColor;
  final String? backgroundImage;

  ///状态栏是否隐藏，默认显示
  final bool prefersStatusBarHidden;

  factory FullScreenUIConfig.fromJson(Map<String, dynamic> json) =>
      _$FullScreenUIConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'backgroundColor': backgroundColor,
      'backgroundImage': backgroundImage,
      'prefersStatusBarHidden': prefersStatusBarHidden,
      'customViewBlockList':
      customViewBlockList?.map((e) => e.toJson()).toList(growable: false),
      ...?navConfig?.toJson(),
      ...?logoConfig?.toJson(),
      ...?sloganConfig?.toJson(),
      ...?phoneNumberConfig?.toJson(),
      ...?loginButtonConfig?.toJson(),
      ...?changeButtonConfig?.toJson(),
      ...?checkBoxConfig?.toJson(),
      ...?privacyConfig?.toJson(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  String toString() {
    return 'FullScreenUIConfig{${toJson()}';
  }
}
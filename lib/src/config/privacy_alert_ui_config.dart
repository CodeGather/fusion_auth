import 'package:json_annotation/json_annotation.dart';

import '../model/fusion_auth_enum.dart';

part 'privacy_alert_ui_config.g.dart';

@JsonSerializable()

/// 二次隐私协议弹窗设置
class PrivacyAlertConfig {
  const PrivacyAlertConfig({
    this.privacyAlertIsNeedShow,
    this.privacyAlertIsNeedAutoLogin,
    this.privacyAlertCornerRadiusArray,
    this.privacyAlertBackgroundColor,
    this.privacyAlertAlpha,
    this.privacyAlertTitleFont,
    this.privacyAlertTitleColor,
    this.privacyAlertTitleBackgroundColor,
    this.privacyAlertTitleAlignment,
    this.privacyAlertContentFont,
    this.privacyAlertContentBackgroundColor,
    this.privacyAlertContentColors,
    this.privacyAlertContentAlignment,
    this.privacyAlertBtnBackgroundImages,
    this.privacyAlertButtonTextColors,
    this.privacyAlertButtonFont,
    this.privacyAlertCloseButtonIsNeedShow,
    this.privacyAlertCloseButtonImage,
    this.privacyAlertMaskIsNeedShow,
    this.tapPrivacyAlertMaskCloseAlert,
    this.privacyAlertMaskColor,
    this.privacyAlertMaskAlpha,
    this.privacyAlertContentWidth,
    this.privacyAlertContentHeight,
    this.privacyAlertAlignment,
  });

  factory PrivacyAlertConfig.fromJson(Map<String, dynamic> json) =>
      _$PrivacyAlertConfigFromJson(json);

  /// 二次隐私协议弹窗是否需要显示, 默认NO
  final bool? privacyAlertIsNeedShow;

  /// 二次隐私协议弹窗点击按钮是否需要执行登录，默认YES
  final bool? privacyAlertIsNeedAutoLogin;

  /// 二次隐私协议弹窗的四个圆角值，顺序为左上，左下，右下，右上，需要填充4个值，不足4个值则无效，如果值<=0则为直角 ，默认0
  final List<int>? privacyAlertCornerRadiusArray;

  /// 二次隐私协议弹窗背景颜色，默认为白色
  final String? privacyAlertBackgroundColor;

  /// 二次隐私协议弹窗透明度，默认不透明1.0 ，设置范围0.3~1.0之间
  final double? privacyAlertAlpha;

  /// 二次隐私协议弹窗标题文字大小，最小12，默认12
  final int? privacyAlertTitleFont;

  /// 二次隐私协议弹窗标题文字颜色，默认黑色
  final String? privacyAlertTitleColor;

  /// 二次隐私协议弹窗标题背景颜色，默认白色
  final String? privacyAlertTitleBackgroundColor;

  /// 二次隐私协议弹窗标题位置，默认居中
  final TextAlignment? privacyAlertTitleAlignment;

  /// 二次隐私协议弹窗协议内容文字大小，最小12，默认12
  final int? privacyAlertContentFont;

  /// 二次隐私协议弹窗协议内容背景颜色，默认白色
  final String? privacyAlertContentBackgroundColor;

  /// 二次隐私协议弹窗协议内容颜色数组，[非点击文案颜色，点击文案颜色],默认[0x999999,0x1890FF]
  final List<String>? privacyAlertContentColors;

  /// 二次隐私协议弹窗协议文案支持居中、居左、居右设置，默认居左
  final TextAlignment? privacyAlertContentAlignment;

  /// 二次隐私协议弹窗按钮背景图片 ,默认高度50.0pt，@[激活状态的图片,高亮状态的图片]
  final List<String>? privacyAlertBtnBackgroundImages;

  /// 二次隐私协议弹窗按钮文字颜色，默认黑色, @[激活状态的颜色,高亮状态的颜色]
  final List<String>? privacyAlertButtonTextColors;

  /// 二次隐私协议弹窗按钮文字大小，最小10，默认18
  final int? privacyAlertButtonFont;

  /// 二次隐私协议弹窗关闭按钮是否显示，默认显示
  final bool? privacyAlertCloseButtonIsNeedShow;

  /// 二次隐私协议弹窗右侧关闭按钮图片设置，默认内置的X图片
  final String? privacyAlertCloseButtonImage;

  /// 二次隐私协议弹窗背景蒙层是否显示 ,默认YES
  final bool? privacyAlertMaskIsNeedShow;

  /// 二次隐私协议弹窗点击背景蒙层是否关闭弹窗 ,默认YES
  final bool? tapPrivacyAlertMaskCloseAlert;

  /// 二次隐私协议弹窗蒙版背景颜色，默认黑色
  final String? privacyAlertMaskColor;

  /// 二次隐私协议弹窗蒙版透明度 设置范围0.3~1.0之间 ，默认0.5
  final double? privacyAlertMaskAlpha;

  /// 二次隐私协议弹窗蒙版透明度 设置范围0.3~1.0之间 ，默认0.5
  final double? privacyAlertContentWidth;

  /// 二次隐私协议弹窗蒙版透明度 设置范围0.3~1.0之间 ，默认0.5
  final double? privacyAlertContentHeight;

  /// 二次隐私协议弹窗位置，中间或者底部，默认中间
  final DialogAlignment? privacyAlertAlignment;

  Map<String, dynamic> toJson() => _$PrivacyAlertConfigToJson(this);

  @override
  String toString() {
    return 'PrivacyAlertConfig${toJson()}';
  }
}

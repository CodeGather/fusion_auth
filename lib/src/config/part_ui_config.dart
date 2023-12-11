import 'package:json_annotation/json_annotation.dart';

import '../model/fusion_auth_enum.dart';

part 'part_ui_config.g.dart';

enum AuthUIStyle { fullScreen, bottomSheet, dialog }

@JsonSerializable()
class BackgroundConfig {
  const BackgroundConfig({
    this.backgroundColor,
    this.backgroundImage,
    this.backgroundImageContentMode,
  });

  factory BackgroundConfig.fromJson(Map<String, dynamic> json) =>
      _$BackgroundConfigFromJson(json);

  /// 授权页背景色
  final String? backgroundColor;
  /// 授权页背景图片
  final String? backgroundImage;
  /// 授权页背景图片view的 content mode，默认为 scaleAspectFill
  final ImageContentMode? backgroundImageContentMode;

  Map<String, dynamic> toJson() => _$BackgroundConfigToJson(this);
}

@JsonSerializable()
class NavStatusBarConfig {
  const NavStatusBarConfig({
    this.prefersStatusBarHidden,
    this.preferredStatusBarStyle,
  });

  factory NavStatusBarConfig.fromJson(Map<String, dynamic> json) =>
      _$NavStatusBarConfigFromJson(json);

  /// 状态栏是否隐藏，默认NO
  final bool? prefersStatusBarHidden;
  /// 状态栏主题风格，默认UIStatusBarStyleDefault
  final String? preferredStatusBarStyle;

  Map<String, dynamic> toJson() => _$NavStatusBarConfigToJson(this);
}

@JsonSerializable()
class NavConfig {
  const NavConfig({
    this.navIsHidden,
    this.navTitle,
    this.navTitleColor,
    this.navTitleSize,
    this.navFrameOffsetX,
    this.navFrameOffsetY,
    this.navColor,
    this.hideNavBackItem,
    this.navBackImage,
    this.navBackButtonOffsetX,
    this.navBackButtonOffsetY,
  });

  factory NavConfig.fromJson(Map<String, dynamic> json) =>
      _$NavConfigFromJson(json);

  final bool? navIsHidden;
  final String? navTitle;
  final String? navTitleColor;
  final int? navTitleSize;
  final double? navFrameOffsetX;
  final double? navFrameOffsetY;
  final String? navColor;
  final bool? hideNavBackItem;
  final String? navBackImage;
  final double? navBackButtonOffsetX;
  final double? navBackButtonOffsetY;

  Map<String, dynamic> toJson() => _$NavConfigToJson(this);
}

/// alert title bar 设置，仅弹窗生效
@JsonSerializable()
class AlertTitleBarConfig {
  const AlertTitleBarConfig({
    this.alertBarIsHidden,
    this.alertCloseItemIsHidden,
    this.alertTitleBarColor,
    this.alertTitleText,
    this.alertTitleTextColor,
    this.alertTittleTextSize,
    this.alertCloseImage,
    this.alertCloseImageOffsetY,
    this.alertCloseImageOffsetX,
  });

  factory AlertTitleBarConfig.fromJson(Map<String, dynamic> json) =>
      _$AlertTitleBarConfigFromJson(json);

  final bool? alertBarIsHidden;
  final bool? alertCloseItemIsHidden;
  final String? alertTitleBarColor;

  final String? alertTitleText;
  final String? alertTitleTextColor;
  final int? alertTittleTextSize;

  final String? alertCloseImage;
  final double? alertCloseImageOffsetX;
  final double? alertCloseImageOffsetY;

  Map<String, dynamic> toJson() => _$AlertTitleBarConfigToJson(this);
}

/// logo设置
@JsonSerializable()
class LogoConfig {
  const LogoConfig({
    this.logoIsHidden = false,
    this.logoImage,
    this.logoWidth,
    this.logoHeight,
    this.logoFrameOffsetX,
    this.logoFrameOffsetY,
  });

  factory LogoConfig.fromJson(Map<String, dynamic> json) =>
      _$LogoConfigFromJson(json);

  ///  logo是否隐藏，默认NO
  final bool logoIsHidden;
  /// logo图片路径
  final String? logoImage;
  final double? logoWidth;
  final double? logoHeight;
  final double? logoFrameOffsetX;
  final double? logoFrameOffsetY;

  Map<String, dynamic> toJson() => _$LogoConfigToJson(this);

  @override
  String toString() {
    return 'LogoConfig{logoIsHidden: $logoIsHidden, logoImage: $logoImage, logoWidth: $logoWidth, logoHeight: $logoHeight, logoFrameOffsetX: $logoFrameOffsetX, logoFrameOffsetY: $logoFrameOffsetY}';
  }
}

/// slogan设置
@JsonSerializable()
class SloganConfig {
  const SloganConfig({
    this.sloganIsHidden,
    this.sloganText,
    this.sloganTextColor,
    this.sloganTextSize,
    this.sloganFrameOffsetX,
    this.sloganFrameOffsetY,
  });

  factory SloganConfig.fromJson(Map<String, dynamic> json) =>
      _$SloganConfigFromJson(json);

  /// slogan是否隐藏，默认NO
  final bool? sloganIsHidden;
  final String? sloganText;
  final String? sloganTextColor;
  final int? sloganTextSize;
  final double? sloganFrameOffsetX;
  final double? sloganFrameOffsetY;

  Map<String, dynamic> toJson() => _$SloganConfigToJson(this);

  @override
  String toString() {
    return 'SloganConfig{sloganIsHidden: $sloganIsHidden, sloganText: $sloganText, sloganTextColor: $sloganTextColor, sloganTextSize: $sloganTextSize, sloganFrameOffsetX: $sloganFrameOffsetX, sloganFrameOffsetY: $sloganFrameOffsetY}';
  }
}

/// phone number设置
@JsonSerializable()
class PhoneNumberConfig {
  const PhoneNumberConfig({
    this.numberColor,
    this.numberFontSize,
    this.numberFrameOffsetX,
    this.numberFrameOffsetY,
  });

  factory PhoneNumberConfig.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberConfigFromJson(json);

  /// 号码颜色设置
  final String? numberColor;
  final int? numberFontSize;
  final double? numberFrameOffsetX;
  final double? numberFrameOffsetY;

  Map<String, dynamic> toJson() => _$PhoneNumberConfigToJson(this);

  @override
  String toString() {
    return 'PhoneNumberConfig{numberColor: $numberColor, numberFontSize: $numberFontSize, numberFrameOffsetX: $numberFrameOffsetX, numberFrameOffsetY: $numberFrameOffsetY}';
  }
}

/// login button设置
@JsonSerializable()
class LoginButtonConfig {
  const LoginButtonConfig({
    this.loginBtnText,
    this.loginBtnTextColor,
    this.loginBtnTextSize,
    this.loginBtnNormalImage,
    this.loginBtnUnableImage,
    this.loginBtnPressedImage,
    this.loginBtnFrameOffsetX,
    this.loginBtnFrameOffsetY,
    this.loginBtnWidth,
    this.loginBtnHeight,
  });

  factory LoginButtonConfig.fromJson(Map<String, dynamic> json) =>
      _$LoginButtonConfigFromJson(json);

  final String? loginBtnText;
  final String? loginBtnTextColor;
  final int? loginBtnTextSize;

  /// 激活状态的图片
  final String? loginBtnNormalImage;

  /// 失效状态的图片
  final String? loginBtnUnableImage;

  /// 高亮状态的图片
  final String? loginBtnPressedImage;

  final double? loginBtnFrameOffsetX;
  final double? loginBtnFrameOffsetY;

  final double? loginBtnWidth;

  /// 默认高度50.0pt 小于20.0pt不生效
  final double? loginBtnHeight;

  Map<String, dynamic> toJson() => _$LoginButtonConfigToJson(this);

  @override
  String toString() {
    return 'LoginButtonConfig{loginBtnText: $loginBtnText, loginBtnTextColor: $loginBtnTextColor, loginBtnTextSize: $loginBtnTextSize, loginBtnNormalImage: $loginBtnNormalImage, loginBtnUnableImage: $loginBtnUnableImage, loginBtnPressedImage: $loginBtnPressedImage, loginBtnFrameOffsetX: $loginBtnFrameOffsetX, loginBtnFrameOffsetY: $loginBtnFrameOffsetY, loginBtnWidth: $loginBtnWidth, loginBtnHeight: $loginBtnHeight}';
  }
}

/// change button 设置
@JsonSerializable()
class ChangeButtonConfig {
  const ChangeButtonConfig({
    this.changeBtnIsHidden,
    this.changeBtnTitle,
    this.changeBtnTextColor,
    this.changeBtnTextSize,
    this.changeBtnFrameOffsetX,
    this.changeBtnFrameOffsetY,
  });

  factory ChangeButtonConfig.fromJson(Map<String, dynamic> json) =>
      _$ChangeButtonConfigFromJson(json);

  final bool? changeBtnIsHidden;
  final String? changeBtnTitle;
  final String? changeBtnTextColor;
  final int? changeBtnTextSize;
  final double? changeBtnFrameOffsetX;
  final double? changeBtnFrameOffsetY;

  Map<String, dynamic> toJson() => _$ChangeButtonConfigToJson(this);

  @override
  String toString() {
    return 'ChangeButtonConfig{changeBtnIsHidden: $changeBtnIsHidden, changeBtnTitle: $changeBtnTitle, changeBtnTextColor: $changeBtnTextColor, changeBtnTextSize: $changeBtnTextSize, changeBtnFrameOffsetX: $changeBtnFrameOffsetX, changeBtnFrameOffsetY: $changeBtnFrameOffsetY}';
  }
}

/// check box 设置
@JsonSerializable()
class CheckBoxConfig {
  const CheckBoxConfig({
    this.checkBoxIsChecked,
    this.checkBoxIsHidden,
    this.checkedImage,
    this.uncheckImage,
    this.checkBoxWH,
  });

  factory CheckBoxConfig.fromJson(Map<String, dynamic> json) =>
      _$CheckBoxConfigFromJson(json);

  final bool? checkBoxIsChecked;
  final bool? checkBoxIsHidden;
  final String? checkedImage;
  final String? uncheckImage;
  final double? checkBoxWH;

  Map<String, dynamic> toJson() => _$CheckBoxConfigToJson(this);

  @override
  String toString() {
    return 'CheckBoxConfig{checkBoxIsChecked: $checkBoxIsChecked, checkBoxIsHidden: $checkBoxIsHidden, checkedImage: $checkedImage, uncheckImage: $uncheckImage, checkBoxWH: $checkBoxWH}';
  }
}

@JsonSerializable()
class PrivacyConfig {
  const PrivacyConfig({
    this.privacyOneName,
    this.privacyOneUrl,
    this.privacyConnectTexts,
    this.privacyFontColor,
    this.privacyFontSize,
    this.privacyFrameOffsetX,
    this.privacyFrameOffsetY,
    this.privacyOperatorIndex,
    this.privacyOperatorPreText,
    this.privacyOperatorSufText,
    this.privacyPreText,
    this.privacySufText,
    this.privacyThreeName,
    this.privacyThreeUrl,
    this.privacyTwoName,
    this.privacyTwoUrl,
  });

  factory PrivacyConfig.fromJson(Map<String, dynamic> json) =>
      _$PrivacyConfigFromJson(json);

  final String? privacyOneName;
  final String? privacyOneUrl;
  final String? privacyTwoName;
  final String? privacyTwoUrl;
  final String? privacyThreeName;
  final String? privacyThreeUrl;
  final int? privacyFontSize;
  final String? privacyFontColor;
  final double? privacyFrameOffsetX;
  final double? privacyFrameOffsetY;

  /// 协议名称之间连接字符串数组，默认 [和, 、, 、] ，即第一个为「和」，其他为「、」，
  /// 按顺序读取，为空则取默认 [和, 和]
  final String? privacyConnectTexts;

  /// 协议文案支持居中、居左、居右设置，默认居左
  final String? privacyPreText;
  final String? privacySufText;

  ///协议整体文案，后缀部分文案
  final String? privacyOperatorPreText;

  ///协议整体文案，后缀部分文案
  final String? privacyOperatorSufText;

  /// 运营商协议指定显示顺序，默认0，即第1个协议显示，最大值可为3，即第4个协议显示
  final int? privacyOperatorIndex;

  Map<String, dynamic> toJson() => _$PrivacyConfigToJson(this);

  @override
  String toString() {
    return 'PrivacyConfig{privacyOneName: $privacyOneName, privacyOneUrl: $privacyOneUrl, privacyTwoName: $privacyTwoName, privacyTwoUrl: $privacyTwoUrl, privacyThreeName: $privacyThreeName, privacyThreeUrl: $privacyThreeUrl, privacyFontSize: $privacyFontSize, privacyFontColor: $privacyFontColor, privacyFrameOffsetX: $privacyFrameOffsetX, privacyFrameOffsetY: $privacyFrameOffsetY, privacyConnectTexts: $privacyConnectTexts, privacyPreText: $privacyPreText, privacySufText: $privacySufText, privacyOperatorPreText: $privacyOperatorPreText, privacyOperatorSufText: $privacyOperatorSufText, privacyOperatorIndex: $privacyOperatorIndex}';
  }
}

@JsonSerializable()
class CustomViewBlock {
  const CustomViewBlock({
    required this.viewId,
    required this.offsetX,
    required this.offsetY,
    required this.width,
    required this.height,
    required this.enableTap,
    this.text,
    this.textColor,
    this.textSize,
    this.backgroundColor,
    this.image,
  });

  factory CustomViewBlock.fromJson(Map<String, dynamic> json) =>
      _$CustomViewBlockFromJson(json);

  /// 用于回调时候判断返回的 id 判断
  final int viewId;
  final String? text;
  final String? textColor;
  final double? textSize;
  final String? backgroundColor;
  final String? image;
  final double offsetX;
  final double offsetY;
  final double width;
  final double height;
  final bool enableTap;

  Map<String, dynamic> toJson() => _$CustomViewBlockToJson(this);

  @override
  String toString() {
    return 'CustomViewBlock{viewId: $viewId, text: $text, textColor: $textColor, textSize: $textSize, backgroundColor: $backgroundColor, image: $image, offsetX: $offsetX, offsetY: $offsetY, width: $width, height: $height, enableTap: $enableTap}';
  }
}

import './fusion_auth_enum.dart';

/// 登录窗口配置
class FusionAuthModel {
  /// 用于融合认证的鉴权
  /// 简易模式下该参数必传
  /// 可前往该地址获取: https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/GetFusionAuthToken
  final String? token;

  /// 方案Code
  /// 可前往该地址获取: https://dypns.console.aliyun.com/fusionSolution/All
  final String? schemeCode;

  /// /* 默认登录注册场景 */
  /// "100001"
  /// /* 默认更换手机号场景 */
  /// "100002"
  /// /* 默认重置密码场景 */
  /// "100003"
  /// /* 默认绑定新手机号场景 */
  /// "100004"
  /// /* 默认验证绑定手机号场景 */
  /// "100005"
  /// templateId 场景唯一标识 与控制台场景ID唯一对应
  final String? templateId;

  /// 是否打印log，默认开启
  final bool? logEnable;

  /// 是否初始化后立即执行登录的操作，默认false
  final bool? isDelay;

  /// 提供两种模式
  /// 简易模式还是正常模式
  /// 简易模式的情况下需要设置token为必须，默认true，正式环境简易关闭使用正常模式
  final bool? debugMode;

  final String? statusBarColor;

  final String? bottomNavColor;

  final bool? isLightColor;

  final bool? isStatusBarHidden;

  final UIFAG? statusBarUIFlag;

  final String? navColor;

  final String? navText;

  final String? navTextColor;

  final String? navReturnImgPath;

  final int? navReturnImgWidth;

  final int? navReturnImgHeight;

  final bool? navReturnHidden;

  final ScaleType? navReturnScaleType;

  final bool? navHidden;

  final String? logoImgPath;

  final bool? logoHidden;

  final String? numberColor;

  final int? numberSize;

  final bool? switchAccHidden;

  final String? switchAccTextColor;

  final String? logBtnText;

  final int? logBtnTextSize;

  final String? logBtnTextColor;

  final String? sloganTextColor;

  final String? sloganText;

  final String? logBtnBackgroundPath;

  final String? loadingImgPath;

  final int? sloganOffsetY;

  final int? logoOffsetY;

  final ScaleType? logoScaleType;

  final int? numFieldOffsetY;

  final int? numberFieldOffsetX;

  final Gravity? numberLayoutGravity;

  final int? switchOffsetY;

  final int? logBtnOffsetY;

  final int? logBtnWidth;

  final int? logBtnHeight;

  final int? logBtnOffsetX;

  final int? logBtnMarginLeftAndRight;

  final Gravity? logBtnLayoutGravity;

  final int? privacyOffsetY;

  final int? checkBoxWidth;

  final int? checkBoxHeight;

  final bool? checkboxHidden;

  final int? navTextSize;

  final int? logoWidth;

  final int? logoHeight;

  final int? switchAccTextSize;

  final String? switchAccText;

  final int? sloganTextSize;

  final bool? sloganHidden;

  final String? uncheckedImgPath;

  final String? checkedImgPath;

  final bool? privacyState;

  final int? privacyTextSize;

  final int? privacyMargin;

  final String? privacyBefore;

  final String? privacyEnd;

  final String? vendorPrivacyPrefix;

  final String? vendorPrivacySuffix;

  final int? dialogWidth;

  final int? dialogHeight;

  final bool? dialogBottom;

  final int? dialogOffsetX;

  final int? dialogOffsetY;

  final String? pageBackgroundPath;

  final String? webViewStatusBarColor;

  final String? webNavColor;

  final String? webNavTextColor;

  final int? webNavTextSize;

  final String? webNavReturnImgPath;

  final bool? webSupportedJavascript;

  final String? authPageActIn;

  final String? activityOut;

  final String? authPageActOut;

  final String? activityIn;

  final String? checkBoxShakePath;

  final int? screenOrientation;

  final bool? logBtnToastHidden;

  final int? dialogAlpha;

  final int? privacyOperatorIndex;

  final bool? privacyAlertIsNeedShow;

  final bool? privacyAlertIsNeedAutoLogin;

  final bool? tapPrivacyAlertMaskCloseAlert;

  final Gravity? privacyAlertAlignment;

  final int? privacyAlertWidth;

  final int? privacyAlertHeight;

  final int? privacyAlertOffsetX;

  final int? privacyAlertOffsetY;

  final String? privacyAlertEntryAnimation;

  final String? privacyAlertExitAnimation;

  final String? privacyAlertBackgroundColor;

  final String? privacyAlertTitleBackgroundColor;

  final double? privacyAlertAlpha;

  final double? privacyAlertMaskAlpha;

  final int? privacyAlertTitleTextSize;

  final String? privacyAlertTitleColor;

  final Gravity? privacyAlertTitleAlignment;

  final int? privacyAlertContentTextSize;

  final String? privacyAlertContentColor;

  final List<int>? privacyAlertCornerRadiusArray;
  final String? privacyAlertContentBaseColor;

  final String? privacyAlertContentBackgroundColor;

  final Gravity? privacyAlertContentAlignment;

  final String? privacyAlertBtnBackgroundImgPath;

  final String? privacyAlertBtnTextColor;

  final int? privacyAlertBtnTextSize;

  final int? privacyAlertBtnHeigth;

  final bool? privacyAlertCloseBtnShow;

  final bool? privacyAlertMaskIsNeedShow;

  final ScaleType? privacyAlertCloseScaleType;

  final int? privacyAlertCloseImgWidth;

  final int? privacyAlertCloseImgHeight;

  final bool? navUseFont;

  final bool? numberUseFont;

  final int? checkBoxMarginTop;

  final bool? swtichUseFont;

  final int? webCacheMode;

  final String? logBtnTextColorStateList;

  final bool? privacyAlertTitleTextUseFont;

  final String? privacyAlertTitleText;

  final bool? privacyAlertContentTextUseFont;

  final String? privacyAlertOwnOneColor;

  final String? privacyAlertOwnTwoColor;

  final String? privacyAlertOwnThreeColor;

  final String? privacyAlertOperatorColor;

  final String? protocolOwnOneColor;

  final String? protocolOneName;

  final String? protocolOneURL;

  final String? protocolOneColor;

  final String? protocolOwnThreeColor;

  final String? protocolOwnColor;

  final bool? protocolUseFont;

  final String? protocolThreeName;

  final String? protocolThreeURL;

  final String? protocolThreeColor;

  final String? protocolShakePath;

  final Gravity? protocolGravity;

  final String? protocolOwnTwoColor;

  final String? protocolTwoName;

  final String? protocolTwoURL;

  final String? protocolTwoColor;

  final String? protocolColor;

  final Gravity? protocolLayoutGravity;

  final String? privacyAlertBefore;

  final bool? tapAuthPageMaskClosePage;

  final String? privacyAlertEnd;

  final String? privacyAlertBtnTextColorStateList;

  final List<int>? privacyAlertBtnGrivaty;

  final int? privacyAlertBtnOffsetX;

  final int? privacyAlertBtnOffsetY;

  final String? privacyAlertBtnText;

  final bool? privacyAlertBtnUseFont;

  final int? privacyAlertBtnHorizontalMargin;

  final int? privacyAlertBtnVerticalMargin;

  const FusionAuthModel({
    this.token,
    this.schemeCode,
    this.templateId,
    this.logEnable,
    this.checkBoxShakePath,
    this.checkBoxMarginTop,
    this.navUseFont,
    this.numberUseFont,
    this.swtichUseFont,
    this.webCacheMode,
    this.debugMode = true,
    this.isDelay = false,
    this.statusBarColor,
    this.bottomNavColor,
    this.isLightColor,
    this.isStatusBarHidden,
    this.statusBarUIFlag,
    this.navColor,
    this.navText,
    this.navTextSize,
    this.navTextColor,
    this.navReturnImgPath,
    this.navReturnImgWidth,
    this.navReturnImgHeight,
    this.navReturnHidden,
    this.navReturnScaleType,
    this.navHidden,
    this.sloganText,
    this.sloganOffsetY,
    this.sloganTextColor,
    this.sloganTextSize,
    this.sloganHidden,
    this.logoImgPath,
    this.logoHidden,
    this.logoOffsetY,
    this.logoScaleType,
    this.logoWidth,
    this.logoHeight,
    this.numberColor,
    this.numberSize,
    this.switchAccHidden,
    this.switchAccTextColor,
    this.logBtnToastHidden,
    this.logBtnText,
    this.logBtnTextSize,
    this.logBtnTextColor,
    this.logBtnOffsetY,
    this.logBtnWidth,
    this.logBtnHeight,
    this.logBtnOffsetX,
    this.logBtnBackgroundPath,
    this.logBtnTextColorStateList,
    this.logBtnMarginLeftAndRight,
    this.logBtnLayoutGravity,
    this.protocolOneName,
    this.protocolOneURL,

    /// 授权页协议1文本颜色。
    this.protocolOwnOneColor,
    this.protocolTwoName,
    this.protocolTwoURL,

    /// 授权页协议2文本颜色。
    this.protocolOwnTwoColor,
    this.protocolThreeName,
    this.protocolThreeURL,

    /// 授权页协议3文本颜色。
    this.protocolOwnThreeColor,
    this.protocolColor,
    this.protocolLayoutGravity,
    this.protocolUseFont,
    this.protocolOneColor,
    this.protocolTwoColor,
    this.protocolShakePath,
    this.protocolThreeColor,

    /// 授权页运营商协议文本颜色。
    this.protocolOwnColor,
    this.loadingImgPath,
    this.numFieldOffsetY,
    this.numberFieldOffsetX,
    this.numberLayoutGravity,
    this.switchOffsetY,
    this.checkBoxWidth,
    this.checkBoxHeight,
    this.checkboxHidden,
    this.switchAccTextSize,
    this.switchAccText,
    this.uncheckedImgPath,
    this.checkedImgPath,
    this.vendorPrivacyPrefix,
    this.vendorPrivacySuffix,
    this.tapAuthPageMaskClosePage = false,
    this.dialogWidth,
    this.dialogHeight,
    this.dialogBottom,
    this.dialogOffsetX,
    this.dialogOffsetY,
    this.pageBackgroundPath,
    this.webViewStatusBarColor,
    this.webNavColor,
    this.webNavTextColor,
    this.webNavTextSize,
    this.webNavReturnImgPath,
    this.webSupportedJavascript,
    this.authPageActIn,
    this.activityOut,
    this.authPageActOut,
    this.activityIn,
    this.screenOrientation,
    this.dialogAlpha,
    this.privacyOffsetY,
    this.privacyState,
    this.protocolGravity,
    this.privacyTextSize,
    this.privacyMargin,
    this.privacyBefore,
    this.privacyEnd,
    this.privacyAlertTitleTextUseFont,
    this.privacyAlertTitleText,
    this.privacyAlertContentTextUseFont,
    this.privacyAlertBefore,
    this.privacyAlertEnd,
    this.privacyAlertBtnTextColorStateList,
    this.privacyAlertBtnGrivaty,
    this.privacyAlertBtnOffsetX,
    this.privacyAlertBtnOffsetY,
    this.privacyAlertBtnText,
    this.privacyAlertBtnUseFont,
    this.privacyAlertBtnHorizontalMargin,
    this.privacyAlertBtnVerticalMargin,
    this.privacyOperatorIndex,
    /**
     * "assets/background_gif.gif"
     * "assets/background_gif1.gif"
     * "assets/background_gif2.gif"
     * "assets/background_image.jpeg"
     * "assets/background_video.mp4"
     *
     * "https://upfile.asqql.com/2009pasdfasdfic2009s305985-ts/2018-7/20187232061776607.gif"
     * "https://img.zcool.cn/community/01dda35912d7a3a801216a3e3675b3.gif",
     */
    this.privacyAlertIsNeedShow = false,
    this.privacyAlertIsNeedAutoLogin = true,
    this.privacyAlertMaskIsNeedShow = true,
    this.privacyAlertMaskAlpha = 0.3,
    this.privacyAlertAlpha = 0.2,
    this.privacyAlertBackgroundColor,
    this.privacyAlertEntryAnimation,
    this.privacyAlertExitAnimation,
    this.privacyAlertAlignment,
    this.privacyAlertWidth,
    this.privacyAlertHeight,
    this.privacyAlertOffsetX,
    this.privacyAlertOffsetY,
    this.privacyAlertTitleBackgroundColor,
    this.privacyAlertTitleAlignment,
    this.privacyAlertTitleTextSize = 18,
    this.privacyAlertTitleColor,
    this.privacyAlertContentBackgroundColor,
    this.privacyAlertContentTextSize = 16,
    this.privacyAlertContentAlignment,
    this.privacyAlertContentColor,
    this.privacyAlertCornerRadiusArray,
    this.privacyAlertContentBaseColor,
    this.privacyAlertBtnBackgroundImgPath,
    this.privacyAlertBtnTextColor,
    this.privacyAlertBtnTextSize = 18,
    this.privacyAlertBtnHeigth,
    this.privacyAlertCloseBtnShow,
    this.privacyAlertCloseScaleType,
    this.privacyAlertCloseImgWidth,
    this.privacyAlertCloseImgHeight,

    /// 授权页协议1文本颜色。
    this.privacyAlertOwnOneColor,

    /// 授权页协议2文本颜色。
    this.privacyAlertOwnTwoColor,

    /// 授权页协议3文本颜色。
    this.privacyAlertOwnThreeColor,

    /// 授权页运营商协议文本颜色。
    this.privacyAlertOperatorColor,
    this.tapPrivacyAlertMaskCloseAlert = true,
  })  : assert(debugMode == true && (token == null || token == "")),
        assert(isDelay != null);

  Map<String, dynamic> toJson() => _$FusionAuthModelToJson(this);
}

Map<String, dynamic> _$FusionAuthModelToJson(FusionAuthModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'templateId': instance.templateId,
      'debugMode': instance.debugMode,
      'isDelay': instance.isDelay,
      'statusBarColor': instance.statusBarColor,
      'bottomNavColor': instance.bottomNavColor,
      'isLightColor': instance.isLightColor,
      'isStatusBarHidden': instance.isStatusBarHidden,
      'statusBarUIFlag': EnumUtils.formatUiFagValue(instance.statusBarUIFlag),
      'navColor': instance.navColor,
      'navText': instance.navText,
      'navTextColor': instance.navTextColor,
      'navReturnImgPath': instance.navReturnImgPath,
      'navReturnImgWidth': instance.navReturnImgWidth,
      'navReturnImgHeight': instance.navReturnImgHeight,
      'navReturnHidden': instance.navReturnHidden,
      'navReturnScaleType': instance.navReturnScaleType?.index ?? 0,
      'navHidden': instance.navHidden,
      'logoImgPath': instance.logoImgPath,
      'logoHidden': instance.logoHidden,
      'numberColor': instance.numberColor,
      'numberSize': instance.numberSize,
      'switchAccHidden': instance.switchAccHidden,
      'switchAccTextColor': instance.switchAccTextColor,
      'logBtnText': instance.logBtnText,
      'logBtnTextSize': instance.logBtnTextSize,
      'logBtnTextColor': instance.logBtnTextColor,
      'sloganTextColor': instance.sloganTextColor,
      'protocolOwnColor': instance.protocolOwnColor,
      'protocolOwnOneColor': instance.protocolOwnOneColor,
      'protocolOwnTwoColor': instance.protocolOwnTwoColor,
      'sloganText': instance.sloganText,
      'logBtnBackgroundPath': instance.logBtnBackgroundPath,
      'loadingImgPath': instance.loadingImgPath,
      'sloganOffsetY': instance.sloganOffsetY,
      'logoOffsetY': instance.logoOffsetY,
      'logoScaleType': instance.logoScaleType?.index ?? 2,
      'numFieldOffsetY': instance.numFieldOffsetY,
      'numberFieldOffsetX': instance.numberFieldOffsetX,
      'numberLayoutGravity':
          EnumUtils.formatGravityValue(instance.numberLayoutGravity),
      'switchOffsetY': instance.switchOffsetY,
      'logBtnOffsetY': instance.logBtnOffsetY,
      'logBtnWidth': instance.logBtnWidth,
      'logBtnHeight': instance.logBtnHeight,
      'logBtnOffsetX': instance.logBtnOffsetX,
      'logBtnMarginLeftAndRight': instance.logBtnMarginLeftAndRight,
      'logBtnLayoutGravity':
          EnumUtils.formatGravityValue(instance.logBtnLayoutGravity),
      'checkBoxWidth': instance.checkBoxWidth,
      'checkBoxHeight': instance.checkBoxHeight,
      'checkboxHidden': instance.checkboxHidden,
      'navTextSize': instance.navTextSize,
      'logoWidth': instance.logoWidth,
      'logoHeight': instance.logoHeight,
      'switchAccTextSize': instance.switchAccTextSize,
      'switchAccText': instance.switchAccText,
      'sloganTextSize': instance.sloganTextSize,
      'sloganHidden': instance.sloganHidden,
      'uncheckedImgPath': instance.uncheckedImgPath,
      'checkedImgPath': instance.checkedImgPath,
      'vendorPrivacyPrefix': instance.vendorPrivacyPrefix,
      'vendorPrivacySuffix': instance.vendorPrivacySuffix,
      'tapAuthPageMaskClosePage': instance.tapAuthPageMaskClosePage ?? false,
      'dialogWidth': instance.dialogWidth,
      'dialogHeight': instance.dialogHeight,
      'dialogBottom': instance.dialogBottom,
      'dialogOffsetX': instance.dialogOffsetX,
      'dialogOffsetY': instance.dialogOffsetY,
      'dialogAlpha': instance.dialogAlpha,
      'webViewStatusBarColor': instance.webViewStatusBarColor,
      'webNavColor': instance.webNavColor,
      'webNavTextColor': instance.webNavTextColor,
      'webNavTextSize': instance.webNavTextSize,
      'webNavReturnImgPath': instance.webNavReturnImgPath,
      'webSupportedJavascript': instance.webSupportedJavascript,
      'authPageActIn': instance.authPageActIn,
      'activityOut': instance.activityOut,
      'authPageActOut': instance.authPageActOut,
      'activityIn': instance.activityIn,
      'screenOrientation': instance.screenOrientation,
      'logBtnToastHidden': instance.logBtnToastHidden,
      'pageBackgroundPath': instance.pageBackgroundPath,
      'protocolOneName': instance.protocolOneName,
      'protocolOneURL': instance.protocolOneURL,
      'protocolTwoName': instance.protocolTwoName,
      'protocolTwoURL': instance.protocolTwoURL,
      'protocolColor': instance.protocolColor,
      'protocolLayoutGravity':
          EnumUtils.formatGravityValue(instance.protocolLayoutGravity),
      'protocolThreeName': instance.protocolThreeName,
      'protocolThreeURL': instance.protocolThreeURL,
      'protocolGravity': EnumUtils.formatGravityValue(instance.protocolGravity),
      'privacyState': instance.privacyState,
      'privacyOffsetY': instance.privacyOffsetY,
      'privacyTextSize': instance.privacyTextSize,
      'privacyMargin': instance.privacyMargin,
      'privacyBefore': instance.privacyBefore,
      'privacyEnd': instance.privacyEnd,
      'privacyOperatorIndex': instance.privacyOperatorIndex,
      'privacyAlertIsNeedShow': instance.privacyAlertIsNeedShow,
      'privacyAlertIsNeedAutoLogin': instance.privacyAlertIsNeedAutoLogin,
      'privacyAlertMaskIsNeedShow': instance.privacyAlertMaskIsNeedShow,
      'privacyAlertMaskAlpha': instance.privacyAlertMaskAlpha,
      'privacyAlertAlpha': instance.privacyAlertAlpha,
      'privacyAlertBackgroundColor': instance.privacyAlertBackgroundColor,
      'privacyAlertEntryAnimation': instance.privacyAlertEntryAnimation,
      'privacyAlertExitAnimation': instance.privacyAlertExitAnimation,
      'privacyAlertAlignment':
          EnumUtils.formatGravityValue(instance.privacyAlertAlignment),
      'privacyAlertWidth': instance.privacyAlertWidth,
      'privacyAlertHeight': instance.privacyAlertHeight,
      'privacyAlertOffsetX': instance.privacyAlertOffsetX,
      'privacyAlertOffsetY': instance.privacyAlertOffsetY,
      'privacyAlertTitleBackgroundColor':
          instance.privacyAlertTitleBackgroundColor,
      'privacyAlertTitleAlignment':
          EnumUtils.formatGravityValue(instance.privacyAlertTitleAlignment),
      'privacyAlertTitleTextSize': instance.privacyAlertTitleTextSize,
      'privacyAlertTitleColor': instance.privacyAlertTitleColor,
      'privacyAlertContentBackgroundColor':
          instance.privacyAlertContentBackgroundColor,
      'privacyAlertContentTextSize': instance.privacyAlertContentTextSize,
      'privacyAlertContentAlignment':
          EnumUtils.formatGravityValue(instance.privacyAlertContentAlignment),
      'privacyAlertContentColor': instance.privacyAlertContentColor,
      'privacyAlertCornerRadiusArray': instance.privacyAlertCornerRadiusArray,
      'privacyAlertContentBaseColor': instance.privacyAlertContentBaseColor,
      'privacyAlertBtnBackgroundImgPath':
          instance.privacyAlertBtnBackgroundImgPath,
      'privacyAlertBtnTextColor': instance.privacyAlertBtnTextColor,
      'privacyAlertBtnTextSize': instance.privacyAlertBtnTextSize,
      'privacyAlertBtnHeigth': instance.privacyAlertBtnHeigth,
      'privacyAlertCloseBtnShow': instance.privacyAlertCloseBtnShow,
      'privacyAlertCloseScaleType':
          instance.privacyAlertCloseScaleType?.index ?? 0,
      'privacyAlertCloseImgWidth': instance.privacyAlertCloseImgWidth,
      'privacyAlertCloseImgHeight': instance.privacyAlertCloseImgHeight,
      'privacyAlertOwnOneColor': instance.privacyAlertOwnOneColor,
      'privacyAlertOwnTwoColor': instance.privacyAlertOwnTwoColor,
      'privacyAlertOwnThreeColor': instance.privacyAlertOwnThreeColor,
      'tapPrivacyAlertMaskCloseAlert': instance.tapPrivacyAlertMaskCloseAlert,
    };

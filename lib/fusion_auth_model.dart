import 'fusion_auth_enum.dart';

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

  final String? statusBarColor; /// = FusionNumberAuthModel.DEFAULT_STATUS_BAR_COLOR;
  final String? bottomNavColor; /// = FusionNumberAuthModel.DEFAULT_BOTTOM_NAV_COLOR;
  final bool? isLightColor; /// = false;
  final bool? isStatusBarHidden; /// = false;
  final UIFAG? statusBarUIFlag; /// = -1;
  final String? navColor; /// = FusionNumberAuthModel.DEFAULT_NAV_COLOR;
  final String? navText; /// = "免密登录";
  final String? navTextColor; /// = FusionNumberAuthModel.DEFAULT_NAV_TEXT_COLOR;
  final String? navReturnImgPath; /// = "authsdk_return_bg";
  final int? navReturnImgWidth; /// = 30;
  final int? navReturnImgHeight; /// = 30;
  final bool? navReturnHidden; /// = false;
  final ScaleType? navReturnScaleType; /// = ScaleType.CENTER;
  final bool? navHidden; /// = false;
  final String? logoImgPath; /// = null;
  final bool? logoHidden; /// = false;
  final String? numberColor; /// = FusionNumberAuthModel.DEFAULT_NUMBER_COLOR;
  final int? numberSize; /// = 28;
  final bool? switchAccHidden; /// = false;
  final String? switchAccTextColor; /// = FusionNumberAuthModel.DEFAULT_SWITCH_ACC_TEXT_COLOR;
  final String? logBtnText; /// = "一键登录";
  final int? logBtnTextSize; /// = 16;
  final String? logBtnTextColor; /// = FusionNumberAuthModel.DEFAULT_LOGIN_BTN_TEXT_COLOR;
  final String? sloganTextColor; /// = FusionNumberAuthModel.DEFAULT_SLOGAN_TEXT_COLOR;
  final String? sloganText; /// = null;
  final String? logBtnBackgroundPath; /// = "authsdk_dialog_login_btn_bg";
  final String? loadingImgPath; /// = "authsdk_waiting_icon";
  final int? sloganOffsetY; /// = -1;
  final int? logoOffsetY; /// = -1;
  final ScaleType? logoScaleType; /// = ScaleType.FIT_XY;
  final int? numFieldOffsetY; /// = -1;
  final int? numberFieldOffsetX; /// = 0;
  final Gravity? numberLayoutGravity; /// = 1;
  final int? switchOffsetY; /// = -1;
  final int? logBtnOffsetY; /// = -1;
  final int? logBtnWidth; /// = -1;
  final int? logBtnHeight; /// = 51;
  final int? logBtnOffsetX; /// = 0;
  final int? logBtnMarginLeftAndRight; /// = 28;
  final Gravity? logBtnLayoutGravity; /// = 1;
  final int? privacyOffsetY; /// = -1;
  final int? checkBoxWidth; /// = 18;
  final int? checkBoxHeight; /// = 18;
  final bool? checkboxHidden; /// = false;
  final int? navTextSize; /// = 18;
  final int? logoWidth; /// = 90;
  final int? logoHeight; /// = 90;
  final int? switchAccTextSize; /// = 16;
  final String? switchAccText; /// = "切换到其他方式";
  final int? sloganTextSize; /// = 16;
  final bool? sloganHidden; /// = false;
  final String? uncheckedImgPath; /// = "authsdk_checkbox_uncheck_bg";
  final String? checkedImgPath; /// = "authsdk_checkbox_checked_bg";
  final bool? privacyState; /// = false;
  final int? privacyTextSize; /// = 12;
  final int? privacyMargin; /// = 28;
  final String? privacyBefore; /// = "";
  final String? privacyEnd; /// = "";
  final String? vendorPrivacyPrefix; /// = "";
  final String? vendorPrivacySuffix; /// = "";
  final int? dialogWidth; /// = -1;
  final int? dialogHeight; /// = -1;
  final bool? dialogBottom; /// = false;
  final int? dialogOffsetX; /// = 0;
  final int? dialogOffsetY; /// = 0;
  final String? pageBackgroundPath; /// = null;
  final String? webViewStatusBarColor; /// = FusionNumberAuthModel.DEFAULT_WEB_STATUS_BAR_COLOR;
  final String? webNavColor; /// = FusionNumberAuthModel.DEFAULT_WEB_NAV_COLOR;
  final String? webNavTextColor; /// = FusionNumberAuthModel.DEFAULT_WEB_NAV_TEXT_COLOR;
  final int? webNavTextSize; /// = -1;
  final String? webNavReturnImgPath; /// = null;
  final bool? webSupportedJavascript; /// = true;
  final String? authPageActIn; /// = null;
  final String? activityOut; /// = null;
  final String? authPageActOut; /// = null;
  final String? activityIn; /// = null;
  final String? checkBoxShakePath; /// = null;
  final int? screenOrientation; /// = -3;
  final bool? logBtnToastHidden; /// = false;
  final int? dialogAlpha; /// = -1.0F;
  final int? privacyOperatorIndex; /// = 0;
  final bool? privacyAlertIsNeedShow; /// = false;
  final bool? privacyAlertIsNeedAutoLogin; /// = true;
  final bool? tapPrivacyAlertMaskCloseAlert; /// = true;
  final Gravity? privacyAlertAlignment; /// = 17;
  final int? privacyAlertWidth; /// = 160;
  final int? privacyAlertHeight; /// = 90;
  final int? privacyAlertOffsetX; /// = 0;
  final int? privacyAlertOffsetY; /// = 0;
  final String? privacyAlertEntryAnimation; /// = null;
  final String? privacyAlertExitAnimation; /// = null;
  final String? privacyAlertBackgroundColor; /// = Color.parseColor("#FFFFFF");
  final String? privacyAlertTitleBackgroundColor; /// = -1;
  final double? privacyAlertAlpha; /// = 1.0F;
  final double? privacyAlertMaskAlpha; /// = 0.3F;
  final int? privacyAlertTitleTextSize; /// = 18;
  final String? privacyAlertTitleColor; /// = -16777216;
  final Gravity? privacyAlertTitleAlignment; /// = 17;
  final int? privacyAlertContentTextSize; /// = 16;
  final String? privacyAlertContentColor; /// = 0;
  final List<int>?privacyAlertCornerRadiusArray;
  final String? privacyAlertContentBaseColor; /// = 0;
  final String? privacyAlertContentBackgroundColor; /// = -1;
  final Gravity? privacyAlertContentAlignment; /// = 3;
  final String? privacyAlertBtnBackgroundImgPath; /// = null;
  final String? privacyAlertBtnTextColor; /// = -16777216;
  final int? privacyAlertBtnTextSize; /// = 18;
  final int? privacyAlertBtnHeigth; /// = 60;
  final bool? privacyAlertCloseBtnShow; /// = true;
  final bool? privacyAlertMaskIsNeedShow; /// = true;
  final ScaleType? privacyAlertCloseScaleType; /// = ScaleType.CENTER;
  final int? privacyAlertCloseImgWidth; /// = 30;
  final int? privacyAlertCloseImgHeight; /// = 30;
  final bool? navUseFont; /// = false;
  final bool? numberUseFont; /// = false;
  final int? checkBoxMarginTop; /// = 0;
  final bool? swtichUseFont; /// = false;
  final int? webCacheMode; /// = -1;
  final String? logBtnTextColorStateList; /// = null;
  final bool? privacyAlertTitleTextUseFont; /// = false;
  final String? privacyAlertTitleText; /// = "请阅读并同意以下条款";
  final bool? privacyAlertContentTextUseFont; /// = false;
  final String? privacyAlertOwnOneColor; /// = 0;
  final String? privacyAlertOwnTwoColor; /// = 0;
  final String? privacyAlertOwnThreeColor; /// = 0;
  final String? privacyAlertOperatorColor; /// = 0;
  final String? protocolOwnOneColor; /// = 0;
  final String? protocolOneName; /// = null;
  final String? protocolOneURL; /// = null;
  final String? protocolOneColor; /// = FusionNumberAuthModel.DEFAULT_PROTOCOL_ONE_COLOR;
  final String? protocolOwnThreeColor; /// = 0;
  final String? protocolOwnColor; /// = 0;
  final bool? protocolUseFont; /// = false;
  final String? protocolThreeName; /// = null;
  final String? protocolThreeURL; /// = null;
  final String? protocolThreeColor; /// = FusionNumberAuthModel.DEFAULT_PROTOCOL_THREE_COLOR;
  final String? protocolShakePath; /// = null;
  final Gravity? protocolGravity; /// = 17;
  final String? protocolOwnTwoColor; /// = 0;
  final String? protocolTwoName; /// = null;
  final String? protocolTwoURL; /// = null;
  final String? protocolTwoColor; /// = FusionNumberAuthModel.DEFAULT_PROTOCOL_TWO_COLOR;
  final String? protocolColor; /// = FusionNumberAuthModel.DEFAULT_PROTOCOL_COLOR;
  final Gravity? protocolLayoutGravity; /// = 1;
  final String? privacyAlertBefore; /// = "";
  final bool? tapAuthPageMaskClosePage; /// = false;
  final String? privacyAlertEnd; /// = "";
  final String? privacyAlertBtnTextColorStateList; /// = null;
  final List<int>? privacyAlertBtnGrivaty; /// = new int[]{13};
  final int? privacyAlertBtnOffsetX; /// = -1;
  final int? privacyAlertBtnOffsetY; /// = -1;
  final String? privacyAlertBtnText; /// = "同意并继续";
  final bool? privacyAlertBtnUseFont; /// = false;
  final int? privacyAlertBtnHorizontalMargin; /// = 0;
  final int? privacyAlertBtnVerticalMargin; /// = 0;

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
    this.tapAuthPageMaskClosePage=false,
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

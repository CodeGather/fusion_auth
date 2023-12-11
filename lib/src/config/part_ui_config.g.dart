// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_ui_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackgroundConfig _$BackgroundConfigFromJson(Map<String, dynamic> json) =>
    BackgroundConfig(
      backgroundColor: json['backgroundColor'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      backgroundImageContentMode: $enumDecodeNullable(
          _$ImageContentModeEnumMap, json['backgroundImageContentMode']),
    );

Map<String, dynamic> _$BackgroundConfigToJson(BackgroundConfig instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'backgroundImage': instance.backgroundImage,
      'backgroundImageContentMode':
          _$ImageContentModeEnumMap[instance.backgroundImageContentMode],
    };

const _$ImageContentModeEnumMap = {
  ImageContentMode.scaleToFill: 'scaleToFill',
  ImageContentMode.scaleAspectFit: 'scaleAspectFit',
  ImageContentMode.scaleAspectFill: 'scaleAspectFill',
  ImageContentMode.redraw: 'redraw',
  ImageContentMode.center: 'center',
  ImageContentMode.top: 'top',
  ImageContentMode.bottom: 'bottom',
  ImageContentMode.left: 'left',
  ImageContentMode.right: 'right',
  ImageContentMode.topLeft: 'topLeft',
  ImageContentMode.topRight: 'topRight',
  ImageContentMode.bottomLeft: 'bottomLeft',
  ImageContentMode.bottomRight: 'bottomRight',
};

NavStatusBarConfig _$NavStatusBarConfigFromJson(Map<String, dynamic> json) =>
    NavStatusBarConfig(
      prefersStatusBarHidden: json['prefersStatusBarHidden'] as bool?,
      preferredStatusBarStyle: json['preferredStatusBarStyle'] as String?,
    );

Map<String, dynamic> _$NavStatusBarConfigToJson(NavStatusBarConfig instance) =>
    <String, dynamic>{
      'prefersStatusBarHidden': instance.prefersStatusBarHidden,
      'preferredStatusBarStyle': instance.preferredStatusBarStyle,
    };

NavConfig _$NavConfigFromJson(Map<String, dynamic> json) => NavConfig(
      navIsHidden: json['navIsHidden'] as bool?,
      navTitle: json['navTitle'] as String?,
      navTitleColor: json['navTitleColor'] as String?,
      navTitleSize: json['navTitleSize'] as int?,
      navFrameOffsetX: (json['navFrameOffsetX'] as num?)?.toDouble(),
      navFrameOffsetY: (json['navFrameOffsetY'] as num?)?.toDouble(),
      navColor: json['navColor'] as String?,
      hideNavBackItem: json['hideNavBackItem'] as bool?,
      navBackImage: json['navBackImage'] as String?,
      navBackButtonOffsetX: (json['navBackButtonOffsetX'] as num?)?.toDouble(),
      navBackButtonOffsetY: (json['navBackButtonOffsetY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NavConfigToJson(NavConfig instance) => <String, dynamic>{
      'navIsHidden': instance.navIsHidden,
      'navTitle': instance.navTitle,
      'navTitleColor': instance.navTitleColor,
      'navTitleSize': instance.navTitleSize,
      'navFrameOffsetX': instance.navFrameOffsetX,
      'navFrameOffsetY': instance.navFrameOffsetY,
      'navColor': instance.navColor,
      'hideNavBackItem': instance.hideNavBackItem,
      'navBackImage': instance.navBackImage,
      'navBackButtonOffsetX': instance.navBackButtonOffsetX,
      'navBackButtonOffsetY': instance.navBackButtonOffsetY,
    };

AlertTitleBarConfig _$AlertTitleBarConfigFromJson(Map<String, dynamic> json) =>
    AlertTitleBarConfig(
      alertBarIsHidden: json['alertBarIsHidden'] as bool?,
      alertCloseItemIsHidden: json['alertCloseItemIsHidden'] as bool?,
      alertTitleBarColor: json['alertTitleBarColor'] as String?,
      alertTitleText: json['alertTitleText'] as String?,
      alertTitleTextColor: json['alertTitleTextColor'] as String?,
      alertTittleTextSize: json['alertTittleTextSize'] as int?,
      alertCloseImage: json['alertCloseImage'] as String?,
      alertCloseImageOffsetY:
          (json['alertCloseImageOffsetY'] as num?)?.toDouble(),
      alertCloseImageOffsetX:
          (json['alertCloseImageOffsetX'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AlertTitleBarConfigToJson(
        AlertTitleBarConfig instance) =>
    <String, dynamic>{
      'alertBarIsHidden': instance.alertBarIsHidden,
      'alertCloseItemIsHidden': instance.alertCloseItemIsHidden,
      'alertTitleBarColor': instance.alertTitleBarColor,
      'alertTitleText': instance.alertTitleText,
      'alertTitleTextColor': instance.alertTitleTextColor,
      'alertTittleTextSize': instance.alertTittleTextSize,
      'alertCloseImage': instance.alertCloseImage,
      'alertCloseImageOffsetX': instance.alertCloseImageOffsetX,
      'alertCloseImageOffsetY': instance.alertCloseImageOffsetY,
    };

LogoConfig _$LogoConfigFromJson(Map<String, dynamic> json) => LogoConfig(
      logoIsHidden: json['logoIsHidden'] as bool? ?? false,
      logoImage: json['logoImage'] as String?,
      logoWidth: (json['logoWidth'] as num?)?.toDouble(),
      logoHeight: (json['logoHeight'] as num?)?.toDouble(),
      logoFrameOffsetX: (json['logoFrameOffsetX'] as num?)?.toDouble(),
      logoFrameOffsetY: (json['logoFrameOffsetY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LogoConfigToJson(LogoConfig instance) =>
    <String, dynamic>{
      'logoIsHidden': instance.logoIsHidden,
      'logoImage': instance.logoImage,
      'logoWidth': instance.logoWidth,
      'logoHeight': instance.logoHeight,
      'logoFrameOffsetX': instance.logoFrameOffsetX,
      'logoFrameOffsetY': instance.logoFrameOffsetY,
    };

SloganConfig _$SloganConfigFromJson(Map<String, dynamic> json) => SloganConfig(
      sloganIsHidden: json['sloganIsHidden'] as bool?,
      sloganText: json['sloganText'] as String?,
      sloganTextColor: json['sloganTextColor'] as String?,
      sloganTextSize: json['sloganTextSize'] as int?,
      sloganFrameOffsetX: (json['sloganFrameOffsetX'] as num?)?.toDouble(),
      sloganFrameOffsetY: (json['sloganFrameOffsetY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SloganConfigToJson(SloganConfig instance) =>
    <String, dynamic>{
      'sloganIsHidden': instance.sloganIsHidden,
      'sloganText': instance.sloganText,
      'sloganTextColor': instance.sloganTextColor,
      'sloganTextSize': instance.sloganTextSize,
      'sloganFrameOffsetX': instance.sloganFrameOffsetX,
      'sloganFrameOffsetY': instance.sloganFrameOffsetY,
    };

PhoneNumberConfig _$PhoneNumberConfigFromJson(Map<String, dynamic> json) =>
    PhoneNumberConfig(
      numberColor: json['numberColor'] as String?,
      numberFontSize: json['numberFontSize'] as int?,
      numberFrameOffsetX: (json['numberFrameOffsetX'] as num?)?.toDouble(),
      numberFrameOffsetY: (json['numberFrameOffsetY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PhoneNumberConfigToJson(PhoneNumberConfig instance) =>
    <String, dynamic>{
      'numberColor': instance.numberColor,
      'numberFontSize': instance.numberFontSize,
      'numberFrameOffsetX': instance.numberFrameOffsetX,
      'numberFrameOffsetY': instance.numberFrameOffsetY,
    };

LoginButtonConfig _$LoginButtonConfigFromJson(Map<String, dynamic> json) =>
    LoginButtonConfig(
      loginBtnText: json['loginBtnText'] as String?,
      loginBtnTextColor: json['loginBtnTextColor'] as String?,
      loginBtnTextSize: json['loginBtnTextSize'] as int?,
      loginBtnNormalImage: json['loginBtnNormalImage'] as String?,
      loginBtnUnableImage: json['loginBtnUnableImage'] as String?,
      loginBtnPressedImage: json['loginBtnPressedImage'] as String?,
      loginBtnFrameOffsetX: (json['loginBtnFrameOffsetX'] as num?)?.toDouble(),
      loginBtnFrameOffsetY: (json['loginBtnFrameOffsetY'] as num?)?.toDouble(),
      loginBtnWidth: (json['loginBtnWidth'] as num?)?.toDouble(),
      loginBtnHeight: (json['loginBtnHeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LoginButtonConfigToJson(LoginButtonConfig instance) =>
    <String, dynamic>{
      'loginBtnText': instance.loginBtnText,
      'loginBtnTextColor': instance.loginBtnTextColor,
      'loginBtnTextSize': instance.loginBtnTextSize,
      'loginBtnNormalImage': instance.loginBtnNormalImage,
      'loginBtnUnableImage': instance.loginBtnUnableImage,
      'loginBtnPressedImage': instance.loginBtnPressedImage,
      'loginBtnFrameOffsetX': instance.loginBtnFrameOffsetX,
      'loginBtnFrameOffsetY': instance.loginBtnFrameOffsetY,
      'loginBtnWidth': instance.loginBtnWidth,
      'loginBtnHeight': instance.loginBtnHeight,
    };

ChangeButtonConfig _$ChangeButtonConfigFromJson(Map<String, dynamic> json) =>
    ChangeButtonConfig(
      changeBtnIsHidden: json['changeBtnIsHidden'] as bool?,
      changeBtnTitle: json['changeBtnTitle'] as String?,
      changeBtnTextColor: json['changeBtnTextColor'] as String?,
      changeBtnTextSize: json['changeBtnTextSize'] as int?,
      changeBtnFrameOffsetX:
          (json['changeBtnFrameOffsetX'] as num?)?.toDouble(),
      changeBtnFrameOffsetY:
          (json['changeBtnFrameOffsetY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ChangeButtonConfigToJson(ChangeButtonConfig instance) =>
    <String, dynamic>{
      'changeBtnIsHidden': instance.changeBtnIsHidden,
      'changeBtnTitle': instance.changeBtnTitle,
      'changeBtnTextColor': instance.changeBtnTextColor,
      'changeBtnTextSize': instance.changeBtnTextSize,
      'changeBtnFrameOffsetX': instance.changeBtnFrameOffsetX,
      'changeBtnFrameOffsetY': instance.changeBtnFrameOffsetY,
    };

CheckBoxConfig _$CheckBoxConfigFromJson(Map<String, dynamic> json) =>
    CheckBoxConfig(
      checkBoxIsChecked: json['checkBoxIsChecked'] as bool?,
      checkBoxIsHidden: json['checkBoxIsHidden'] as bool?,
      checkedImage: json['checkedImage'] as String?,
      uncheckImage: json['uncheckImage'] as String?,
      checkBoxWH: (json['checkBoxWH'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CheckBoxConfigToJson(CheckBoxConfig instance) =>
    <String, dynamic>{
      'checkBoxIsChecked': instance.checkBoxIsChecked,
      'checkBoxIsHidden': instance.checkBoxIsHidden,
      'checkedImage': instance.checkedImage,
      'uncheckImage': instance.uncheckImage,
      'checkBoxWH': instance.checkBoxWH,
    };

PrivacyConfig _$PrivacyConfigFromJson(Map<String, dynamic> json) =>
    PrivacyConfig(
      privacyOneName: json['privacyOneName'] as String?,
      privacyOneUrl: json['privacyOneUrl'] as String?,
      privacyConnectTexts: json['privacyConnectTexts'] as String?,
      privacyFontColor: json['privacyFontColor'] as String?,
      privacyFontSize: json['privacyFontSize'] as int?,
      privacyFrameOffsetX: (json['privacyFrameOffsetX'] as num?)?.toDouble(),
      privacyFrameOffsetY: (json['privacyFrameOffsetY'] as num?)?.toDouble(),
      privacyOperatorIndex: json['privacyOperatorIndex'] as int?,
      privacyOperatorPreText: json['privacyOperatorPreText'] as String?,
      privacyOperatorSufText: json['privacyOperatorSufText'] as String?,
      privacyPreText: json['privacyPreText'] as String?,
      privacySufText: json['privacySufText'] as String?,
      privacyThreeName: json['privacyThreeName'] as String?,
      privacyThreeUrl: json['privacyThreeUrl'] as String?,
      privacyTwoName: json['privacyTwoName'] as String?,
      privacyTwoUrl: json['privacyTwoUrl'] as String?,
    );

Map<String, dynamic> _$PrivacyConfigToJson(PrivacyConfig instance) =>
    <String, dynamic>{
      'privacyOneName': instance.privacyOneName,
      'privacyOneUrl': instance.privacyOneUrl,
      'privacyTwoName': instance.privacyTwoName,
      'privacyTwoUrl': instance.privacyTwoUrl,
      'privacyThreeName': instance.privacyThreeName,
      'privacyThreeUrl': instance.privacyThreeUrl,
      'privacyFontSize': instance.privacyFontSize,
      'privacyFontColor': instance.privacyFontColor,
      'privacyFrameOffsetX': instance.privacyFrameOffsetX,
      'privacyFrameOffsetY': instance.privacyFrameOffsetY,
      'privacyConnectTexts': instance.privacyConnectTexts,
      'privacyPreText': instance.privacyPreText,
      'privacySufText': instance.privacySufText,
      'privacyOperatorPreText': instance.privacyOperatorPreText,
      'privacyOperatorSufText': instance.privacyOperatorSufText,
      'privacyOperatorIndex': instance.privacyOperatorIndex,
    };

CustomViewBlock _$CustomViewBlockFromJson(Map<String, dynamic> json) =>
    CustomViewBlock(
      viewId: json['viewId'] as int,
      offsetX: (json['offsetX'] as num).toDouble(),
      offsetY: (json['offsetY'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      enableTap: json['enableTap'] as bool,
      text: json['text'] as String?,
      textColor: json['textColor'] as String?,
      textSize: (json['textSize'] as num?)?.toDouble(),
      backgroundColor: json['backgroundColor'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CustomViewBlockToJson(CustomViewBlock instance) =>
    <String, dynamic>{
      'viewId': instance.viewId,
      'text': instance.text,
      'textColor': instance.textColor,
      'textSize': instance.textSize,
      'backgroundColor': instance.backgroundColor,
      'image': instance.image,
      'offsetX': instance.offsetX,
      'offsetY': instance.offsetY,
      'width': instance.width,
      'height': instance.height,
      'enableTap': instance.enableTap,
    };

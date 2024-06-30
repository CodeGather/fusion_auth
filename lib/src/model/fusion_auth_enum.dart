import 'dart:io';

/// 本机号码校验,一键登录
enum SdkType { auth, login }

/// 模式选择
enum DebugMode { simple, normal }
/// ScaleType 可选类型
enum ScaleType {
  matrix,
  fitXy,
  fitStart,
  fitCenter,
  fitEnd,
  center,
  centerCrop,
  centerInside,
}

enum Gravity { centerHorizntal, left, right }

enum ImageContentMode {
  scaleToFill,
  scaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
  scaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
  redraw,              // redraw on bounds change (calls -setNeedsDisplay)
  center,              // contents remain same size. positioned adjusted.
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

enum DialogAlignment { center, bottom }

/// 文字对齐方式
enum TextAlignment { left, center, right }

enum UIFAG {
  systemUiFalgLowProfile,
  systemUiFalgHideNavigation,
  systemUiFalgFullscreen,
  systemUiFalgLayoutStable,
  systemUiFalgLayoutHideNavigtion,
  systemUiFalgLayoutFullscreen,
  systemUiFalgImmersive,
  systemUiFalgImmersiveSticky,
  systemUiFalgLightStatusBar,
  systemUiFalgLightNavigationBar
}

enum PNSPresentationDirection {
  presentationDirectionBottom,
  presentationDirectionRight,
  presentationDirectionTop,
  presentationDirectionLeft,
}

enum PageType {
  ///全屏（竖屏）
  fullPort,
  ///全屏（横屏）
  fullLand,
  ///弹窗（竖屏）
  dialogPort,
  ///"弹窗（横屏）
  dialogLand,
  ///底部弹窗
  dialogBottom,
  ///自定义View
  customView,
  ///自定义View（Xml）
  customXml,
  /// 自定义背景GIF
  customGif,
  /// 自定义背景视频
  customMOV,
  /// 自定义背景图片
  customPIC,
}

/// 场景代码
enum SceneType {
  /// 默认登录注册场景
  login,
  /// 默认更换手机号场景
  changeMobile,
  /// 默认重置密码场景
  resetPaW,
  /// 默认绑定新手机号场景
  bandMobile,
  /// 默认验证绑定手机号场景
  verifyMobile,
}

class EnumUtils {
  static int formatGravityValue(Gravity? status) {
    switch (status) {
      case Gravity.centerHorizntal:
        return 1;
      case Gravity.left:
        if (Platform.isAndroid) {
          return 3;
        } else {
          return 0;
        }
      case Gravity.right:
        if (Platform.isAndroid) {
          return 5;
        } else {
          return 2;
        }
      default:
        return 4;
    }
  }

  static int formatUiFagValue(UIFAG? status) {
    switch (status) {
      case UIFAG.systemUiFalgLowProfile:
        return 1;
      case UIFAG.systemUiFalgHideNavigation:
        return 2;
      case UIFAG.systemUiFalgFullscreen:
        return 4;
      case UIFAG.systemUiFalgLayoutStable:
        return 256;
      case UIFAG.systemUiFalgLayoutHideNavigtion:
        return 512;
      case UIFAG.systemUiFalgLayoutFullscreen:
        return 1024;
      case UIFAG.systemUiFalgImmersive:
        return 2048;
      case UIFAG.systemUiFalgImmersiveSticky:
        return 4096;
      case UIFAG.systemUiFalgLightStatusBar:
        return 8192;
      default:
        return 16;
    }
  }

  static String formatSenceValue(SceneType? status) {
    switch (status) {
      case SceneType.login:
        return "100001";
      case SceneType.changeMobile:
        return "100002";
      case SceneType.resetPaW:
        return "100003";
      case SceneType.bandMobile:
        return "100004";
      default:
        return "100005";
    }
  }
}

/// 第三方布局实体
class CustomThirdView {
  final int? top;
  final int? right;
  final int? bottom;
  final int? left;
  final int? width;
  final int? height;
  final int? space;
  final int? size;
  final String? color;
  final int? itemWidth;
  final int? itemHeight;
  final List<String>? viewItemName;
  final List<String>? viewItemPath;
  CustomThirdView(
      this.top,
      this.right,
      this.bottom,
      this.left,
      this.width,
      this.height,
      this.space,
      this.size,
      this.color,
      this.itemWidth,
      this.itemHeight,
      this.viewItemName,
      this.viewItemPath);

  factory CustomThirdView.fromJson(Map<String, dynamic> srcJson) =>
      _$CustomThirdViewFromJson(srcJson);
  Map<String, dynamic> toJson() => _$CustomThirdViewToJson(this);
}

/// 第三方布局json转实体
CustomThirdView _$CustomThirdViewFromJson(Map<String, dynamic> json) {
  return CustomThirdView(
      json['top'],
      json['right'],
      json['bottom'],
      json['left'],
      json['width'],
      json['height'],
      json['space'],
      json['size'],
      json['color'],
      json['itemWidth'],
      json['itemHeight'],
      json['viewItemName'],
      json['viewItemPath']);
}

/// 第三方布局实体转json
Map<String, dynamic> _$CustomThirdViewToJson(CustomThirdView instance) =>
    <String, dynamic>{
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
      'left': instance.left,
      'width': instance.width,
      'height': instance.height,
      'space': instance.space,
      'size': instance.size,
      'color': instance.color,
      'itemWidth': instance.itemWidth,
      'itemHeight': instance.itemHeight,
      'viewItemName': instance.viewItemName,
      'viewItemPath': instance.viewItemPath,
    };

///  自定义布局实体
class CustomView {
  final int? top;
  final int? right;
  final int? bottom;
  final int? left;
  final int? width;
  final int? height;
  final String? imgPath;
  final ScaleType? imgScaleType;
  CustomView(this.top, this.right, this.bottom, this.left, this.width,
      this.height, this.imgPath, this.imgScaleType);

  factory CustomView.fromJson(Map<String, dynamic> srcJson) =>
      _$CustomViewFromJson(srcJson);
  Map<String, dynamic> toJson() => _$CustomViewToJson(this);
}

/// 自定义布局json转实体
CustomView _$CustomViewFromJson(Map<String, dynamic> json) {
  return CustomView(json['top'], json['right'], json['bottom'], json['left'],
      json['width'], json['height'], json['imgPath'], json['imgScaleType']);
}

/// 自定义布局实体转json
Map<String, dynamic> _$CustomViewToJson(CustomView instance) =>
    <String, dynamic>{
      'top': instance.top ?? 0,
      'right': instance.right ?? 0,
      'bottom': instance.bottom ?? 0,
      'left': instance.left ?? 0,
      'width': instance.width,
      'height': instance.height,
      'imgPath': instance.imgPath,
      'imgScaleType': (instance.imgScaleType ?? ScaleType.centerCrop).index,
    };

enum AuthResultCode {
  success('600000', '接口返回成功'),
  getOperatorInfoFailed('600004', '获取运营商配置信息失败'),

  /// 获取运营商配置信息失败
  noSIMCard('600007', '未检测到sim卡'),
  noCellularNetwork('600008', '蜂窝网络未开启或不稳定'),
  unknownOperator('600009', '无法判运营商'),
  unknownError('600010', '未知异常'),
  getTokenFailed('600011', '获取token失败'),
  getMaskPhoneFailed('600012', '预取号失败'),
  interfaceDemoted('600013', '运营商维护升级，该功能不可用'),
  interfaceLimited('600014', '运营商维护升级，该功能已达最大调用次数'),
  interfaceTimeout('600015', '接口超时'),
  getMaskPhoneSuccess('600016', '预取号成功'),
  decodeAppInfoFailed('600017', 'AppID Secret解析失败'),
  carrierChanged('600021', '运营商已切换'),
  envCheckSuccess('600024', '终端支持认证'),
  envCheckFail('600025', '终端环境检测失败（1.终端不支持认证;2.终端检测参数错误;3.初始化未成功）'),

  ///  号码认证授权页相关返回码 START
  loginControllerPresentSuccess('600001', '唤起授权页成功'),
  loginControllerPresentFailed('600002', '唤起授权页失败'),
  callPreLoginInAuthPage('600026', '授权页已加载时不允许调用加速或预取号接口'),
  loginControllerClickCancel('700000', '点击返回，⽤户取消一键登录'),
  loginControllerClickChangeBtn('700001', '点击切换按钮，⽤户取消免密登录'),
  loginControllerClickLoginBtn('700002', '点击登录按钮事件'),
  loginControllerClickCheckBoxBtn('700003', ' 点击CheckBox事件'),
  loginControllerClickProtocol('700004', '点击协议富文本文字'),

  ///  活体认证相关返回码 START
  loginClickPrivacyAlertView('700006', '点击一键登录拉起授权页二次弹窗'),
  loginPrivacyAlertViewClose('700007', '隐私协议二次弹窗关闭'),
  loginPrivacyAlertViewClickContinue('700008', '隐私协议二次弹窗点击确认并继续'),
  loginPrivacyAlertViewPrivacyContentClick('700009', '点击隐私协议二次弹窗上的协议富文本文字'),
  onCustomViewTap('700010', '用户点击了自定义控件的按钮，此时会[msg]会回调控件的viewId'),

  ///  活体认证相关返回码 START /
  failed('600030', ' 接口请求失败'),
  errorNetwork('600031', '网络错误'),
  errorClientTimestamp('600032', '客户端设备时间错误'),
  featureInvalid('600033', '功能不可用，需要到控制台开通对应功能'),
  codeSDKInfoInvalid('600034', '不合法的SDK密钥'),
  statusBusy('600035', '状态繁忙'),
  outOfService('600036', '业务停机'),
  liftBodyVerifyReadyStating('700005', '活体认证页面准备启动');

  factory AuthResultCode.fromCode(String resultCode) {
    return values.firstWhere(
      (element) => element.code == resultCode,
      orElse: () => AuthResultCode.unknownError,
    );
  }

  const AuthResultCode(this.code, this.message);

  final String code;
  final String message;
}

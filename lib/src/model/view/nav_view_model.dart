import 'package:json_annotation/json_annotation.dart';
part 'nav_view_model.g.dart';

/// 导航设置
@JsonSerializable()
class NavViewModel {
  const NavViewModel({
    this.isHidden,
    this.backgroundColor,
    this.textFontSize,
    this.textForegroundColor,
    this.textBackgroundColor,
    this.textKern
  });

  factory NavViewModel.fromJson(Map<String, dynamic> json) =>
      _$NavViewModelFromJson(json);

  /// 是否隐藏导航栏
  final bool? isHidden;

  /// 导航栏北京色
  final String? backgroundColor;

  /// 导航栏文字大小
  final int? textFontSize;

  /// 导航栏字体颜色
  final String? textForegroundColor;

  /// 导航栏字体背景色
  final String? textBackgroundColor;

  /// 导航栏文字间距
  final int? textKern;

  Map<String, dynamic> toJson() => _$NavViewModelToJson(this);
}

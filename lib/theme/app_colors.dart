import 'package:flutter/material.dart';

/// @lus の「ふわふわかわいい」カラーパレット。
///
/// ※ ピンの種別色（visited/planned/anniversary）は [PinKind] 側で定義しており、
///   ここの配色とは別物。ピンの色分けロジックは変更しないこと。
abstract final class AppColors {
  static const primaryPink = Color(0xFFFF9EC4); // メインカラー
  static const lavender = Color(0xFFC3B1E1); // アクセント
  static const peach = Color(0xFFFFB347); // 注目色
  static const backgroundCream = Color(0xFFFFF5F8); // 背景
  static const surfaceLight = Color(0xFFFFFFFF); // カード背景
  static const textDark = Color(0xFF5C4A52); // メインテキスト
  static const textLight = Color(0xFF9B8A92); // サブテキスト
  static const borderSoft = Color(0xFFFFE0EC); // 境界線
}

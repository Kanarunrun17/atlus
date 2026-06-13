import 'package:flutter/material.dart';

/// ピンの種別。DB には [value] の文字列で保存する（docs/data_model.md 参照）。
enum PinKind {
  visited('visited', '行った', Color(0xFFFF6B8A)), // ピンク
  planned('planned', '予定', Color(0xFF7B6EF6)), // ラベンダー
  anniversary('anniversary', '記念日', Color(0xFFFFB347)); // ゴールド

  const PinKind(this.value, this.label, this.color);

  final String value;
  final String label;
  final Color color;

  static PinKind fromValue(String value) =>
      PinKind.values.firstWhere((k) => k.value == value,
          orElse: () => PinKind.visited);
}

/// 提案者。DB には [value] の文字列で保存する。
enum Proposer {
  me('me', '自分', 'M'),
  partner('partner', 'パートナー', 'P');

  const Proposer(this.value, this.label, this.badge);

  final String value;
  final String label;

  /// ピンアイコン内に表示する1文字バッジ。
  final String badge;

  static Proposer fromValue(String value) =>
      Proposer.values.firstWhere((p) => p.value == value,
          orElse: () => Proposer.me);
}

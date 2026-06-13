import 'package:flutter/material.dart';

/// ピン編集・新規作成画面（共通）。F2・F6 の実装はここに入る。
/// [pinId] が null の場合は新規作成、それ以外は編集。
class PinEditScreen extends StatelessWidget {
  const PinEditScreen({super.key, this.pinId});

  final int? pinId;

  bool get isNew => pinId == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isNew ? 'ピン新規作成' : 'ピン編集')),
      body: Center(
        child: Text(
          isNew ? 'ピン新規作成画面' : 'ピン編集画面 (id: $pinId)',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

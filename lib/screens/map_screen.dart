import 'package:flutter/material.dart';

/// 地図画面（ホーム・タブ）。F1〜F3 の実装はここに入る。
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('地図画面', style: TextStyle(fontSize: 24)),
    );
  }
}

import 'package:flutter/material.dart';

/// ピン詳細画面。F5・F6 への導線を持つ。
class PinDetailScreen extends StatelessWidget {
  const PinDetailScreen({super.key, required this.pinId});

  final int pinId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ピン詳細')),
      body: Center(
        child: Text('ピン詳細画面 (id: $pinId)',
            style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

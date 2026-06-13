import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// 固定枠（既定 200×150・4:3）・角丸のサムネイル。中央配置。
///
/// 写真は [BoxFit.contain] で全体が見えるように表示し、枠との差分は
/// [AppColors.borderSoft]（薄ピンク）の余白で埋める。縦・横・正方形の
/// いずれでも枠サイズは一定。[onTap] を渡すとタップ可能になる。
class PinPhotoThumbnail extends StatelessWidget {
  const PinPhotoThumbnail({
    super.key,
    required this.bytes,
    this.onTap,
    this.width = 200,
    this.height = 150,
    this.borderRadius = 16,
  });

  final Uint8List bytes;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final thumbnail = SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ColoredBox(
          color: AppColors.borderSoft,
          child: Image.memory(
            bytes,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    final tappable =
        onTap == null ? thumbnail : GestureDetector(onTap: onTap, child: thumbnail);
    return Center(child: tappable);
  }
}

/// タップ拡大用のフルスクリーン表示。写真全体を BoxFit.contain で表示し、
/// [InteractiveViewer] でピンチズーム可能。背景／写真のタップで閉じる。
class PinPhotoDialog extends StatelessWidget {
  const PinPhotoDialog({super.key, required this.bytes});

  final Uint8List bytes;

  /// 拡大ダイアログを開く。
  static Future<void> show(BuildContext context, Uint8List bytes) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => PinPhotoDialog(bytes: bytes),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // 背景タップで閉じる。
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const ColoredBox(color: Colors.transparent),
            ),
          ),
          Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: GestureDetector(
                // 写真タップでも閉じる。
                onTap: () => Navigator.of(context).pop(),
                child: Image.memory(bytes, fit: BoxFit.contain),
              ),
            ),
          ),
          // 閉じるボタン。
          Positioned(
            top: 8,
            right: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

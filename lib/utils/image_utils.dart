import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_image_compress_platform_interface/flutter_image_compress_platform_interface.dart';
import 'package:flutter_image_compress_web/flutter_image_compress_web.dart';
import 'package:image_picker/image_picker.dart';

/// 画像選択・圧縮の結果。
class ImagePickResult {
  const ImagePickResult._({this.base64, this.error});

  /// 圧縮済み画像の Base64 文字列（成功時）。
  final String? base64;

  /// エラーメッセージ（失敗時）。
  final String? error;

  bool get isSuccess => error == null;

  const ImagePickResult.success(String base64) : this._(base64: base64);
  const ImagePickResult.failure(String error) : this._(error: error);
}

/// 長辺の最大ピクセル数。
const _maxEdge = 1024;

/// JPEG 圧縮品質。
const _quality = 80;

/// 圧縮後に許容する最大バイト数（5MB）。
const _maxBytes = 5 * 1024 * 1024;

final _picker = ImagePicker();
final _compressor = FlutterImageCompressWeb();

/// ギャラリー（Web ではファイル選択）から画像を選び、リサイズ・圧縮して
/// Base64 文字列を返す。
///
/// - ユーザーがキャンセルした場合は null を返す。
/// - 圧縮後 5MB を超える場合は [ImagePickResult.failure] を返す。
Future<ImagePickResult?> selectAndCompressImage() async {
  final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
  if (picked == null) return null; // キャンセル

  final Uint8List original = await picked.readAsBytes();

  // 長辺 1024px にリサイズ・JPEG 品質80で圧縮。
  final Uint8List compressed = await _compressor.compressWithList(
    original,
    minWidth: _maxEdge,
    minHeight: _maxEdge,
    quality: _quality,
    format: CompressFormat.jpeg,
  );

  if (compressed.lengthInBytes > _maxBytes) {
    return const ImagePickResult.failure(
      '画像サイズが大きすぎます（圧縮後5MB超）。別の画像を選んでください。',
    );
  }

  return ImagePickResult.success(base64Encode(compressed));
}

/// Base64 文字列を画像バイト列にデコードする。失敗時は null。
Uint8List? decodeBase64Image(String? base64) {
  if (base64 == null || base64.isEmpty) return null;
  try {
    return base64Decode(base64);
  } catch (_) {
    return null;
  }
}

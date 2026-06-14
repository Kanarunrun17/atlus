import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// 地図関連の定数。
///
/// v2 で対応範囲を全国へ広げる予定があるため、初期表示・範囲制限・タイル URL を
/// ここに集約しておく。
abstract final class MapConstants {
  /// 初期表示の中心（新宿あたり・東京の中心）。
  static const initialCenter = LatLng(35.6895, 139.6917);

  /// 初期ズーム。
  static const initialZoom = 12.0;

  /// ズーム下限（広げすぎて重くならないように）。
  static const minZoom = 10.0;

  /// ズーム上限。
  static const maxZoom = 18.0;

  /// 表示可能範囲（関東圏）の南西端。
  static const southWest = LatLng(34.9, 138.9);

  /// 表示可能範囲（関東圏）の北東端。
  static const northEast = LatLng(36.5, 140.3);

  /// 表示可能範囲（関東圏）。
  static final LatLngBounds bounds = LatLngBounds(southWest, northEast);

  /// CartoDB Positron - シンプルで情報量が少ない（通り名・国道などの文字が少ない）。
  /// 詳細：https://carto.com/basemaps/
  /// サブドメイン {s} は a〜d。
  static const tileUrlTemplate =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png';

  /// CartoDB タイルのサブドメイン。
  static const tileSubdomains = ['a', 'b', 'c', 'd'];
}

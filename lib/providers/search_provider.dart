import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:latlong2/latlong.dart';

import '../services/nominatim_service.dart';

/// Nominatim 検索サービス。
final nominatimServiceProvider = Provider<NominatimService>((ref) {
  return NominatimService();
});

/// 直近の検索結果（複数候補のドロップダウン表示に使う）。
final searchResultsProvider =
    StateProvider<List<GeoSearchResult>>((ref) => const []);

/// 検索中フラグ。
final searchLoadingProvider = StateProvider<bool>((ref) => false);

/// 地図に表示する選択中の境界線（行政区域のリング群）。null なら非表示。
final selectedBoundaryProvider =
    StateProvider<List<List<LatLng>>?>((ref) => null);

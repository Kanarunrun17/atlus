import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// 緯度経度の矩形範囲。UI 依存（flutter_map の LatLngBounds）を避けるための
/// サービス層用の軽量表現。画面側で LatLngBounds に変換して使う。
class GeoBounds {
  const GeoBounds({required this.southWest, required this.northEast});
  final LatLng southWest;
  final LatLng northEast;
}

/// Nominatim（OpenStreetMap）の検索結果1件。
class GeoSearchResult {
  const GeoSearchResult({
    required this.name,
    required this.shortName,
    required this.lat,
    required this.lng,
    this.bbox,
    this.polygons,
  });

  /// display_name 全体。
  final String name;

  /// display_name の先頭部分（リスト表示用）。
  final String shortName;

  final double lat;
  final double lng;

  /// boundingbox（あれば範囲フィットに使う）。
  final GeoBounds? bbox;

  /// 行政区域などの境界線（ポリゴンのリング群）。area でなければ null。
  final List<List<LatLng>>? polygons;

  /// 境界（面）を持つか。true なら枠線表示＋範囲フィット、false なら点へズーム。
  bool get isArea => polygons != null && polygons!.isNotEmpty;
}

/// Nominatim 検索 API のラッパー。
class NominatimService {
  NominatimService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _endpoint = 'https://nominatim.openstreetmap.org/search';

  /// 規約上 User-Agent は必須。
  static const _userAgent = 'atlus/1.0';

  /// [query] で検索し、結果を返す。結果なしは空リスト。
  /// [viewbox] を渡すとその矩形範囲内に検索を限定する（bounded=1）。
  /// サービス層は地図の都合を知らないため、範囲は呼び出し側が指定する。
  /// ネットワーク・タイムアウト・パースのエラーは [NominatimException] を投げる。
  Future<List<GeoSearchResult>> search(String query, {GeoBounds? viewbox}) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const [];

    final params = {
      'q': trimmed,
      'format': 'json',
      'polygon_geojson': '1',
      'countrycodes': 'jp',
      'limit': '5',
      'accept-language': 'ja',
    };
    if (viewbox != null) {
      // viewbox は west,north,east,south の順。
      params['viewbox'] = '${viewbox.southWest.longitude},'
          '${viewbox.northEast.latitude},'
          '${viewbox.northEast.longitude},'
          '${viewbox.southWest.latitude}';
      params['bounded'] = '1';
    }

    final uri = Uri.parse(_endpoint).replace(queryParameters: params);

    final http.Response response;
    try {
      response = await _client.get(
        uri,
        headers: {'User-Agent': _userAgent},
      ).timeout(const Duration(seconds: 10));
    } on Exception catch (e) {
      throw NominatimException('ネットワークエラー: $e');
    }

    if (response.statusCode != 200) {
      throw NominatimException('検索に失敗しました (HTTP ${response.statusCode})');
    }

    try {
      final List<dynamic> raw = jsonDecode(response.body) as List<dynamic>;
      return raw
          .map((e) => _parseResult(e as Map<String, dynamic>))
          .toList(growable: false);
    } on Exception catch (e) {
      throw NominatimException('結果の解析に失敗しました: $e');
    }
  }

  GeoSearchResult _parseResult(Map<String, dynamic> json) {
    final displayName = json['display_name'] as String? ?? '';
    final shortName =
        displayName.isEmpty ? '(名称不明)' : displayName.split(',').first.trim();

    final lat = double.parse(json['lat'] as String);
    final lng = double.parse(json['lon'] as String);

    return GeoSearchResult(
      name: displayName,
      shortName: shortName,
      lat: lat,
      lng: lng,
      bbox: _parseBoundingBox(json['boundingbox']),
      polygons: _parsePolygons(json['geojson']),
    );
  }

  /// Nominatim の boundingbox は ["minLat","maxLat","minLng","maxLng"]（文字列）。
  GeoBounds? _parseBoundingBox(dynamic raw) {
    if (raw is! List || raw.length < 4) return null;
    final minLat = double.tryParse(raw[0].toString());
    final maxLat = double.tryParse(raw[1].toString());
    final minLng = double.tryParse(raw[2].toString());
    final maxLng = double.tryParse(raw[3].toString());
    if (minLat == null || maxLat == null || minLng == null || maxLng == null) {
      return null;
    }
    return GeoBounds(
      southWest: LatLng(minLat, minLng),
      northEast: LatLng(maxLat, maxLng),
    );
  }

  /// geojson から境界リング群を取り出す。Polygon / MultiPolygon のみ対象。
  /// Point / LineString（駅・施設など）は null（点として扱う）。
  List<List<LatLng>>? _parsePolygons(dynamic geojson) {
    if (geojson is! Map) return null;
    final type = geojson['type'] as String?;
    final coords = geojson['coordinates'];

    switch (type) {
      case 'Polygon':
        // coordinates: [ ring[ [lng,lat], ... ], ... ]
        return _ringsFromPolygon(coords);
      case 'MultiPolygon':
        // coordinates: [ polygon[ ring[ [lng,lat], ... ] ], ... ]
        if (coords is! List) return null;
        final rings = <List<LatLng>>[];
        for (final polygon in coords) {
          final r = _ringsFromPolygon(polygon);
          if (r != null) rings.addAll(r);
        }
        return rings.isEmpty ? null : rings;
      default:
        return null;
    }
  }

  List<List<LatLng>>? _ringsFromPolygon(dynamic polygon) {
    if (polygon is! List) return null;
    final rings = <List<LatLng>>[];
    for (final ring in polygon) {
      if (ring is! List) continue;
      final points = <LatLng>[];
      for (final pt in ring) {
        if (pt is List && pt.length >= 2) {
          final lng = (pt[0] as num).toDouble();
          final lat = (pt[1] as num).toDouble();
          points.add(LatLng(lat, lng));
        }
      }
      if (points.length >= 3) rings.add(points);
    }
    return rings.isEmpty ? null : rings;
  }
}

/// Nominatim 検索のエラー。
class NominatimException implements Exception {
  const NominatimException(this.message);
  final String message;
  @override
  String toString() => message;
}

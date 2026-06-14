import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/map_constants.dart';
import '../db/database.dart';
import '../models/pin_enums.dart';
import '../providers/pins_provider.dart';
import '../providers/search_provider.dart';
import '../services/nominatim_service.dart';
import '../theme/app_colors.dart';

/// 地図画面（ホーム・タブ）。
/// F1：地図表示（CartoDB Positron・関東圏に範囲制限）、
/// F2：ロングタップでピン追加、F3：kind による色分け、F4：proposer バッジ表示。
/// 加えて、Nominatim による場所検索（県・区は境界線表示、駅・施設は点ズーム）。
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final _mapController = MapController();
  final _searchController = TextEditingController();

  /// Nominatim の利用ポリシー（最大1req/秒）に配慮した検索デバウンス。
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // クリアボタンの表示切り替えのため、入力変化で再描画する。
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _onLongPress(LatLng point) {
    context.push('/pin/new?lat=${point.latitude}&lng=${point.longitude}');
  }

  /// 検索バー送信時。1秒のデバウンスをかけて実行（連続リクエスト防止）。
  void _onSubmitted(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () => _runSearch(query));
  }

  Future<void> _runSearch(String query) async {
    if (query.trim().isEmpty) return;
    final messenger = ScaffoldMessenger.of(context);
    ref.read(searchLoadingProvider.notifier).state = true;
    try {
      // 検索範囲を地図の表示制限（関東圏）と同じ範囲に限定する。
      // 範囲は MapConstants に集約されており、変更すれば検索も連動する。
      final results = await ref.read(nominatimServiceProvider).search(
            query,
            viewbox: const GeoBounds(
              southWest: MapConstants.southWest,
              northEast: MapConstants.northEast,
            ),
          );
      if (!mounted) return;
      if (results.isEmpty) {
        ref.read(searchResultsProvider.notifier).state = const [];
        messenger.showSnackBar(
          const SnackBar(content: Text('関東圏内に該当する場所が見つかりませんでした')),
        );
        return;
      }
      if (results.length == 1) {
        // 候補が1件なら即フォーカス。
        ref.read(searchResultsProvider.notifier).state = const [];
        _applyResult(results.first);
      } else {
        // 複数候補はドロップダウンで選ばせる。
        ref.read(searchResultsProvider.notifier).state = results;
      }
    } on NominatimException catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) {
        ref.read(searchLoadingProvider.notifier).state = false;
      }
    }
  }

  /// 検索結果を地図に反映する。area は境界線＋範囲フィット、点はズーム16へ移動。
  void _applyResult(GeoSearchResult result) {
    FocusScope.of(context).unfocus();
    ref.read(searchResultsProvider.notifier).state = const [];

    if (result.isArea) {
      ref.read(selectedBoundaryProvider.notifier).state = result.polygons;
      final bounds = _boundsFor(result);
      if (bounds != null) {
        _mapController.fitCamera(
          CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
        );
      }
    } else {
      // 駅・施設などは枠線を消して点へズーム。
      ref.read(selectedBoundaryProvider.notifier).state = null;
      _mapController.move(LatLng(result.lat, result.lng), 16);
    }
  }

  /// 範囲フィット用の境界。bbox を優先し、無ければポリゴン頂点から算出する。
  /// Nominatim は viewbox で絞り込んでも結果オブジェクトの bbox は全域のまま
  /// （例：東京都は小笠原諸島まで含む）なので、関東圏に交差クランプして
  /// fitCamera が極端にズームアウトしないようにする。
  LatLngBounds? _boundsFor(GeoSearchResult result) {
    final LatLngBounds raw;
    if (result.bbox != null) {
      raw = LatLngBounds(result.bbox!.southWest, result.bbox!.northEast);
    } else {
      final points = [for (final ring in result.polygons!) ...ring];
      if (points.isEmpty) return null;
      raw = LatLngBounds.fromPoints(points);
    }

    // 関東圏（MapConstants）と交差させてクランプ。
    final south = raw.south < MapConstants.southWest.latitude
        ? MapConstants.southWest.latitude
        : raw.south;
    final north = raw.north > MapConstants.northEast.latitude
        ? MapConstants.northEast.latitude
        : raw.north;
    final west = raw.west < MapConstants.southWest.longitude
        ? MapConstants.southWest.longitude
        : raw.west;
    final east = raw.east > MapConstants.northEast.longitude
        ? MapConstants.northEast.longitude
        : raw.east;

    return LatLngBounds(LatLng(south, west), LatLng(north, east));
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    ref.read(searchResultsProvider.notifier).state = const [];
    ref.read(selectedBoundaryProvider.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    final pins = ref.watch(pinsProvider).value ?? const <Pin>[];
    final boundary = ref.watch(selectedBoundaryProvider);
    final results = ref.watch(searchResultsProvider);
    final loading = ref.watch(searchLoadingProvider);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: MapConstants.initialCenter,
            initialZoom: MapConstants.initialZoom,
            minZoom: MapConstants.minZoom,
            maxZoom: MapConstants.maxZoom,
            cameraConstraint: CameraConstraint.containCenter(
              bounds: MapConstants.bounds,
            ),
            onLongPress: (_, point) => _onLongPress(point),
          ),
          children: [
            TileLayer(
              urlTemplate: MapConstants.tileUrlTemplate,
              subdomains: MapConstants.tileSubdomains,
              userAgentPackageName: 'dev.kanarunrun.atlus',
              tileProvider: NetworkTileProvider(),
            ),
            // 検索した行政区域の境界線（Marker の下に置きピンを隠さない）。
            if (boundary != null)
              PolygonLayer(
                polygons: [
                  for (final ring in boundary)
                    Polygon(
                      points: ring,
                      borderColor: AppColors.primaryPink,
                      borderStrokeWidth: 2.5,
                      color: AppColors.primaryPink.withValues(alpha: 0.1),
                    ),
                ],
              ),
            MarkerLayer(
              markers: [
                for (final pin in pins)
                  Marker(
                    point: LatLng(pin.latitude, pin.longitude),
                    width: 40,
                    height: 40,
                    alignment: Alignment.topCenter,
                    child: _PinMarker(
                      kind: PinKind.fromValue(pin.kind),
                      proposer: Proposer.fromValue(pin.proposer),
                      onTap: () => context.push('/pin/${pin.id}'),
                    ),
                  ),
              ],
            ),
            // 利用規約に基づく帰属表示（右下）：OpenStreetMap と CARTO の両方。
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                    Uri.parse('https://www.openstreetmap.org/copyright'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                TextSourceAttribution(
                  'CARTO',
                  onTap: () => launchUrl(
                    Uri.parse('https://carto.com/attributions'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ],
            ),
          ],
        ),

        // 上部の検索バー＋候補リスト。
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SearchBar(
                    controller: _searchController,
                    hintText: '場所を検索（駅名・区名など）',
                    leading: const Icon(Icons.search),
                    trailing: [
                      if (loading)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      else if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.close),
                          tooltip: 'クリア',
                          onPressed: _clearSearch,
                        ),
                    ],
                    onSubmitted: _onSubmitted,
                  ),
                  if (results.length > 1)
                    _SearchResultsList(
                      results: results,
                      onSelect: _applyResult,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 複数候補のドロップダウン。
class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({required this.results, required this.onSelect});

  final List<GeoSearchResult> results;
  final void Function(GeoSearchResult) onSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: results.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final r = results[index];
            return ListTile(
              leading: Icon(
                r.isArea ? Icons.crop_square : Icons.place,
                color: AppColors.primaryPink,
              ),
              title: Text(r.shortName, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(r.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              onTap: () => onSelect(r),
            );
          },
        ),
      ),
    );
  }
}

/// kind の色で塗ったピン。中央に proposer バッジ（M/P）を表示する。
class _PinMarker extends StatelessWidget {
  const _PinMarker({
    required this.kind,
    required this.proposer,
    required this.onTap,
  });

  final PinKind kind;
  final Proposer proposer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.location_on, color: kind.color, size: 40),
          // proposer バッジ（ピン上部の円内に M / P）。
          Positioned(
            top: 6,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: Text(
                proposer.badge,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: kind.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

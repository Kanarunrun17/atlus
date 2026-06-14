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

/// 地図画面（ホーム・タブ）。
/// F1：地図表示（CartoDB Positron・関東圏に範囲制限）、
/// F2：ロングタップでピン追加、F3：kind による色分け、F4：proposer バッジ表示。
class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  void _onLongPress(BuildContext context, LatLng point) {
    // 新規作成画面へ座標を渡して遷移する。
    context.push('/pin/new?lat=${point.latitude}&lng=${point.longitude}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pins = ref.watch(pinsProvider).value ?? const <Pin>[];

    return FlutterMap(
      options: MapOptions(
        initialCenter: MapConstants.initialCenter,
        initialZoom: MapConstants.initialZoom,
        minZoom: MapConstants.minZoom,
        maxZoom: MapConstants.maxZoom,
        // 関東圏より外へ動かせないように中心を範囲内に拘束する。
        cameraConstraint: CameraConstraint.containCenter(
          bounds: MapConstants.bounds,
        ),
        onLongPress: (_, point) => _onLongPress(context, point),
      ),
      children: [
        // Positron のシンプルなモノトーン地図をそのまま表示する
        // （色味補正・ピンクオーバーレイは無し。ふわふわ感は UI 側で表現）。
        TileLayer(
          urlTemplate: MapConstants.tileUrlTemplate,
          subdomains: MapConstants.tileSubdomains,
          userAgentPackageName: 'jp.co.starx.atlus',
          tileProvider: NetworkTileProvider(),
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

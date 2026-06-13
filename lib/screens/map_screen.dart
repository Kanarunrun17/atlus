import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

/// 地図画面（ホーム・タブ）。F1：OpenStreetMap タイルで地図を表示する。
/// ピン表示（F2〜）は後続で追加する。
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  /// 初期表示の中心（東京駅周辺）。
  static const _initialCenter = LatLng(35.6762, 139.6503);
  static const _initialZoom = 10.0;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: _initialCenter,
        initialZoom: _initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          // OSM タイルポリシー上、アプリを識別できるよう設定する。
          userAgentPackageName: 'jp.co.starx.atlus',
          // flutter_map 8.x 標準のネットワークタイルプロバイダー。
          // abortObsoleteRequests=true（既定）で不要になったタイル要求を中断する。
          tileProvider: NetworkTileProvider(),
        ),
        // OpenStreetMap 利用規約に基づく帰属表示（右下）。
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(
                Uri.parse('https://www.openstreetmap.org/copyright'),
                mode: LaunchMode.externalApplication,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

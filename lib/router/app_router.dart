import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/anniversary_screen.dart';
import '../screens/list_screen.dart';
import '../screens/map_screen.dart';
import '../screens/pin_detail_screen.dart';
import '../screens/pin_edit_screen.dart';

/// アプリ全体のルーティング定義。
///
/// - `/`, `/list`, `/anniversary` は下部タブ（StatefulShellRoute）で切り替え。
/// - ピン詳細・編集はタブの上に重ねて表示する補助画面。
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // 下部タブを持つシェル。各ブランチがタブ1つに対応する。
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/list',
              builder: (context, state) => const ListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/anniversary',
              builder: (context, state) => const AnniversaryScreen(),
            ),
          ],
        ),
      ],
    ),

    // 補助画面（タブの外）。
    GoRoute(
      path: '/pin/new',
      builder: (context, state) {
        final lat = double.tryParse(state.uri.queryParameters['lat'] ?? '');
        final lng = double.tryParse(state.uri.queryParameters['lng'] ?? '');
        return PinEditScreen(initialLat: lat, initialLng: lng);
      },
    ),
    GoRoute(
      path: '/pin/:id/edit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PinEditScreen(pinId: id);
      },
    ),
    GoRoute(
      path: '/pin/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PinDetailScreen(pinId: id);
      },
    ),
  ],
);

/// 下部ナビゲーションバーを備えたシェル。
class _ScaffoldWithNavBar extends StatelessWidget {
  const _ScaffoldWithNavBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('@lus')),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // 既に選択中のタブを再タップしたら先頭へ戻す。
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.map), label: '地図'),
          NavigationDestination(icon: Icon(Icons.list), label: '一覧'),
          NavigationDestination(
              icon: Icon(Icons.favorite), label: '記念日'),
        ],
      ),
    );
  }
}

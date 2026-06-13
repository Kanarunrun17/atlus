import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../db/database.dart';
import '../models/pin_enums.dart';
import '../providers/pins_provider.dart';

/// 一覧画面（タブ・F7）。ソート済みのピンをリスト表示する。
/// ソートは DB 側（PinRepository.watchAllSorted）で行うため、ここは表示に専念する。
class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinsAsync = ref.watch(sortedPinsProvider);

    return pinsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('読み込みエラー: $e')),
      data: (pins) {
        if (pins.isEmpty) {
          return const Center(child: Text('まだピンがありません'));
        }
        return ListView.separated(
          itemCount: pins.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) => _PinListTile(pin: pins[index]),
        );
      },
    );
  }
}

class _PinListTile extends StatelessWidget {
  const _PinListTile({required this.pin});

  final Pin pin;

  @override
  Widget build(BuildContext context) {
    final kind = PinKind.fromValue(pin.kind);
    final proposer = Proposer.fromValue(pin.proposer);
    final visitedText = pin.visitedAt == null
        ? '未訪問'
        : DateFormat('yyyy/MM/dd').format(pin.visitedAt!);

    return ListTile(
      // 左端：kind 色の円アイコン
      leading: CircleAvatar(backgroundColor: kind.color, radius: 10),
      title: Text(
        pin.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Text(visitedText),
          if (pin.rating != null) ...[
            const SizedBox(width: 8),
            const Icon(Icons.star, color: Colors.amber, size: 16),
            Text('${pin.rating}'),
          ],
        ],
      ),
      // 提案者バッジ（M/P）
      trailing: CircleAvatar(
        radius: 12,
        backgroundColor: kind.color,
        child: Text(
          proposer.badge,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () => context.go('/pin/${pin.id}'),
    );
  }
}

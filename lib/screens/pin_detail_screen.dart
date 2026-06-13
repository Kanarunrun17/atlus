import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../db/database.dart';
import '../models/pin_enums.dart';
import '../providers/pins_provider.dart';
import '../utils/image_utils.dart';
import '../widgets/pin_photo_view.dart';

/// ピン詳細画面（F5）。:id のピンを表示し、編集・削除への導線を持つ。
class PinDetailScreen extends ConsumerWidget {
  const PinDetailScreen({super.key, required this.pinId});

  final int pinId;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ピンを削除'),
        content: const Text('このピンを削除しますか？この操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (ok != true) return;
    await ref.read(pinRepositoryProvider).delete(pinId);
    if (context.mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinAsync = ref.watch(pinByIdProvider(pinId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ピン詳細'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '編集',
            onPressed: () => context.go('/pin/$pinId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: '削除',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: pinAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('読み込みエラー: $e')),
        data: (pin) {
          if (pin == null) {
            return const Center(child: Text('ピンが見つかりません'));
          }
          return _PinDetailBody(pin: pin);
        },
      ),
    );
  }
}

class _PinDetailBody extends StatelessWidget {
  const _PinDetailBody({required this.pin});

  final Pin pin;

  @override
  Widget build(BuildContext context) {
    final kind = PinKind.fromValue(pin.kind);
    final proposer = Proposer.fromValue(pin.proposer);
    final visitedText = pin.visitedAt == null
        ? '未訪問'
        : DateFormat('yyyy/MM/dd').format(pin.visitedAt!);
    final photoBytes = decodeBase64Image(pin.photoBase64);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 場所名
        Text(
          pin.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),

        // 写真（あれば）：場所名の下、kindバッジの上。タップで拡大。
        if (photoBytes != null) ...[
          PinPhotoThumbnail(
            bytes: photoBytes,
            onTap: () => PinPhotoDialog.show(context, photoBytes),
          ),
          const SizedBox(height: 16),
        ],

        // kind バッジ
        Row(
          children: [
            Chip(
              label: Text(kind.label),
              backgroundColor: kind.color.withValues(alpha: 0.2),
              avatar: CircleAvatar(backgroundColor: kind.color, radius: 8),
            ),
          ],
        ),
        const Divider(height: 32),

        _DetailRow(label: '提案者', child: Text(proposer.label)),
        const SizedBox(height: 16),

        // rating
        _DetailRow(
          label: '評価',
          child: pin.rating == null
              ? const Text('評価なし')
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 1; i <= 5; i++)
                      Icon(
                        i <= pin.rating! ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 16),

        // visited_at
        _DetailRow(label: '訪問日', child: Text(visitedText)),
        const SizedBox(height: 16),

        // comment
        _DetailRow(
          label: 'コメント',
          child: Text(
            (pin.comment == null || pin.comment!.trim().isEmpty)
                ? 'コメントなし'
                : pin.comment!,
          ),
        ),
        const Divider(height: 32),

        // 緯度経度（小さめ）
        Text(
          '緯度 ${pin.latitude.toStringAsFixed(6)}, '
          '経度 ${pin.longitude.toStringAsFixed(6)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
              ),
        ),
      ],
    );
  }
}

/// ラベル＋値を横並びに表示する行。
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

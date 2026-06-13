import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../models/pin_enums.dart';
import '../providers/pins_provider.dart';

/// ピン編集・新規作成画面（共通）。
/// [pinId] が null の場合は新規作成。新規作成時は [initialLat]/[initialLng]
/// に地図ロングタップ座標が渡される。
/// ※写真機能は後続コミットで追加する。
class PinEditScreen extends ConsumerStatefulWidget {
  const PinEditScreen({
    super.key,
    this.pinId,
    this.initialLat,
    this.initialLng,
  });

  final int? pinId;
  final double? initialLat;
  final double? initialLng;

  bool get isNew => pinId == null;

  @override
  ConsumerState<PinEditScreen> createState() => _PinEditScreenState();
}

class _PinEditScreenState extends ConsumerState<PinEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();

  PinKind _kind = PinKind.visited;
  Proposer _proposer = Proposer.me;
  int? _rating;
  DateTime? _visitedAt;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickVisitedAt() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _visitedAt ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() => _visitedAt = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final lat = widget.initialLat;
    final lng = widget.initialLng;
    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('座標が指定されていません')),
      );
      return;
    }

    setState(() => _saving = true);
    final comment = _commentController.text.trim();
    await ref.read(pinRepositoryProvider).create(
          latitude: lat,
          longitude: lng,
          name: _nameController.text.trim(),
          kind: _kind.value,
          proposer: _proposer.value,
          rating: _rating,
          comment: comment.isEmpty ? null : comment,
          visitedAt: _visitedAt,
        );

    if (!mounted) return;
    // 地図画面（ホーム）へ戻る。
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isNew ? 'ピン新規作成' : 'ピン編集')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 場所名（必須）
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '場所名 *',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '場所名を入力してください' : null,
            ),
            const SizedBox(height: 24),

            // kind（必須）
            const Text('種別 *', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final k in PinKind.values)
                  ChoiceChip(
                    label: Text(k.label),
                    selected: _kind == k,
                    avatar: CircleAvatar(backgroundColor: k.color, radius: 8),
                    onSelected: (_) => setState(() => _kind = k),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // proposer（必須）
            const Text('提案者 *',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final p in Proposer.values)
                  ChoiceChip(
                    label: Text(p.label),
                    selected: _proposer == p,
                    onSelected: (_) => setState(() => _proposer = p),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // rating（任意）
            const Text('評価', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    icon: Icon(
                      (_rating ?? 0) >= i ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () => setState(() {
                      // 同じ星を再タップしたら解除。
                      _rating = (_rating == i) ? null : i;
                    }),
                  ),
                if (_rating != null)
                  TextButton(
                    onPressed: () => setState(() => _rating = null),
                    child: const Text('クリア'),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // comment（任意）
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'コメント',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // visited_at（任意）
            const Text('訪問日', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _visitedAt == null
                        ? '未設定'
                        : DateFormat('yyyy/MM/dd').format(_visitedAt!),
                  ),
                ),
                TextButton.icon(
                  onPressed: _pickVisitedAt,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('日付を選択'),
                ),
                if (_visitedAt != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _visitedAt = null),
                  ),
              ],
            ),
            const SizedBox(height: 32),

            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

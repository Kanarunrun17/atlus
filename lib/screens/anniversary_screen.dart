import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../db/database.dart';
import '../models/anniversary_countdown.dart';
import '../providers/anniversaries_provider.dart';
import '../theme/app_colors.dart';

/// 記念日画面（タブ・F8）。記念日一覧とカウントダウンを表示する。
class AnniversaryScreen extends ConsumerWidget {
  const AnniversaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(anniversariesProvider);

    return Scaffold(
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('読み込みエラー: $e')),
        data: (items) {
          if (items.isEmpty) {
            return _EmptyState(onAdd: () => _openEditor(context, ref));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, index) => _AnniversaryCard(
              anniversary: items[index],
              onTap: () => _openEditor(context, ref, existing: items[index]),
              onDelete: () => _confirmDelete(context, ref, items[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 追加・編集ダイアログを開く。[existing] があれば編集モード。
  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref, {
    Anniversary? existing,
  }) async {
    final result = await showDialog<_AnniversaryFormResult>(
      context: context,
      builder: (_) => _AnniversaryDialog(existing: existing),
    );
    if (result == null) return;

    final repo = ref.read(anniversaryRepositoryProvider);
    if (existing == null) {
      await repo.create(
        title: result.title,
        date: result.date,
        recurring: result.recurring,
      );
    } else {
      await repo.update(
        existing.copyWith(
          title: result.title,
          date: result.date,
          recurring: result.recurring,
        ),
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Anniversary anniversary,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('記念日を削除'),
        content: Text('「${anniversary.title}」を削除しますか？'),
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
    if (ok == true) {
      await ref.read(anniversaryRepositoryProvider).delete(anniversary.id);
    }
  }
}

/// 記念日が0件のときの表示。
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.celebration, size: 64, color: AppColors.lavender),
          const SizedBox(height: 16),
          const Text('記念日を追加しよう', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          const Text('右下の＋ボタンから追加できます',
              style: TextStyle(color: AppColors.textLight)),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('記念日を追加'),
          ),
        ],
      ),
    );
  }
}

/// 記念日1件のカード。カウントダウンを表示し、タップで編集・長押しで削除。
class _AnniversaryCard extends StatelessWidget {
  const _AnniversaryCard({
    required this.anniversary,
    required this.onTap,
    required this.onDelete,
  });

  final Anniversary anniversary;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final countdown = AnniversaryCountdown.compute(
      date: anniversary.date,
      recurring: anniversary.recurring,
      now: DateTime.now(),
    );
    final dateText = DateFormat('yyyy/MM/dd').format(anniversary.date);

    // スワイプ削除（左右どちらでも）。
    return Dismissible(
      key: ValueKey(anniversary.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        onDelete();
        // 実際の削除は onDelete 内の確認ダイアログに委ねるため、
        // ここでは要素を消さない（false）。
        return false;
      },
      child: Card(
        child: ListTile(
          onTap: onTap,
          onLongPress: onDelete,
          leading: const Icon(Icons.favorite, color: AppColors.primaryPink),
          title: Text(
            anniversary.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Text(dateText),
              if (anniversary.recurring) ...[
                const SizedBox(width: 6),
                const Icon(Icons.repeat, size: 14, color: AppColors.textLight),
              ],
            ],
          ),
          trailing: Text(
            countdown.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: countdown.days == 0
                  ? AppColors.peach
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// ダイアログの入力結果。
class _AnniversaryFormResult {
  const _AnniversaryFormResult({
    required this.title,
    required this.date,
    required this.recurring,
  });

  final String title;
  final DateTime date;
  final bool recurring;
}

/// 記念日の追加・編集ダイアログ。
class _AnniversaryDialog extends StatefulWidget {
  const _AnniversaryDialog({this.existing});

  final Anniversary? existing;

  @override
  State<_AnniversaryDialog> createState() => _AnniversaryDialogState();
}

class _AnniversaryDialogState extends State<_AnniversaryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late DateTime _date;
  late bool _recurring;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _titleController = TextEditingController(text: e?.title ?? '');
    _date = e?.date ?? DateTime.now();
    _recurring = e?.recurring ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      _AnniversaryFormResult(
        title: _titleController.text.trim(),
        date: _date,
        recurring: _recurring,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? '記念日を追加' : '記念日を編集'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'タイトル *',
                hintText: '例：付き合った日',
              ),
              autofocus: true,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'タイトルを入力してください' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(DateFormat('yyyy/MM/dd').format(_date)),
                ),
                TextButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('日付を選択'),
                ),
              ],
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('毎年繰り返す'),
              value: _recurring,
              onChanged: (v) => setState(() => _recurring = v),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        FilledButton(onPressed: _submit, child: const Text('保存')),
      ],
    );
  }
}

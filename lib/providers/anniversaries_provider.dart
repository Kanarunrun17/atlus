import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database.dart';
import '../repositories/anniversary_repository.dart';
import 'database_provider.dart';

/// anniversaries テーブルへの操作を提供するリポジトリ。
final anniversaryRepositoryProvider = Provider<AnniversaryRepository>((ref) {
  return AnniversaryRepository(ref.watch(databaseProvider));
});

/// 全記念日を監視する StreamProvider（日付昇順）。
final anniversariesProvider = StreamProvider<List<Anniversary>>((ref) {
  return ref.watch(anniversaryRepositoryProvider).watchAll();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database.dart';

/// アプリ全体で共有する単一の [AppDatabase] インスタンス。
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

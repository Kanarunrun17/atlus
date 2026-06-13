import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/anniversaries.dart';
import 'tables/pins.dart';

part 'database.g.dart';

/// @lus のローカルデータベース。
/// Web では drift_flutter 経由で SQLite WASM (IndexedDB) を利用する。
@DriftDatabase(tables: [Pins, Anniversaries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // drift_flutter がプラットフォームに応じた接続を提供する。
    // Web の場合は SQLite WASM + IndexedDB が使われる。
    return driftDatabase(name: 'atlus');
  }
}

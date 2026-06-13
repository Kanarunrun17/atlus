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
    // Web では web/ に配置した SQLite WASM + drift worker を使い、
    // データは IndexedDB に保存される。
    return driftDatabase(
      name: 'atlus',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}

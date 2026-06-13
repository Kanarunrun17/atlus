import 'package:drift/drift.dart';

import '../db/database.dart';

/// anniversaries テーブルへの DB 操作をまとめたラッパー。
class AnniversaryRepository {
  AnniversaryRepository(this._db);

  final AppDatabase _db;

  /// 全記念日を日付の昇順（次に来る日が上）で監視する。
  Stream<List<Anniversary>> watchAll() {
    return (_db.select(_db.anniversaries)
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .watch();
  }

  /// 新規記念日を追加し、生成された id を返す。
  Future<int> create({
    required String title,
    required DateTime date,
    required bool recurring,
  }) {
    return _db.into(_db.anniversaries).insert(
          AnniversariesCompanion.insert(
            title: title,
            date: date,
            recurring: recurring,
            createdAt: DateTime.now(),
          ),
        );
  }

  /// 既存記念日を更新する。
  Future<bool> update(Anniversary anniversary) {
    return _db.update(_db.anniversaries).replace(anniversary);
  }

  /// 既存記念日を削除する。
  Future<int> delete(int id) {
    return (_db.delete(_db.anniversaries)..where((t) => t.id.equals(id))).go();
  }
}

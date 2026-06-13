import 'package:drift/drift.dart';

import '../db/database.dart';

/// pins テーブルへの DB 操作をまとめたラッパー。
class PinRepository {
  PinRepository(this._db);

  final AppDatabase _db;

  /// 全ピンを監視する（作成日時の新しい順）。
  Stream<List<Pin>> watchAll() {
    return (_db.select(_db.pins)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// 単一ピンを監視する。
  Stream<Pin?> watchById(int id) {
    return (_db.select(_db.pins)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// 新規ピンを追加し、生成された id を返す。
  Future<int> create({
    required double latitude,
    required double longitude,
    required String name,
    required String kind,
    required String proposer,
    int? rating,
    String? comment,
    String? photoBase64,
    DateTime? visitedAt,
  }) {
    final now = DateTime.now();
    return _db.into(_db.pins).insert(
          PinsCompanion.insert(
            latitude: latitude,
            longitude: longitude,
            name: name,
            kind: kind,
            proposer: proposer,
            rating: Value.absentIfNull(rating),
            comment: Value.absentIfNull(comment),
            photoBase64: Value.absentIfNull(photoBase64),
            visitedAt: Value.absentIfNull(visitedAt),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  /// 既存ピンを更新する。updatedAt は現在時刻に自動更新する。
  Future<bool> update(Pin pin) {
    return _db.update(_db.pins).replace(
          pin.copyWith(updatedAt: DateTime.now()),
        );
  }

  /// 既存ピンを削除する。
  Future<int> delete(int id) {
    return (_db.delete(_db.pins)..where((t) => t.id.equals(id))).go();
  }
}

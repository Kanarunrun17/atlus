import 'package:drift/drift.dart';

/// ピン（訪れた場所・予定・記念日）のテーブル定義。
/// 詳細は docs/data_model.md を参照。
class Pins extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get latitude => real()();
  RealColumn get longitude => real()();

  TextColumn get name => text()();

  /// 種別: visited(行った) / planned(予定) / anniversary(記念日)
  TextColumn get kind => text()();

  /// 提案者: me(自分) / partner(パートナー)
  TextColumn get proposer => text()();

  /// ★評価 (1〜5, nullable)
  IntColumn get rating => integer().nullable()();

  TextColumn get comment => text().nullable()();

  /// 写真（Base64エンコードした画像データ, nullable）
  TextColumn get photoBase64 => text().nullable()();

  /// 訪問日 (nullable)
  DateTimeColumn get visitedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

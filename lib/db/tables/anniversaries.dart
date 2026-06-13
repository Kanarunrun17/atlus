import 'package:drift/drift.dart';

/// 記念日（カウントダウン用）のテーブル定義。
/// 詳細は docs/data_model.md を参照。
class Anniversaries extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  /// 記念日の日付
  DateTimeColumn get date => dateTime()();

  /// 毎年繰り返すかどうか
  BoolColumn get recurring => boolean()();

  DateTimeColumn get createdAt => dateTime()();
}

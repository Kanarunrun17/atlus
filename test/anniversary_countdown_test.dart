import 'package:atlus/models/anniversary_countdown.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnniversaryCountdown.compute', () {
    final now = DateTime(2026, 6, 13); // 基準日

    test('recurring: 今年の該当日が未来 → 今年までの日数', () {
      final c = AnniversaryCountdown.compute(
        date: DateTime(2020, 6, 20),
        recurring: true,
        now: now,
      );
      expect(c.days, 7);
      expect(c.label, 'あと7日');
    });

    test('recurring: 今年の該当日が過去 → 来年までの日数', () {
      final c = AnniversaryCountdown.compute(
        date: DateTime(2020, 6, 1),
        recurring: true,
        now: now,
      );
      // 2026/6/1 は過去 → 2027/6/1 まで
      expect(c.days, DateTime(2027, 6, 1).difference(DateTime(2026, 6, 13)).inDays);
      expect(c.label.startsWith('あと'), isTrue);
    });

    test('recurring: 今日が該当日 → 今日', () {
      final c = AnniversaryCountdown.compute(
        date: DateTime(2018, 6, 13),
        recurring: true,
        now: now,
      );
      expect(c.days, 0);
      expect(c.label, '今日');
    });

    test('non-recurring: 未来 → あと○日', () {
      final c = AnniversaryCountdown.compute(
        date: DateTime(2026, 6, 30),
        recurring: false,
        now: now,
      );
      expect(c.days, 17);
      expect(c.label, 'あと17日');
    });

    test('non-recurring: 過去 → ○日前', () {
      final c = AnniversaryCountdown.compute(
        date: DateTime(2026, 6, 3),
        recurring: false,
        now: now,
      );
      expect(c.days, -10);
      expect(c.label, '10日前');
    });

    test('時刻が含まれていても日付単位で計算する', () {
      final c = AnniversaryCountdown.compute(
        date: DateTime(2026, 6, 20, 23, 59),
        recurring: false,
        now: DateTime(2026, 6, 13, 1, 0),
      );
      expect(c.days, 7);
    });
  });
}

/// 記念日カウントダウンの計算結果。
class AnniversaryCountdown {
  const AnniversaryCountdown({required this.days, required this.label});

  /// 基準日（今日）から対象日までの日数。
  /// 未来は正、過去は負、当日は 0。
  final int days;

  /// 表示用ラベル（例：「今日」「あと12日」「3日前」）。
  final String label;

  /// [date] と [recurring] から、[now] を基準にカウントダウンを計算する。
  factory AnniversaryCountdown.compute({
    required DateTime date,
    required bool recurring,
    required DateTime now,
  }) {
    // 時刻を切り捨てて日付単位で比較する。
    final today = DateTime(now.year, now.month, now.day);

    final DateTime target;
    if (recurring) {
      // 今年の該当日。未来（当日含む）ならそれを、過去なら来年を対象にする。
      final thisYear = DateTime(today.year, date.month, date.day);
      target = !thisYear.isBefore(today)
          ? thisYear
          : DateTime(today.year + 1, date.month, date.day);
    } else {
      target = DateTime(date.year, date.month, date.day);
    }

    final days = target.difference(today).inDays;

    final String label;
    if (days == 0) {
      label = '今日';
    } else if (days > 0) {
      label = 'あと$days日';
    } else {
      label = '${-days}日前';
    }

    return AnniversaryCountdown(days: days, label: label);
  }
}

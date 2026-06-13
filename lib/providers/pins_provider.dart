import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database.dart';
import '../repositories/pin_repository.dart';
import 'database_provider.dart';

/// pins テーブルへの操作を提供するリポジトリ。
final pinRepositoryProvider = Provider<PinRepository>((ref) {
  return PinRepository(ref.watch(databaseProvider));
});

/// 全ピンを監視する StreamProvider。
final pinsProvider = StreamProvider<List<Pin>>((ref) {
  return ref.watch(pinRepositoryProvider).watchAll();
});

/// 指定 id のピンを監視する StreamProvider。存在しない場合は null を流す。
final pinByIdProvider = StreamProvider.family<Pin?, int>((ref, id) {
  return ref.watch(pinRepositoryProvider).watchById(id);
});

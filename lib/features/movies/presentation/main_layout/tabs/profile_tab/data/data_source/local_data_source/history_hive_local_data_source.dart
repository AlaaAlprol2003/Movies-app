import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import '../../models/movie_hive.dart';
import 'history_local_data_source.dart';

@LazySingleton(as: HistoryLocalDataSource)
class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final Box<MovieHive> _box = Hive.box<MovieHive>('historyBox');

  @override
  Future<void> addToHistory({required MovieHive movie}) async {
    final movies = _box.values.toList();
    final existingIndex = movies.indexWhere((m) => m.id == movie.id);

    if (existingIndex != -1) {
      await _box.deleteAt(existingIndex);
    }

    await _box.put(
      DateTime.now().millisecondsSinceEpoch.toString(),
      movie,
    );
  }

  @override
  Future<List<MovieHive>> getHistory() async {
    return _box.values.toList().reversed.toList();
  }
}

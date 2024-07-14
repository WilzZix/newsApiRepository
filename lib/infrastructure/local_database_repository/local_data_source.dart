import 'package:infinite_scroll/data/storage/hive/hive_storage.dart';
import 'package:infinite_scroll/domain/i_local_news.dart';

import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

class LocalDataRepository implements ILocalNews {
  final _hiveStorage = HiveStorage();

  @override
  Future<List<News>> getBBCNews() {
    return _hiveStorage.getBBCNews();
  }

  @override
  Future<List<News>> getNews({required int page}) {
    return _hiveStorage.getTopHeadlineNews();
  }

  @override
  Future<List<News>> getSportNews() {
    return _hiveStorage.getSportNews();
  }

  @override
  Future<void> setBBCNews({required List<News> data}) async {
    await _hiveStorage.saveBBCNews(data);
  }

  @override
  Future<void> setSportNews({required List<News> data}) async {
    await _hiveStorage.saveSportNews(data);
  }

  @override
  Future<void> setTopHeadlineNews({required List<News> data}) async {
    await _hiveStorage.saveTopHeadlineNews(data);
  }
}

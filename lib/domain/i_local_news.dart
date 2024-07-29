import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

abstract class ILocalNews {
  List<News> getNews({required int page});

  Future<List<News>> getBBCNews();

  Future<List<News>> getSportNews();

  Future<void> setTopHeadlineNews({required List<News> data});

  Future<void> setBBCNews({required List<News> data});

  Future<void> setSportNews({required List<News> data});
}

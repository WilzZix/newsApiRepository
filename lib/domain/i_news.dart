import '../infrastructure/dto/models/news_model.dart';

abstract class INews {
  const INews._();

  Future<List<News>> getNews({required int page});

  Future<List<News>> getBBCNews();

  Future<List<News>> getSportNews();

}

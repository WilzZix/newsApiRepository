import 'package:infinite_scroll/domain/i_news.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:infinite_scroll/infrastructure/service/network_provider.dart';

//apiKey=2a389994e9314644b675d0567ed43de4 nodirbek barotov
//apiKey = d094c8cfc699450fa563f9e2463c9725 nodir barotov

  class NewsRepository implements INews {
  @override
  Future<List<News>> getNews({required int page}) async {
    final Response response =
        await NetworkProvider.dio.get(NetworkProvider.routes.topHeadlined);
    return News.fetchData(response.data ?? {});
  }

  @override
  Future<List<News>> getBBCNews() async {
    final Response response =
        await NetworkProvider.dio.get(NetworkProvider.routes.topHeadlined);
    return News.fetchData(response.data ?? {});
  }

  @override
  Future<List<News>> getSportNews() async {
    final Response response =
        await NetworkProvider.dio.get(NetworkProvider.routes.sport);
    return News.fetchData(response.data ?? {});
  }
}

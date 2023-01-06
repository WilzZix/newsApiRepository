import 'dart:developer';

import 'package:infinite_scroll/domain/i_news.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

import 'package:dio/dio.dart';
import '../infrastructure/service/network_provider.dart';

class NewsRepository implements INews {
  @override
  Future<List<News>> getNews({required int page}) async {
    log('repository');
    var dio = Dio();
    final Response response =
        await dio.get(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=2a389994e9314644b675d0567ed43de4&pageSize=10&page=$page',
    );
    log('NEWWWSSS ${response.data}');
    return News.fetchData(response.data ?? {});
  }
}

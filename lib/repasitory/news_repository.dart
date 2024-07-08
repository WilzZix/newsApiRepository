import 'dart:developer';

import 'package:infinite_scroll/domain/i_news.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

import 'package:dio/dio.dart';

//apiKey=2a389994e9314644b675d0567ed43de4 nodirbek barotov
//apiKey = d094c8cfc699450fa563f9e2463c9725 nodir barotov

class NewsRepository implements INews {
  String country = '';

  @override
  Future<List<News>> getNews({required int page}) async {
    var dio = Dio();
    final Response response = await dio.get(
      'https://newsapi.org/v2/top-headlines?language=${country.isNotEmpty ? country : 'en'}&apiKey=dc6ae0adf55e413caa332f123ad34374&pageSize=10&page=$page',
    );
    log('NEWWWSSS ${response.data}');
    return News.fetchData(response.data ?? {});
  }

  @override
  Future<List<News>> getNewsByCountry({required String country}) async {
    log('getNewsByCountry');
    country = country;
    var dio = Dio();
    final Response response = await dio.get(
      'https://newsapi.org/v2/top-headlines?language=$country&apiKey=dc6ae0adf55e413caa332f123ad34374&pageSize=10',
    );
    return News.fetchData(response.data ?? {});
  }
}

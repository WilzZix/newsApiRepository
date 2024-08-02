
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll/infrastructure/interceptor.dart';

class NetworkProvider {
  static late Dio dio;
  static Routes routes = Routes();

//top-headlines?country=us&apiKey=2a389994e9314644b675d0567ed43de4
  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        connectTimeout: 3000,
        receiveTimeout: 1000,
        baseUrl: routes.baseUrl,
        queryParameters: {
          "country": 'us',
          "apiKey": "2a389994e9314644b675d0567ed43de4"
        },
      ),
    )..interceptors.addAll(
        [
          DioInterceptor(),
          if (kDebugMode)
            LogInterceptor(
                requestHeader: true,
                responseHeader: true,
                requestBody: true,
                responseBody: true,
            )// logPrint: (error) => log(error.toString())),
        ],
      );
  }
}

class Routes {
  Routes();

  final String baseUrl = 'https://newsapi.org/v2/';
  final String topHeadlined = 'top-headlines';
  final String sport = 'top-headlines?q=sport';
}

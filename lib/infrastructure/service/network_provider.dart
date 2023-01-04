import 'package:dio/dio.dart';

class NetworkProvider {
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio(BaseOptions(
      // baseUrl:
      //     'https://newsapi.org/v2/top-headlines?country=us&apiKey=2a389994e9314644b675d0567ed43de4',
    ));
    // ..interceptors.addAll([
    //   DioInterceptor(),
    //   if (kDebugMode)
    //     LogInterceptor(
    //         responseHeader: false,
    //         requestBody: true,
    //         responseBody: true,
    //         logPrint: (error) => log(error.toString())),
    // ]);
  }
}

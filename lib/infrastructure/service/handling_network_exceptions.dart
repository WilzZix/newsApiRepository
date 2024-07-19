import 'package:dio/dio.dart';

class HandlingNetworkExceptions {
  static String returnErrorMessageDependingWithError(DioError error) {
    if (error.response!.statusCode! >= 400 ||
        error.response!.statusCode! <= 499) {
      return 'Client error responses';
    }
    if (error.response!.statusCode! >= 500 ||
        error.response!.statusCode! <= 599) {
      return 'Server error response';
    }
    return 'Default error';
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRequest {
  final String BASE_URL = 'http://training-movie.bsp.vn:82/';
  final String TOKEN_KEY = 'app_token';
  final String TOKEN = 'dCuW7UQMbdvpcBDfzolAOSGFIcAec11a';
  final String url;
  final Map<String, dynamic> data;

  ApiRequest(@required this.url, this.data);

  Dio _dio() {
    return Dio(BaseOptions(
        baseUrl: BASE_URL,
        headers: {
          TOKEN_KEY: TOKEN,
        }
    ));
  }

  void get({
    Function()? onStart,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio().get(this.url, queryParameters: this.data).then((res) =>
    {
      if (onSuccess != null) onSuccess(res.data)
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  void post({
    Function()? onStart,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio().post(this.url, queryParameters: this.data).then((res) =>
    {
      if (onSuccess != null) onSuccess(res.data)
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}
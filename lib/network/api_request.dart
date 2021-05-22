import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/constant/constants.dart';

class ApiRequest {

  // final String url;
  // final Map<String, dynamic> data;

  ApiRequest();

  Dio _dio() {
    return Dio(BaseOptions(
        baseUrl: Constants.BASE_URL,
        headers: {
          Constants.TOKEN_KEY: Constants.TOKEN,
        }
    ));
  }

  Future<Response> get(String url, Map<String, dynamic>? data) async {
    return await _dio().get(url, queryParameters: data);
  }

  Future<Response> post(String url, Map<String, dynamic>? data) async {
    return await _dio().post(url, queryParameters: data);
  }
}
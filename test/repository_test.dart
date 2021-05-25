

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';

// class MockDio extends Mock implements Dio {}
void main() {
  test("Repository should return list movie in page 2", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    var jsonString = await rootBundle.loadString("assets/data_test.json");
    final jsonResult = json.decode(jsonString);
    MovieResponse matcherResponse =  MovieResponse.fromJson(jsonResult);

    int page = 2;
    int perPage = 10;
    MovieRepository _movieRepository = MovieRepository();
    var movieResponse = await _movieRepository.getMovie(page, perPage);
    expect(movieResponse, matcherResponse);
  });


}
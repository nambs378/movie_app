import 'package:dio/dio.dart';
import 'package:movie_app/constant/constants.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/network/api_request.dart';

class MovieRepository {
  final ApiRequest _apiRequest = ApiRequest();

  Future<MovieResponse> getMovie(int page, int perPage,
      ) async {
    var params = {'page': page, 'perPage': perPage};
    try{
      Response response = await _apiRequest.get(Constants.URL_GET_MOVIE, params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("Connection issue", true);
    }
  }

}
class NetworkError extends Error {}

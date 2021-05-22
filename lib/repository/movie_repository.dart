import 'package:dio/dio.dart';
import 'package:movie_app/constant/constants.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/network/api_request.dart';

class MovieRepository {
  final ApiRequest _apiRequest = ApiRequest();

  void getMovie(String url, int page, int perPage,
      Function() onStart,
      Function(Map<String, dynamic> data) onSuccess,
      Function(Error error) onError,
      )  {
    var params = {'page': page, 'perPage': perPage};
    onStart();
    _apiRequest.get(Constants.URL_GET_MOVIE, params).then((res) =>
    {
      onSuccess(res.data)
    }).catchError((error) {
      onError(error);
    });
  }

}
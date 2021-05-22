import 'package:movie_app/constant/constants.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<MovieResponse> _moviesFetcher =
  BehaviorSubject<MovieResponse>();
  final BehaviorSubject<bool> _isLoading =
  BehaviorSubject<bool>();

  BehaviorSubject<MovieResponse> get allMovies => _moviesFetcher;
  BehaviorSubject<bool> get loading => _isLoading;

  MovieBloc(){
    _isLoading.sink.add(false);
  }

  getMovie(int page, int perPage) {
    MovieResponse movieResponse;
    _movieRepository..getMovie(Constants.URL_GET_MOVIE, page, perPage,
            () {
              _isLoading.sink.add(true);
            },
            (data) {
              movieResponse = MovieResponse.fromJson(data);
              _isLoading.sink.add(false);
              _moviesFetcher.sink.add(movieResponse);
            },
            (error) {
              _isLoading.sink.add(false);
            });
  }
  dispose() {
    _moviesFetcher.close();
    _isLoading.close();
  }
}
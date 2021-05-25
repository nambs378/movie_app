import 'dart:async';
import 'package:movie_app/constant/constants.dart';
import 'package:movie_app/constant/my_share_preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:movie_app/event/movie_event.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/state/movie_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository = MovieRepository();

  final BehaviorSubject<bool> _isLoading =
  BehaviorSubject<bool>();

  BehaviorSubject<bool> get loading => _isLoading;

  MovieBloc() : super(MovieStateInitial());

  @override
  Stream<Transition<MovieEvent, MovieState>> transformEvents(
      Stream<MovieEvent> events,
      TransitionFunction<MovieEvent, MovieState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 100)),
      transitionFn,
    );
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is GetMovieList) {
      yield MovieStateLoading();
      try {
        MovieResponse movieResponse =
            await _movieRepository.getMovie(event.page, event.perPage);
        yield MovieStateSuccess(movieResponse);
        if (movieResponse.error == true) {
          yield MovieStateError(movieResponse.message.toString());
        }
      } catch (exception) {
        yield MovieStateError(exception.toString());
      }
    } else if (event is SaveMovieFavorite) {
      await _persistMovieFavorite(event.idMovie);
      List<String> list = await _getMovieFavorite();
      yield MovieStateFavorite(list);
    }
  }

  Future<List<String>> _getMovieFavorite() async {
    List<String> listIdMovieFavorite;
    listIdMovieFavorite = await MySharedPreferences.instance.getListStringValue(Constants.PREF_MOVIE_FAVORITE_KEY);
    print("get ");
    return listIdMovieFavorite;
  }

  _persistMovieFavorite(int id) async {
    List<String> listIdMovieFavorite;
    listIdMovieFavorite = await MySharedPreferences.instance.getListStringValue(Constants.PREF_MOVIE_FAVORITE_KEY);
    if (listIdMovieFavorite.contains(id.toString())) {
      listIdMovieFavorite.remove(id.toString());
      MySharedPreferences.instance.setListStringValue(Constants.PREF_MOVIE_FAVORITE_KEY, listIdMovieFavorite);
      print("delete");
    } else {
      listIdMovieFavorite.add(id.toString());
      MySharedPreferences.instance.setListStringValue(Constants.PREF_MOVIE_FAVORITE_KEY, listIdMovieFavorite);
      print("save ");
    }
  }

  dispose() {
    _isLoading.close();
  }

}

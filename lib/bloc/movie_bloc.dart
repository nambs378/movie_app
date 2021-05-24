import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:movie_app/event/movie_event.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/state/movie_state.dart';

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
      events.debounceTime(const Duration(milliseconds: 500)),
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
    }
  }

  dispose() {
    _isLoading.close();
  }

}

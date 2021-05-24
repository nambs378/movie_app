import 'package:equatable/equatable.dart';
import 'package:movie_app/model/movie_response.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieStateInitial extends MovieState {
  const MovieStateInitial();
  @override
  List<Object> get props => [];
}

class MovieStateLoading extends MovieState {
  const MovieStateLoading();
  @override
  List<Object?> get props => [];
}

class MovieStateSuccess extends MovieState {
  final MovieResponse movieResponse;
  const MovieStateSuccess(this.movieResponse);
  @override
  List<Object> get props => [movieResponse];
}

class MovieStateError extends MovieState {
  final String message;
  const MovieStateError(this.message);
  @override
  List<Object> get props => [message];
}
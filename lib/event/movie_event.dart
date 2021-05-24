

import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable{
  const MovieEvent();
}

class GetMovieList extends MovieEvent {
  final int page;
  final int perPage;

  GetMovieList(this.page, this.perPage);
  @override
  List<Object?> get props => [page, perPage];
}
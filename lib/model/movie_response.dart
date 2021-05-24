import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/paging.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse{

  @JsonKey(name: 'error')
  bool? error;

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'paging')
  Paging? paging;

  @JsonKey(name: 'data')
  List<Movie>? listMovie;

  MovieResponse(
      this.error,
      this.code,
      this.message,
      this.paging,
      this.listMovie);

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  MovieResponse.withError(String errorMessage, bool error) {
    message = errorMessage;
    this.error = error;
  }

}
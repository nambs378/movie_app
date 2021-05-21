import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/paging.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse{

  @JsonValue('error')
  bool error;

  @JsonValue('code')
  int code;

  @JsonValue('message')
  String message;

  @JsonValue('paging')
  Paging paging;

  @JsonValue('data')
  List<Movie> listMovie;

  MovieResponse(
      this.error,
      this.code,
      this.message,
      this.paging,
      this.listMovie);

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
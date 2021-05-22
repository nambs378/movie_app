import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonValue('id')
  int id;

  @JsonValue('title')
  String title;

  @JsonValue('image')
  String image;

  @JsonValue('link')
  String link;

  @JsonValue('description')
  String description;

  @JsonValue('category')
  String category;

  @JsonValue('actor')
  String actor;

  @JsonValue('director')
  String director;

  @JsonValue('manufacturer')
  String manufacturer;

  @JsonValue('duration')
  String duration;

  @JsonValue('year')
  String year;

  @JsonValue('created_at')
  String created_at;

  @JsonValue('updated_at')
  String updated_at;

  @JsonValue('views')
  int views;

  @JsonValue('type')
  String type;

  Movie(this.id,
      this.title,
      this.image,
      this.link,
      this.description,
      this.category,
      this.actor,
      this.director,
      this.manufacturer,
      this.duration,
      this.year,
      this.created_at,
      this.updated_at,
      this.views,
      this.type);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
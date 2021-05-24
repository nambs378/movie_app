import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable{
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'actor')
  String? actor;

  @JsonKey(name: 'director')
  String? director;

  @JsonKey(name: 'manufacturer')
  String? manufacturer;

  @JsonKey(name: 'duration')
  String? duration;

  @JsonKey(name: 'year')
  String? year;

  @JsonKey(name: 'created_at')
  String? created_at;

  @JsonKey(name: 'updated_at')
  String? updated_at;

  @JsonKey(name: 'views')
  int views;

  @JsonKey(name: 'type')
  String? type;

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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
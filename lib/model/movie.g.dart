// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    json['id'] as int,
    json['title'] as String,
    json['image'] as String,
    json['link'] as String,
    json['description'] as String?,
    json['category'] as String?,
    json['actor'] as String?,
    json['director'] as String?,
    json['manufacturer'] as String?,
    json['duration'] as String?,
    json['year'] as String?,
    json['created_at'] as String?,
    json['updated_at'] as String?,
    json['views'] as int,
    json['type'] as String?,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'link': instance.link,
      'description': instance.description,
      'category': instance.category,
      'actor': instance.actor,
      'director': instance.director,
      'manufacturer': instance.manufacturer,
      'duration': instance.duration,
      'year': instance.year,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'views': instance.views,
      'type': instance.type,
    };

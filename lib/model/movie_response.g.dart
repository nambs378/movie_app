// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) {
  return MovieResponse(
    json['error'] as bool,
    json['code'] as int,
    json['message'] as String,
    Paging.fromJson(json['paging'] as Map<String, dynamic>),
    (json['data'] as List<dynamic>)
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'code': instance.code,
      'message': instance.message,
      'paging': instance.paging,
      'data': instance.listMovie,
    };

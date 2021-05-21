// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging _$PagingFromJson(Map<String, dynamic> json) {
  return Paging(
    json['totalItem'] as int,
    json['perPage'] as int,
    json['currentPage'] as int,
    json['totalPages'] as int,
  );
}

Map<String, dynamic> _$PagingToJson(Paging instance) => <String, dynamic>{
      'totalItem': instance.totalItem,
      'perPage': instance.perPage,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
    };

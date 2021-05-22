// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging _$PagingFromJson(Map<String, dynamic> json) {
  return Paging(
    json['total_item'] as int,
    json['per_page'] as int,
    json['current_page'] as int,
    json['total_pages'] as int,
  );
}

Map<String, dynamic> _$PagingToJson(Paging instance) => <String, dynamic>{
      'total_item': instance.totalItem,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
    };

import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging{

  @JsonKey(name: 'total_item')
  int totalItem;

  @JsonKey(name: 'per_page')
  int perPage;

  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'total_pages')
  int totalPages;

  Paging(this.totalItem,
      this.perPage,
      this.currentPage,
      this.totalPages);

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
  Map<String, dynamic> toJson() => _$PagingToJson(this);
}
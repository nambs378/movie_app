import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging{

  @JsonValue('total_item')
  int totalItem;

  @JsonValue('per_page')
  int perPage;

  @JsonValue('current_page')
  int currentPage;

  @JsonValue('total_pages')
  int totalPages;

  Paging(this.totalItem,
      this.perPage,
      this.currentPage,
      this.totalPages);

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
  Map<String, dynamic> toJson() => _$PagingToJson(this);
}
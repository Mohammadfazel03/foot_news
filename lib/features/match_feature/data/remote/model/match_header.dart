import 'package:flutter/foundation.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_header.freezed.dart';
part 'match_header.g.dart';

@freezed
class HeaderBean with _$HeaderBean {
  const factory HeaderBean({
    @JsonKey(name: 'teams') List<TeamsBean>? teams,
    @JsonKey(name: 'status') StatusMatch? status,
  }) = _HeaderBean;

  factory HeaderBean.fromJson(Map<String, Object?> json) => _$HeaderBeanFromJson(json);
}


@freezed
class TeamsBean with _$TeamsBean {
  const factory TeamsBean({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'score') int? score,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'pageUrl') String? pageUrl,
  }) = _TeamsBean;

  factory TeamsBean.fromJson(Map<String, Object?> json) => _$TeamsBeanFromJson(json);
}
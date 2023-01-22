import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_team_match.freezed.dart';
part 'home_team_match.g.dart';

@freezed
class HomeTeamMatch with _$HomeTeamMatch {
  const factory HomeTeamMatch({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'score') int? score,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'longName') String? longName,
  }) = _HomeTeamMatch;

  factory HomeTeamMatch.fromJson(Map<String, Object?> json) => _$HomeTeamMatchFromJson(json);
}
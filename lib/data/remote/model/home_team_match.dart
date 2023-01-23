import 'package:freezed_annotation/freezed_annotation.dart';

import '../../local/collections/match_collection.dart';

part 'home_team_match.freezed.dart';

part 'home_team_match.g.dart';

@freezed
class HomeTeamMatch with _$HomeTeamMatch {
  const HomeTeamMatch._();

  const factory HomeTeamMatch({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'score') int? score,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'longName') String? longName,
  }) = _HomeTeamMatch;

  factory HomeTeamMatch.fromJson(Map<String, Object?> json) =>
      _$HomeTeamMatchFromJson(json);

  factory HomeTeamMatch.fromCollection(TeamMatchEmbedded collection) =>
      HomeTeamMatch(
          id: collection.id,
          score: collection.score,
          name: collection.name,
          longName: collection.longName);

  TeamMatchEmbedded get toCollection => TeamMatchEmbedded()
    ..name = name
    ..id = id ?? -1
    ..longName = longName
    ..score = score;
}

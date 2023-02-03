import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'against_team_match.freezed.dart';

part 'against_team_match.g.dart';

@freezed
class AgainstTeamMatch with _$AgainstTeamMatch {
  const AgainstTeamMatch._();

  const factory AgainstTeamMatch({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'score') int? score,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'longName') String? longName,
  }) = _AgainstTeamMatch;

  factory AgainstTeamMatch.fromJson(Map<String, Object?> json) => _$AgainstTeamMatchFromJson(json);

  factory AgainstTeamMatch.fromCollection(TeamMatchEmbedded collection) => AgainstTeamMatch(
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

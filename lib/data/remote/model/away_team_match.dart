import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'away_team_match.freezed.dart';

part 'away_team_match.g.dart';

@freezed
class AwayTeamMatch with _$AwayTeamMatch {
  const AwayTeamMatch._();

  const factory AwayTeamMatch({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'score') int? score,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'longName') String? longName,
  }) = _AwayTeamMatch;

  factory AwayTeamMatch.fromJson(Map<String, Object?> json) =>
      _$AwayTeamMatchFromJson(json);

  factory AwayTeamMatch.fromCollection(TeamMatchEmbedded collection) =>
      AwayTeamMatch(
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

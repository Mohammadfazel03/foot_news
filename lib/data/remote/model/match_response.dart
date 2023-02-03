import 'package:foot_news/data/remote/model/match_league.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_response.freezed.dart';

part 'match_response.g.dart';

@freezed
class MatchResponse with _$MatchResponse {
  const factory MatchResponse({
    @JsonKey(name: 'leagues') List<MatchLeague>? leagues,
    @JsonKey(name: 'date') String? date,
  }) = _MatchResponse;

  factory MatchResponse.fromJson(Map<String, Object?> json) => _$MatchResponseFromJson(json);
}

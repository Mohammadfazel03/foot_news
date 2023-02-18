import 'package:freezed_annotation/freezed_annotation.dart';

import 'match_league.dart';

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

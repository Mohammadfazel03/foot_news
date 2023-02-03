import 'package:foot_news/data/entity/match_entity.dart';

import '../../utils/data_response.dart';
import '../entity/match_league_entity.dart';
import '../remote/model/match_response.dart';

abstract class MatchRepository {
  Stream<List<MatchLeagueEntity>> getStreamMatches({
    required DateTime date,
    bool byTime = false,
    bool byOngoing = false,
    bool byFavourite = false,
  });

  Future<DataResponse<MatchResponse>> getMatches(String date);

  Future<dynamic> insertMatches(MatchResponse matches);

  Future<int> toggleFavorite(MatchEntity matchEntity);
}

import '../../utils/data_response.dart';
import '../remote/model/match_league.dart';
import '../remote/model/match_response.dart';

abstract class MatchRepository {
  Stream<List<MatchLeague>> getStreamMatches(DateTime date);

  Future<DataResponse<MatchResponse>> getMatches(String date);

  Future<dynamic> insertMatches(MatchResponse matches);
}
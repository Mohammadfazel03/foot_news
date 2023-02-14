import 'package:foot_news/common/utils/data_response.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_result.dart';

abstract class MatchDetailsRepository {
  Future<DataResponse<MatchResult>> getMatch(int matchId);
}
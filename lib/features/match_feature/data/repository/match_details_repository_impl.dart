import 'package:dio/dio.dart';
import 'package:foot_news/common/utils/data_response.dart';
import 'package:foot_news/features/match_feature/data/remote/match_api_service.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_result.dart';
import 'package:foot_news/features/match_feature/data/repository/match_details_repository.dart';

class MatchDetailsRepositoryImpl extends MatchDetailsRepository {
  final MatchApiService _api;

  MatchDetailsRepositoryImpl({required MatchApiService apiService}) : _api = apiService;

  @override
  Future<DataResponse<MatchResult>> getMatch(int matchId) async {

    try {
      Response response = await _api.getMatch(matchId);
      if (response.statusCode == 200) {
        return DataSuccess(MatchResult.fromJson(response.data));
      }
      return const DataFailed("some thing went wrong");
    } catch (e) {
      if (e is DioError) {
        return DataFailed(e.message);
      }
      return const DataFailed('some thing went wrong');
    }
  }
}

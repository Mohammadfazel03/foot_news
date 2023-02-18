import 'package:dio/dio.dart';
import 'package:foot_news/common/utils/data_response.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/data/remote/match_api_service.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_result.dart';
import 'package:foot_news/features/match_feature/data/repository/match_details_repository.dart';
import 'package:isar/isar.dart';

class MatchDetailsRepositoryImpl extends MatchDetailsRepository {
  final MatchApiService _api;
  final Isar _isar;

  MatchDetailsRepositoryImpl({required MatchApiService apiService, required Isar isar})
      : _api = apiService,
        _isar = isar;

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

  @override
  Stream<MatchDetailsCollection?> getStreamMatch(int matchId) => _isar.matchDetailsCollections
      .where()
      .matchIdEqualTo(matchId)
      .watch(fireImmediately: true)
      .asyncMap((event) => (event?.isEmpty ?? true) ? null : event.first);

  @override
  Future<int> insertMatch(MatchResult match) =>
      _isar.writeTxn(() => _isar.matchDetailsCollections.putByMatchId(match.toCollection));
}

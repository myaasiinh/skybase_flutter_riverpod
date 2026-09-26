import 'package:skybase/config/base/base_repository.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/core/errors/failures.dart';
import 'package:skybase/core/mixin/repository_handler_mixin.dart';
import 'package:skybase/core/network/result.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart' as model;
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart' as entity;
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

class SampleFeatureRepositoryImpl extends BaseRepository
    with RepositoryHandlerMixin
    implements ISampleFeatureRepository {
  final SampleFeatureSources apiService;

  SampleFeatureRepositoryImpl({
    required this.apiService,
    required super.storageManager,
  });

  @override
  Future<Result<List<entity.SampleFeature>, AppFailure>> getUsers({
    required RequestParams requestParams,
    required int page,
    required int perPage,
    String? username,
  }) async {
    return safeCall(() async {
      final response = await loadCachedList<model.SampleFeature>(
        cachedKey: requestParams.cachedKey.toString(),
        page: page,
        onLoad: () async => await apiService.getUsers(
          cancelToken: requestParams.cancelToken,
          page: page,
          perPage: perPage,
          username: username,
        ),
      );
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Result<entity.SampleFeature, AppFailure>> getDetailUser({
    required RequestParams requestParams,
    required int id,
    required String username,
  }) async {
    return safeCall(() async {
      final response = await loadCached<model.SampleFeature>(
        cachedKey: requestParams.cachedKey.toString(),
        cachedId: requestParams.cachedId,
        onLoad: () async {
          final res = await apiService.getDetailUser(
            cancelToken: requestParams.cancelToken,
            username: username,
          );
          final followers = await apiService.getFollowers(
            cancelToken: requestParams.cancelToken,
            username: username,
          );
          final followings = await apiService.getFollowings(
            cancelToken: requestParams.cancelToken,
            username: username,
          );
          final repos = await apiService.getRepos(
            cancelToken: requestParams.cancelToken,
            username: username,
          );

          // We use dynamic or manual field setting since copyWith is not generated yet
          // In a real scenario, this would be generated.
          return (res as dynamic).copyWith(
            followersList: followers,
            followingList: followings,
            repositoryList: repos,
          );
        },
      );
      return (response as dynamic).toEntity();
    });
  }
}

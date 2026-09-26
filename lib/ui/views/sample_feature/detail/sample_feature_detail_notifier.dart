import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/core/network/result.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

final sampleFeatureDetailProvider = AutoDisposeAsyncNotifierProviderFamily<
    SampleFeatureDetailNotifier, SampleFeature, SampleFeatureDetailArgs>(
  SampleFeatureDetailNotifier.new,
);

class SampleFeatureDetailArgs {
  final int userId;
  final String username;

  SampleFeatureDetailArgs({required this.userId, required this.username});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SampleFeatureDetailArgs &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          username == other.username);

  @override
  int get hashCode => userId.hashCode ^ username.hashCode;
}

class SampleFeatureDetailNotifier extends AutoDisposeFamilyAsyncNotifier<
    SampleFeature, SampleFeatureDetailArgs> {
  late final ISampleFeatureRepository _repository;
  late final CancelToken _cancelToken;

  @override
  Future<SampleFeature> build(SampleFeatureDetailArgs arg) async {
    _repository = ref.read(sampleFeatureRepositoryProvider);
    _cancelToken = CancelToken();

    ref.onDispose(() {
      _cancelToken.cancel();
    });

    return _getDetailUser(
      userId: arg.userId,
      username: arg.username,
    );
  }

  Future<SampleFeature> _getDetailUser({
    required int userId,
    required String username,
  }) async {
    final result = await _repository.getDetailUser(
      requestParams: RequestParams(cancelToken: _cancelToken),
      id: userId,
      username: username,
    );

    return result.fold(
      (user) => user,
      (failure) => throw failure,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _getDetailUser(
        userId: arg.userId,
        username: arg.username,
      ),
    );
  }
}

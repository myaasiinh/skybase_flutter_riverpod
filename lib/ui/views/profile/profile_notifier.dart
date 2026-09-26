import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skybase/domain/entities/user/user.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

final profileProvider = AsyncNotifierProvider.autoDispose<ProfileNotifier, User>(ProfileNotifier.new);

class ProfileNotifier extends AutoDisposeAsyncNotifier<User> {
  late final IAuthRepository _repository;
  late final CancelToken _cancelToken;

  @override
  Future<User> build() async {
    _repository = ref.read(authRepositoryProvider);
    _cancelToken = CancelToken();

    ref.onDispose(() {
      _cancelToken.cancel();
    });
    return _getProfile();
  }

  Future<User> _getProfile() async {
    final result = await _repository.getProfile(cancelToken: _cancelToken);

    return result.fold(
      (user) => user,
      (failure) => throw failure,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getProfile);
  }
}

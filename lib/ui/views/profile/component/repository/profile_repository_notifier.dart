import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

final profileRepositoryProvider = AsyncNotifierProvider.autoDispose<ProfileRepositoryNotifier, List<Repo>>(ProfileRepositoryNotifier.new);

class ProfileRepositoryNotifier extends AutoDisposeAsyncNotifier<List<Repo>> {
  late final CancelToken _cancelToken;

  @override
  Future<List<Repo>> build() async {
    _cancelToken = CancelToken();
    ref.onDispose(() {
      _cancelToken.cancel();
    });

    return _getProfileRepository();
  }

  Future<List<Repo>> _getProfileRepository() async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.getProfileRepository(
      cancelToken: _cancelToken,
      username: 'nandakista',
    );

    return result.fold(
      (items) => items,
      (failure) => throw failure,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getProfileRepository);
  }
}

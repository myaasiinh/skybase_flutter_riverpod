import 'package:dio/dio.dart';
import 'package:skybase/core/errors/failures.dart';
import 'package:skybase/core/mixin/repository_handler_mixin.dart';
import 'package:skybase/core/network/result.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';
import 'package:skybase/domain/entities/repo/repo.dart' as entity_repo;
import 'package:skybase/domain/entities/user/user.dart' as entity;
import 'package:skybase/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with RepositoryHandlerMixin implements IAuthRepository {
  final AuthSources apiService;

  AuthRepositoryImpl({required this.apiService});

  @override
  Future<Result<entity.User, AppFailure>> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      final response = await apiService.login(
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );
      return response.toEntity();
    });
  }

  @override
  Future<Result<entity.User, AppFailure>> getProfile({CancelToken? cancelToken}) async {
    return safeCall(() async {
      final response = await apiService.getProfile(
        cancelToken: cancelToken ?? CancelToken(),
        username: 'placeholder',
      );
      return response.toEntity();
    });
  }

  @override
  Future<Result<List<entity_repo.Repo>, AppFailure>> getProfileRepository({
    CancelToken? cancelToken,
    required String username,
  }) async {
    return safeCall(() async {
      final response = await apiService.getProfileRepository(
        cancelToken: cancelToken ?? CancelToken(),
        username: username,
      );
      return response.map((e) => e.toEntity()).toList();
    });
  }
}

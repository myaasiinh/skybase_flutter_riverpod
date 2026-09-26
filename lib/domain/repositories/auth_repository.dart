import 'package:dio/dio.dart';
import 'package:skybase/core/errors/failures.dart';
import 'package:skybase/core/network/result.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/user/user.dart';

abstract class IAuthRepository {
  Future<Result<User, AppFailure>> login({
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<Result<User, AppFailure>> getProfile({CancelToken? cancelToken});

  Future<Result<List<Repo>, AppFailure>> getProfileRepository({
    CancelToken? cancelToken,
    required String username,
  });
}

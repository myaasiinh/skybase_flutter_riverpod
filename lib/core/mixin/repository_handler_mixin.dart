import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skybase/core/errors/failures.dart';
import 'package:skybase/core/network/result.dart';

mixin RepositoryHandlerMixin {
  Future<Result<T, AppFailure>> safeCall<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return Success(response);
    } on DioException catch (e) {
      return FailureResult(_handleDioError(e));
    } catch (e) {
      return FailureResult(UnknownFailure(e.toString()));
    }
  }

  AppFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';
        return ServerFailure(message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const UnknownFailure('Request cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      default:
        if (error.error is SocketException) {
          return const NetworkFailure('No internet connection');
        }
        return UnknownFailure(error.message ?? 'Unknown error occurred');
    }
  }
}

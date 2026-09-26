import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/network/api_config.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/utils/app_logger.dart';

import 'api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
final apiInterceptorsProvider = Provider<ApiInterceptors>((ref) {
  final authManager = ref.read(authManagerProvider.notifier);
  final secureStorage = ref.read(secureStorageManagerProvider); 
  final dio = ref.read(dioProvider);
  return ApiInterceptors(
      dio: dio,
      authManager: authManager,
      secureStorage: secureStorage
  );
});

final class ApiInterceptors extends ApiTokenManager
    implements QueuedInterceptorsWrapper {
  ApiInterceptors({
    required this.dio,
    required super.authManager,
    required super.secureStorage,
  });

  final Dio dio;

  @override
  Future<dynamic> onRequest(options, handler) async {
    if (kDebugMode) {
      AppLogger.i('''
# REQUEST
--> ${options.method.toUpperCase()} - ${options.uri}
Headers: ${options.headers}
Query Params: ${options.queryParameters}
Body: ${options.data}''');
    }
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(Response response, handler) async {
    if (kDebugMode) {
      AppLogger.i('''
# RESPONSE
<-- ${(response.requestOptions.uri)}
Status Code : ${response.statusCode}
Response: ${response.data}''');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioException err, handler) async {
    if (kDebugMode) {
      AppLogger.e('''
# ERROR
<-- ${err.response?.requestOptions.baseUrl}
Status Code : ${err.response?.statusCode} 
Error Message : ${err.message} 
Response Path : ${err.response?.requestOptions.uri}''', err, err.stackTrace);
    }
    handleToken(
      dio: dio,
      err: err,
      handler: handler,
    );
  }
}

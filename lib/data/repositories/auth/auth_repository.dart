import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';

import 'auth_repository_impl.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final apiService = ref.watch(authSourcesProvider);
  return AuthRepositoryImpl(apiService: apiService);
});

